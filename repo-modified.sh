#!/bin/bash

# =========================================
# Given a file containing repositories
# - if changes exist then notify
# from the working directory
# -----------------------------------------
# lundi 30 mars 2020, 17:25:12 (UTC+0200)
# =========================================

readonly URL_GITHUB=https://github.com/doali
readonly LST_REPO=repo-list-github

git_status()
{
	local repository="$1"

	pushd ${repository} > /dev/null

	local nb_commit=$(git checkout | grep "by\ [0-9]*" | cut -d\  -f 8)
	local info="\033[01;34m${repository}\033[00m processed..."

	if [ -z "${nb_commit}" ]; then
		echo -e ${info}
	else
		echo -e "${info}  \033[0;34m--(°v°)~> [${nb_commit}]\033[00m"
	fi

	git status -s
	popd > /dev/null
}

main()
{
	for repository in $(cat $1)
	do
		cd .. >/dev/null
		if [ -d "${repository}" ]; then
			git_status ${repository}
		else
			echo "Error ${repositories} does not exist"
		fi
		cd - >/dev/null
	done
}

usage()
{
	echo "Usage:"
	echo -ne "\t$(basename $0) <file_lst_repo>"
	echo -ne "\t$(basename $0)"
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

