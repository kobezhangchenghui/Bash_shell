#!/bin/bash

CUR_PATH=`pwd`
trytimes=3


function runScript(){
	read -p "This tool will excuting cmd on remote host,do you want to continue?(y/n)" choose
	case $choose in
	y|Y)
		continue
		;;
	n|N)
		exit
		;;
	*)
		echo "please input y/n"
		runScript
		;;
	esac	
}

function checkPasswd(){
	read -s -p "Please input root password:" rootpasswd1
	echo
	read -s -p "Please input root password again:" rootpasswd2
	if [ "$rootpasswd1"x != "$rootpasswd2"x ];then
		echo
		echo "The passwords are not the same,please try again!"
		trytimes=$[ $trytimes-1 ]
		if [ $trytimes -eq 0 ];then
			echo "You have try more than 3 times!"
			exit 1
		fi
		checkPasswd
	else
		rootpasswd=$rootpasswd1
	fi
}

function runCmd(){
	read -p "Please input the remoteIP:" remoteIP
	if [ -f ${CUR_PATH}/expect.exp ];then
		expect expect.exp root $rootpasswd $remoteIP
	else
		echo "expect.exp is not exist!"
	fi
}

function main(){
	runScript
	checkPasswd
	runCmd
}
main @
