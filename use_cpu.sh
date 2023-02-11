#!/bin/bash

# 构造死循环代码占用一个CPU
endless_loop() {
  echo -ne "i=0; while true ;do i=i+100; i=100;done" | /usr/bin/bash &
}

# 校验参数个数
if [ $# != 2 ]; then
  echo "USAGE: $0 <cpus,sleep time>"
  exit 1
fi

# 根据第一个参数循环执行endless_loop占用CPU，并将进程id存入数组
for i in $(seq $1); do
  endless_loop
  pid_array[$i]=$!
done

# 界面给出提示，并将kill 进程id命令重定向到/root/file.txt文件中
for i in "${pid_array[@]}"; do
  echo 'execute: kill' $i
  echo 'kill' $i >>/root/file.txt
done

# 给出提示，本次脚本需要执行多少秒，如果想提前结束脚本执行ctrl+C，并且要手动去kill掉进程
echo "If executed ctrl+C,Please execute the above lines manually"
echo "Please wait $2 seconds"
sleep $2

# 执行完成后，自动从/root/file.txt文件中读取命令kill掉占用CPU的进程
for i in $(awk '{print $2}' /root/file.txt); do
  echo "kill $i"
  kill $i
done

# 清理文件
rm -rf /root/file.txt
