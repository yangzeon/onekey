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
yum install wget nano ntp -y
echo "================================正在加载 KEY 请稍后 ================================"

wget https://raw.githubusercontent.com/yangzeon/onekey/master/10GKVM.pub
cat 10GKVM.pub >> authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
echo "================================正在更改 ssh 请稍后 ================================ "

cd

sed -i 's/#RSAAuthentication yes/RSAAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

echo "================================ 完成 ... ================================"
/etc/init.d/sshd restart
service sshd restart

echo "================================ 定时重启 ... ================================"

echo "0 4 * * * root reboot >> /log/reboot.txt" >> /etc/crontab
echo "30 4 10 * * root yum update && apt-get dist-upgrade -y >> /log/update.txt" >> /etc/crontab
crontab /etc/crontab
crontab -u root -l
systemctl restart crond.service
echo "================================ 继续 ... ================================"
wget -N --no-check-certificate https://raw.githubusercontent.com/yangzeon/onekey/master/c.sh && chmod +x c.sh && bash c.sh
