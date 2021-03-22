function _install_deb_from_github {
	local package_name=$1
	local repository=$2
  local arch=$8
	print_installing $repository "github"
	local latest_release=$(curl --silent "https://api.github.com/repos/$repository/releases/latest" |
		grep '"tag_name":' |
		sed -E 's/.*"([^"]+)".*/\1/')

	local package_file=${package_name}_${latest_release}_${arch}.deb
	if [ ${latest_release:0:1} = v ]; then
		# in case we curl version like v1.2.3 remove the v
		package_file=${package_name}_${latest_release:1}_${arch}.deb
	fi

	wget https://github.com/$repository/releases/download/$latest_release/$package_file &>/dev/null

	sudo dpkg -i $package_file 1>/dev/null
	rm $package_file

	echo $(pc "  ✓" $green$bold)
}

