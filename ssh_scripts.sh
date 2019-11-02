#!/bin/bash
#1生成秘钥
if [ -f /root/.ssh/id_rsa ]
then
	echo "密钥已存在"		
else
	ssh-keygen -t dsa -f /root/.ssh/id_rsa -N '' &>/dev/null
	echo "密钥已创建"
fi

for ip in {31,41,7,8}
do
	echo “=====================================”
	#2分发秘钥
	sshpass -p '1' ssh-copy-id 172.16.1.${ip} -o StrictHostKeyChecking=no &>/dev/null
	if [ $?==0 ]
	then
		echo "密钥分发完成：172.16.1.${ip}"
	else
		echo "密钥分发失败"
	fi
	#3测试
	ssh 172.16.1.${ip} hostname
	if [ $?==0 ]
        then
	        echo "success！"
        else
       		echo "fail！"
        fi

done

