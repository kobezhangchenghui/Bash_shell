#!/bin/bash

# 校验参数
if [ $# != 2 ]; then
  echo "USAGE: $0 <free,sleep time>"
  exit 1
fi

free -m
mkdir /tmp/memory
mount -t tmpfs -o size=$1M tmpfs /tmp/memory
dd if=/dev/zero of=/tmp/memory/block
free -m
echo "If executed ctrl+C,Please execute the following lines manually"
echo "execute: rm -rf /tmp/memory/block"
echo "execute: umount /tmp/memory"
echo "execute: rmdir /tmp/memory"
echo "Please wait $2 seconds"
sleep $2
rm -rf /tmp/memory/block
umount /tmp/memory
rmdir /tmp/memory
