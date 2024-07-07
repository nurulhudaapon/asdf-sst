#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/sst/ion"
TOOL_NAME="sst"
TOOL_TEST="sst version"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
# YELLOW='\033[1;33m'
ORANGE='\033[38;2;255;140;0m'
NC='\033[0m' # No Color

fail() {
	echo -e "${RED}asdf-$TOOL_NAME: $*${NC}"
	exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if sst is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
	git ls-remote --tags --refs "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
	# TODO: Adapt this. By default we simply list the tag names from GitHub releases.
	# Change this function if sst has other means of determining installable versions.
	list_github_tags
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"
	platform="$3"

	echo -e "${ORANGE}Downloading $TOOL_NAME release $version...${NC}"
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# TODO: Assert sst executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo -e "${GREEN}$TOOL_NAME $version installation was successful!${NC}"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}

get_platform() {
	os=$(uname -s | tr '[:upper:]' '[:lower:]')
	if [[ "$os" == "darwin" ]]; then
		os="mac"
	fi
	arch=$(uname -m)

	if [[ "$arch" == "aarch64" ]]; then
		arch="arm64"
	fi

	platform="$TOOL_NAME-$os-$arch"

	case "$platform" in
	*"-linux-"*)
		[[ "$arch" == "x86_64" || "$arch" == "arm64" || "$arch" == "i386" ]] || exit 1
		;;
	*"-mac-"*)
		[[ "$arch" == "x86_64" || "$arch" == "arm64" ]] || exit 1
		;;
	*)
		echo -e "${RED}Unsupported OS/Arch: $os/$arch${NC}"
		exit 1
		;;
	esac

	echo "$platform"
}
