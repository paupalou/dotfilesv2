#!/bin/bash

## Foreground
# default color
def='\e[39m'

# 8 Colors
black='\e[30m'
red='\e[31m'
green='\e[32m'
yellow='\e[33m'
blue='\e[34m'
magenta='\e[35m'
cyan='\e[36m'
lgray='\e[37m'

# 16 Colors
dgray='\e[90m'
lred='\e[91m'
lgreen='\e[92m'
lyellow='\e[93m'
lblue='\e[94m'
lmagenta='\e[95m'
lcyan='\e[96m'
white='\e[97m'

## Background
# 8 Colors
# default bg color
defbg='\e[49m'
blackbg='\e[40m'
redbg='\e[41m'
greenbg='\e[42m'
yellowbg='\e[43m'
bluebg='\e[44m'
magentabg='\e[45m'
cyanbg='\e[46m'
lgraybg='\e[47m'

# 16 Colors
dgraybg='\e[100m'
lredbg='\e[101m'
lgreenbg='\e[102m'
lyellowbg='\e[103m'
lbluebg='\e[104m'
lmagentabg='\e[105m'
lcyanbg='\e[106m'
whitebg='\e[107m'

# used to reset attributes
normal='\e[0m'
bold='\e[1m'
uline='\e[4m'
inverted='\e[7m'

################################
# Print a colored message      #
# Arguments:                   #
#  $1 message                  #
#  $2 color and/or textstyle   #
################################
pc () {
	local default_msg="No message passed."
	# Doesn't really need to be a local variable.

	message=${1:-$default_msg}
	# Defaults to default message.
	color=${2:-$black}
	# Defaults to black, if not specified.

	printf "$color$message$normal"
	# Reset to normal.

	return
}

function _header {
	printf "\r$1\n"
}

function _child {
	printf "\r$1"
}

function _subchild {
	local lblue="\e[94m"
	local lgray="\e[37m"
	local lcyan="\e[96m"
	local lyellow="\e[93m"
	local normal="\e[0m"
	local uline="\e[4m"
  local is_package_dependency=$4

  if [ -z "$is_package_dependency" ]; then
    _child "$(pc "│" $lblue)   $(pc ∷ $lgray)  ${lcyan}$1 ${uline}${lyellow}$2${normal} $3 ..."
  else
    _child "$(pc "│   ├──" $lblue) $(pc ∷ $lgray)  ${lcyan}$1 ${uline}${lyellow}$2${normal} $3 ..."
  fi
}


function _start {
	local lblue="\e[94m"
	_header "$(pc "┌──── $bold$1" $lblue)" 
}

function _end {
	local lblue="\e[94m"
	_header "$(pc "└───────────────" $lblue)" 
	echo
}

function print_dependency_success {
	local lblue="\e[94m"
	local green="\e[32m"
	local cyan="\e[36m"
	local bold="\e[1m"
  local is_package_dependency=$3
  local is_last_item=$4

  if [ -z "$is_package_dependency" ]; then
    _child "$(pc "│" $lblue) $(pc "✓" $green$bold) $(printf "%-50s\n" $(pc "${1}" $lgreen)) version $(pc $2 $cyan)\n"
  else
    local character=└
    if [ -z ${is_last_item} ]; then
      local character=├
    fi
    _child "$(pc "│   $character──" $lblue) $(pc "✓" $green$bold) $(printf "%-44s\n" $(pc "${1}" $lgreen)) version $(pc $2 $cyan)\n"
  fi

}

function print_dependency_failed {
	local lblue="\e[94m"
	local red="\e[31m"
	local bold="\e[1m"
	local normal="\e[0m"
  local is_package_dependency=$2

  if [ -z "$is_package_dependency" ]; then
    _child "$(pc "│" $lblue) $(pc "✗" $red$bold) $1 $bold${red}not ${normal}installed\n"
  else
    _child "$(pc "│   ├──" $lblue) $(pc "✗" $red$bold) $1 $bold${red}not ${normal}installed\n"
  fi
}

function print_installing {
	_subchild "installing" $1 "from $2" $3
}

