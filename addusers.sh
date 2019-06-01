#! /bin/bash
function main(){
    for i in {1..20}
    do 
       username=user$i
       passwd="user`cat /dev/random | head -1 | md5sum | head -c 5`"
       useradd $username &>> /dev/null
       echo "$username:$passwd" | passwd --stdin $username
       echo "$username--$passwd" >> user.txt
    done
}
main @
