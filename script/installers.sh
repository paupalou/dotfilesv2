#!/bin/bash

source ./script/yaml_parser.sh
source ./script/print_utils.sh

function _check_sudo {
  if ! command -v sudo &> /dev/null; then
    echo "sudo is not installed, install it (as root)"
    exit 1
  fi
}

function _set_localtime {
  local localtime_file=/etc/localtime
  if [ ! -f "$localtime" ]; then
    local TZ=Europe/Madrid
    sudo ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
  fi
}

function _get_value {
  local prop=$1_$2
  local value=${!prop}
  if [ -n "$value" ]; then
    echo $value
  else
    echo $3
  fi
}

function _is_checker_loaded {
  declare -F "_is_${1}_installed" > /dev/null
}

function _is_installer_loaded {
  declare -F "_install_${1}_from_${2}" > /dev/null
}

function _install_item {
  local item=$1
  local is_subitem=$2
  local is_last_item=$3
  local should_install=true

  local name=$(_get_value $item "name")
  local from=$(_get_value $item "from" $package_manager)
  local type=$(_get_value $item "type" $package_type)
  local arch=$(_get_value $item "arch" $package_arch)
  local bin=$(_get_value $item "bin")
  local repository=$(_get_value $item "repository")
  local release=$(_get_value $item "release")
  local path=$(_get_value $item "path")
  local run=$(_get_value $item "run")

  if ! _is_checker_loaded $type; then
    local checker=./script/$type.checker.sh
    if [ -f "$checker" ]; then
      source $checker
    fi
  fi

  if _is_package_installed "$name" "$type" "$bin" "$is_subitem" "$is_last_item" ; then
    should_install=false
  fi

  local depends=${item}_depends_
  if [ -n "${!depends}" ]; then
    local index=1
    local dependencys=${!depends}
    local num_deps=$(echo "${dependencys}" | wc -w)
    for dependency in ${!depends}; do
      index=$(( index+1 ))
      local is_last_item
      if [ "$index" -gt "$num_deps" ];then
        is_last_item=true
      fi
      _install_item $dependency true $is_last_item
    done
  fi

  local hooks=${item}_hooks_
  local pre_hooks
  local post_hooks
  if [ -n "${!hooks}" ]; then
    local num_hooks=$(echo "${!dependencys}" | wc -w)
    echo $num_hooks
    for hook in ${!hooks}; do
      pre_hooks=$(_get_value $hook "pre")
      post_hooks=$(_get_value $hook "post")
      echo $post_hooks
      for post_hook in ${!post_hooks}; do
        echo post $post_hook
      done
    done
  fi

  if [ "$should_install" = true ]; then
    if ! _is_installer_loaded $type $from; then
      source ./script/$type.installer.from.$from.sh
    fi

    if [ -n "$pre_hooks" ]; then
      echo 'installing pre_hooks'
    fi

    _install_${type}_from_${from} "$name" "$repository" "$release" "$path" "$run" "$is_subitem" "$arch"

    echo $post_hooks
    if [ -n "$post_hooks" ]; then
      echo 'installing post_hooks'
    fi
  fi
}

function _install_category_items {
  local category=$1
  local items=${category}_
  if [ -z "${!items}" ]; then
    return 0
  fi

  _start $category

  for item in ${!items}; do
    _install_item $item
  done

  _end $category
}

function _run_command {
  eval "$1" &>/dev/null
}

function _is_package_installed {
  local package=$1
  local type=$2
  local bin=$3
  local is_subitem=$4
  local is_last_item=$5
  local version

  if [ -z "$bin" ]; then
    version=$(_is_${type}_installed $package)
  else
    [ -f "$bin" ] && version="$($bin --version | head -1 | grep -o -e '[0-9]\+\(\.[0-9]\+\)*' | head -1)"
  fi

  if [ -z "$version" ]; then
    print_dependency_failed $package $is_subitem
    return 1
  fi

  print_dependency_success $package $version $is_subitem $is_last_item
  return 0
}

function _install_source_from_github {
  local name=$1
  local repository=$2
  local destination_path=$4
  local run=$5

  print_installing $name "github"
  git clone --depth 1 https://github.com/${repository}.git ${destination_path} &>/dev/null
  command $destination_path/$run &>/dev/null

  echo $(pc "  ✓" $green$bold)
}

function _install_binary_from_curl {
  local name=$1
  local run=$5

  print_installing $name "curl"

  _run_command "$run"

  echo $(pc "  ✓" $green$bold)
}

function _install {
  eval $(parse_yaml install.yml)
  _check_sudo
  _set_localtime
  local category_group

  if [ -z "$1" ]; then
    category_group=$__
  else
    category_group=$1
  fi

  for category in $category_group; do
    _install_category_items $category
  done
}
