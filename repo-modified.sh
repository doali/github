#!/bin/bash

# =========================================
# Given a file containing repositories
# - if changes exist then notify
# from the working directory
# -----------------------------------------
# samedi 28 mars 2020, 15:19:29 (UTC+0100)
# =========================================

readonly URL_GITHUB=https://github.com/doali
readonly LST_REPO=repo-list-github

git_status()
{
	local repository="$1"

	pushd ${repository} > /dev/null
	echo -e "${repository} processed..."
	git status -s
	popd > /dev/null
}

main()
{
	for repository in $(cat $1)
	do
		cd ..
		if [ -d "${repository}" ]; then
			git_status ${repository}
		else
			echo "Error ${repositories} does not exist"
		fi
		cd -
	done
}

usage()
{
	echo "Usage:"
	echo -ne "\t$(basename $0) <file_lst_repo>"
	echo -ne "\t$(basename $0)"
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

