#待测试: grep "test\>" /proc/[0-9]*/cmdline | grep -o "[0-9]\+"  这样也能够得到所有test的进程ID #

pid=$(ps -e | grep tcprelay | grep -v grep | awk '{print $1}' | sed -n '2p')
echo $pid
if [ ! -z "$pid" ];then
	echo "$(ps -e | grep tcprelay | grep -v grep)"
	read -p "are you sure to kill $pid.(y/n)" ans
	if [ "n" == $ans ];then
		echo "command ended by user"
		exit 0
	else
		sudo kill -9 $pid
	fi
else 
	echo "empty pid, seems there is no such progress"
fi
