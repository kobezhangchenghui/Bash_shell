#! /bin/bash
#判断一个数是否是素数

function is_prime()
{
	flag=0
	num=$1
	
	for((i=2;i<$num;i++))
	do
		if [ $(($num%$i)) -eq 0 ];then
			flag=1
			break
		fi
	done
	
	return $flag
}

function main()
{
	read -p "Please input a number:" n
	is_prime $n
	if [ $? -eq 0 ];then
		echo "It is a prime number"
	else
		echo "It is not a prime number"
	fi
}
main @
