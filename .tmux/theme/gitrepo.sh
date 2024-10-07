#!/bin/sh

pane_current_path=$1
git_remote_url=$(git -C $pane_current_path remote get-url origin)

if [ -n "$(echo $git_remote_url | grep 'http')" ]; then
		# http(s) git remote
		org_repo=$(echo $git_remote_url | awk -F/ '{print $(NF-1) FS $(NF)}')
else
		# ssh git remote
		org_repo=$(echo $git_remote_url | awk -F: '{ print $NF }')
fi

echo $org_repo | sed 's/.git//' | tr "[:upper:]" "[:lower:]"
