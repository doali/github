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
			echo "Error ${repository} does not exist"
		fi
		cd - >/dev/null
	done
}

usage()
{
	echo "Usage:"
	echo -e "\t$(basename $0)"
	echo -e "\t$(basename $0) --file <file_lst_repo>"
	echo -e "\t$(basename $0) --help"
}

# =========================================
if [ ${#} -eq 0 ]; then
	if [ -f ${LST_REPO} ]; then
		main ${LST_REPO}
	else
		usage
	fi
else
	if [ ${#} -ge 3 ]; then
    usage
  else
    case "${1}" in
      -h|--h|-help|--help)
        usage
        ;;
      --file)
        if [ ${#} -eq 2 ]; then
          if [ -f $2 ]; then
            main $2
          else
            echo "Error $2 does not exist"
          fi
        else
          usage
        fi
        ;;
      *)
        usage
        ;;
    esac
	fi
fi
