export LC_CTYPE=C
export LANG=C

# 判断参数
sed_delete(){
	if [ -z "$1" -o -z "$2" ];then
		echo "=================="
		echo "need a file name"
		echo "=================="
		return
	fi
	echo "注意：该命令会删除所有匹配字符的行"
	echo "即将删除："$2" 文件中匹配  "$1"  字符串的所有行"
	read -p "参数格式:待删除匹配字符 文件名(如有空格请使用双引号),是否继续(y/n):" ans
	if [ "n" == "$ans" ];then 
		echo "ended by user"
		return
	fi
	sed -i -n "/"$1"/d" "$2"
}

sed_delete "$1" "$2"
