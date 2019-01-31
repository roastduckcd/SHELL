t=$(git status)
echo "#######################################################################################"
echo "$t"
echo "#######################################################################################"
/bin/echo -n "everything OK? (y/n):" 
read ans
if [ "n" == "$ans" ]; then
	echo "###############\nshell exit by user\n###############\n"
	exit 0 
else
	echo "#######################################################################################"
	read -p "files you want to track(if no type, default to all):" files
	if [ -z "$files" ];then
		git add .
	else
		git add "$files"
	fi
	echo "#######################################################################################"
	read -p "typo commit message:" msg
	git commit -m "$msg"
	branches=$(git branch)
	echo "#######################################################################################"
	echo "you own these branches:"
	echo "$branches"
	echo "#######################################################################################"
	read -p "which branch you want to push:" branch
	git push origin $branch
fi
echo "shell excuted"
