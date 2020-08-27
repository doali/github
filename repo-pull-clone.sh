#!/bin/bash

# =========================================
# Given a file containing repositories
# - if repo exists then pull
# - else clone
# in the working directory
# -----------------------------------------
# samedi 28 mars 2020, 15:19:29 (UTC+0100)
# =========================================

readonly URL_GITHUB=https://github.com/doali
readonly LST_REPO=repo-list-github

pull()
{
	local repository="$1"

	echo -e "\033[01;34m${repository}\033[00m processing..."

	pushd ${repository} > /dev/null
	git pull --no-rebase
	popd > /dev/null
}

clone()
{
	local repository="$1"
	local url_repo=${URL_GITHUB}/${repository}.git
	git clone ${url_repo}
}

main()
{
	for repository in $(cat $1)
	do
		cd .. > /dev/null
		if [ -d "${repository}" ]; then
			pull ${repository}
		else
			clone ${repository}
		fi
		cd - > /dev/null
	done
}

usage()
{
	echo "Usage: $(basename $0) <file_lst_repo>"
}

# =========================================
if [ ${#} -eq 0 ]; then
	if [ -f ${LST_REPO} ]; then
		main ${LST_REPO}
	else
		usage
	fi
else
	if [ ${#} -eq 1 ]; then
		if [ -f $1 ]; then
			main $1
		else
			echo "Error $1 does not exist"
		fi
	else
		usage
	fi
fi

