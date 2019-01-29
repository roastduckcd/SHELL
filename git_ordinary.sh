t=$(git status)
echo "$t"
echo "#######################################################################################"
/bin/echo -n "everything OK? (y/n):" 
read ans
if [ "n" == "$ans" ]; then
	echo "###############\nshell exit by user\n###############\n"
	exit 0 
else
	git add .
	echo "#######################################################################################"
	read -p "				typo commit message:" msg
	git commit -m "$msg"
	branches=$(git branch)
	echo "#######################################################################################"
	echo "				you own these branches:"
	echo "						$branches"
	echo "#######################################################################################"
	read -p "which branch you want to push:" branch
	git push origin $branch
fi
echo "shell excuted"