function print_adding_repository {
	_subchild "adding" $1 "repository"
}

function print_help_option {
  printf "$(printf "%-40s\n" "$bold $1")$normal $2\n"
}

function user {
  local character=└
  if [ -z ${is_last_item} ]; then
    local character=├
  fi
  _child "$(pc "│ $character──" $lblue) [$(pc ' ? ' $yellow)] $1\n"
}

function user_option {
  _child "$(pc "│" $lblue) $(pc "│" $lblue)         $1\n"
# $(pc │ $lblue)         ├─› [${bold}s${normal}]kip ──────── [${bold}S${normal}]kip all
}

function warn {
  local character=└
  if [ -z ${is_last_item} ]; then
    local character=├
  fi
  _child "$(pc "│ $character──" $lblue) [$(pc ' ! ' $lred)] $1\n"
}

function success {
  # printf "\r   $(pc "├$2─›" $lblue) [$(pc ' ✓ ' $green)] $1\n"
  # printf "\r   $(pc "├$2─›" $lblue) [$(pc ' ✓ ' $green)] $1\n"
  # _child "$(pc "│" $lblue) [ $(pc "$1 $2" $yellow) ]\n"

  local character=└
  if [ -z ${is_last_item} ]; then
    local character=├
  fi
  _child "$(pc "│ $character──" $lblue) [$(pc ' ✓ ' $green)] $1\n"
}

subfolder_title () {
  _child "$(pc "│" $lblue) [ $(pc "$1 $2" $yellow) ]\n"
}

spinner() {
    local -a spinarr=('⊶ ' '⊷ ')
    # local delay=0.25
    
    #Some other spinners from the awesome sindresorhus' cli-spinners (https://github.com/sindresorhus/cli-spinners)
    # local -a spinarr=('⣾' '⣽' '⣻' '⢿' '⡿' '⣟' '⣯' '⣷')
    # local -a spinarr=('⢀⠀' '⡀⠀' '⠄⠀' '⢂⠀' '⡂⠀' '⠅⠀' '⢃⠀' '⡃⠀' '⠍⠀' '⢋⠀' '⡋⠀' '⠍⠁' '⢋⠁' '⡋⠁' '⠍⠉' '⠋⠉' '⠋⠉' '⠉⠙' '⠉⠙' '⠉⠩' '⠈⢙' '⠈⡙' '⢈⠩' '⡀⢙' '⠄⡙' '⢂⠩' '⡂⢘' '⠅⡘' '⢃⠨' '⡃⢐' '⠍⡐' '⢋⠠' '⡋⢀' '⠍⡁' '⢋⠁' '⡋⠁' '⠍⠉' '⠋⠉' '⠋⠉' '⠉⠙' '⠉⠙' '⠉⠩' '⠈⢙' '⠈⡙' '⠈⠩' '⠀⢙' '⠀⡙' '⠀⠩' '⠀⢘' '⠀⡘' '⠀⠨' '⠀⢐' '⠀⡐' '⠀⠠' '⠀⢀' '⠀⡀')
    # local -a spinarr=('⠁' '⠉' '⠙' '⠚' '⠒' '⠂' '⠂' '⠒' '⠲' '⠴' '⠤' '⠄' '⠄' '⠤' '⠴' '⠲' '⠒' '⠂' '⠂' '⠒' '⠚' '⠙' '⠉' '⠁')
    # local -a spinarr=('◢' '◣' '◤' '◥')
    # local -a spinarr=('▹▹▹▹▹' '▸▹▹▹▹' '▹▸▹▹▹' '▹▹▸▹▹' '▹▹▹▸▹' '▹▹▹▹▸')
    local delay=0.15
    
    
    local i=0
    while [ "$(ps a | awk '{print $1}' | grep $1)" ]; do
        local str="$2 ${spinarr[$(( $i % ${#spinarr[@]} ))]}"
        printf "%s" "$str"
        i=$(($i+1))
        sleep $delay
        for (( j=0; $j < ${#str}; j++ )); do printf "\b"; done;
    done
    for (( j=0; $j < ${#str}; j++ )); do printf "\b"; done;echo;
}
