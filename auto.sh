#!/bin/bash
#使用在这个脚本时，在github上显示的注释会带有双引号

dir_full=`pwd`
dir=`basename $dir_full`
commit=$1
passwd=$2
if [ $# -lt 2 ];then
    echo "Usage:$0 commit passwd [commit_time] [upload_time]"
    exit
fi
if [ -n "$3" ];then
    commit_time=$3
else
    commit_time=4
    echo "如果此脚本提示 Everything up-to-date，那可能是给git commit的时间不够，请尝试添加第三个参数。"
fi

if [ -n "$4" ];then
    upload_time=$4
else
    upload_time=20
    echo "如果总是上传文件失败，那可能是给git push的时间不够，请尝试添加第四个参数。"
fi

/usr/bin/expect << EOF
set timeout $upload_time
spawn git add .
sleep 5
spawn git commit -m"$commit"
sleep $commit_time
spawn git push https://github.com/wujiaming123/${dir}.git master
expect "'https://github.com':"
send "wujiaming123\n"
expect "'https://wujiaming123@github.com':"
send "${passwd}\n"
expect eof
EOF
