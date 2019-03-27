#!/bin/bash

#====================================================
#	System Request: Centos 7+ Debian 8+
#	Author: yangzeon
#	* 第一次写SH
#	* 拿别人的改改
#	* 推荐系统：Debian 8 
#	* 开源地址：https://github.com/yangzeon/onekey/go.sh
#====================================================

#START
echo "================================开始================================ "
mkdir /root/.ssh
cd /root/.ssh
yum install wget nano -y
echo "================================正在加载 KEY 请稍后 ================================"
wget https://raw.githubusercontent.com/yangzeon/onekey/master/virmach.pub
cat virmach.pub >> authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
echo "================================正在更改 ssh 请稍后 ================================ "
cd
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PubkeyAuthentication yes/& \nRSAAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "================================ 完成 ... ================================"
/etc/init.d/sshd restart
service sshd restart
wget -N --no-check-certificate git.io/c.sh && chmod +x c.sh && bash c.sh
