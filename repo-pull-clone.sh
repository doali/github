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

	echo -ne "${repository}"
	pushd ${repository} > /dev/null
	echo -ne " <- "
	git pull
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
		cd ..
		if [ -d "${repository}" ]; then
			pull ${repository}
		else
			clone ${repository}
		fi
		cd -
	done
}

usage()
{
	echo "Usage: $(basename $0) <file_lst_repo>"
}

# ==================================
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

