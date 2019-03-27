#!/bin/bash

#====================================================
#	System Request: Centos 7+ Debian 8+
#	Author: yangzeon
#	* 第一次写SH
#	* 拿别人的改改
#	* 推荐系统：Debian 8 
#	* 开源地址：https://github.com/yangzeon/onekey/go.sh
#====================================================

#定义文字颜色
Green="\033[32m"
Red="\033[31m"
GreenBG="\033[42;37m"
RedBG="\033[41;37m"
Font="\033[0m"

#START
echo "${GreenBG} 开始 ${Font}"
mkdir /root/.ssh
cd /root/.ssh
yum install wget nano -y
echo "${GreenBG} 正在加载 KEY 请稍后 ... ${Font}"
wget https://raw.githubusercontent.com/yangzeon/onekey/master/virmach.pub
cat virmach.pub >> authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
echo "${GreenBG} 正在更改 ssh 请稍后 ... ${Font}"
cd
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PubkeyAuthentication yes/& \nRSAAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
echo "${GreenBG} 完成 ... ${Font}"
/etc/init.d/sshd restart
wget -N --no-check-certificate git.io/c.sh && chmod +x c.sh && bash c.sh
