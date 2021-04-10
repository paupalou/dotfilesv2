#!/bin/bash

function _install_pkg.tar.zst_from_pacman {
  local package_name=$1
  local repository=$2
  local run=$5
  local is_package_dependency=$6

  # if [ -n "$repository" ]; then
  #   local is_ppa_added=$(apt-cache policy | grep -q $repository)
  #   if [ -z $is_ppa_added ]; then
  #     print_adding_repository $repository
  #     sudo add-apt-repository ppa:$repository -y 1>/dev/null
  #     sudo apt-get update -y 1>/dev/null
  #     echo $(pc "  ✓" $green$bold)
  #   fi
  # fi

  # if [ -n "$run" ]; then
  #   _run_command "$run"
  # fi

  print_installing $package_name "pacman" $is_package_dependency
  # local debconf_warning="debconf: delaying package configuration, since apt-utils is not installed"
  # local templates_warning="Extracting templates from packages: 100%"

  sudo pacman -S -y $1

  echo $(pc "  ✓" $green$bold)
}
