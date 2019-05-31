t=$(git status)
echo "#######################################################################################"
echo "$t"
echo "#######################################################################################"

/bin/echo -n "everything OK? (y/n):" 
read ans
if [ "y" != "$ans" ]; then
	echo "###############\nshell exit by user\n###############\n"
	exit 0 
else
	echo "#######################################################################################"
	read -p "files you want to track(if no type, default to all):" files
	if [ -z "$files" ]; then
		git add .
	else
		git add "$files"
	fi
	echo "#######################################################################################"
	read -p "typo commit message:" msg
	git commit -m "$msg"

    read -p "set a tag if needed:" tag
    if [ ! -z "$tag" ]; then
        git tag "$tag"
    fi

    read -p "ready to push?(y/n):" ready
    if [ "y" != "$ready" ]; then
        echo "###############\nshell exit by user\n###############\n"
        exit 0
    fi
    branches=$(git branch)
    echo "#######################################################################################"
    echo "you own these branches:"
    echo "$branches"
    echo "#######################################################################################"
    read -p "which branch you want to push:" branch

    if [ ! -z "$tag" ]; then
    git push origin $branch --tags
    else
    git push origin $branch
    fi

fi
echo "shell excuted"
