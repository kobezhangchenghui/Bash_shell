#! /bin/bash
function main(){
    users=`cat /etc/passwd | grep "^user" |awk -F ":" '{print $1}'`
    for user in $users
    do 
       userdel -r $user 
       ret=$?
       if [ $ret -eq 0 ];then
           echo "delete $user successful"
       else
           echo "delete $user failed"
       fi
    done
    cat /etc/passwd | grep "^user" |awk -F ":" '{print $1}' &>> /dev/null
    if [ $? -eq 0 ];then
           echo "delete users successful"
    else
           echo "delete users failed"
    fi
}
main @
