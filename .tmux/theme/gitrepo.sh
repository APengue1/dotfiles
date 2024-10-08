#!/bin/sh

pane_current_path=$1
git_remote_url=$(git -C $pane_current_path remote get-url origin 2>/dev/null)

if [ -z "$git_remote_url" ]; then
	# not in a git directory, just show the directory
	basename $pane_current_path;
	exit;
fi

if [ -n "$(echo $git_remote_url | grep 'http')" ]; then
		# http(s) git remote
		org_repo=$(echo $git_remote_url | awk -F/ '{print $(NF-1) FS $(NF)}')
else
		# ssh git remote
		org_repo=$(echo $git_remote_url | awk -F: '{ print $NF }')
fi

echo $org_repo | sed 's/.git//' | tr "[:upper:]" "[:lower:]"
