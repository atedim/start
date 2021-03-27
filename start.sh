#!/bin/bash

###Let the Carnage begins###
sudo su
###Let the Carnage begins###


###Atualiza data e hora###
unlink /etc/localtime
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
ntpdate pool.ntp.org
###Atualiza data e hora###


##atualiza sources###
apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean && apt-get clean
##atualiza sources###


###instala basicos###
apt-get install ntpdate rcconf mc rsync cifs-utils samba mhddfs htop ntfs-3g exfat-fuse exfat-utils iptraf net-tools ncdu screen vsftpd - y
###instala basicos###


##limpa espaço###
apt-get autoremove && apt-get autoclean && apt-get clean
##limpa espaço###


###backup inicial###
cd / && tar zcvfp etc.ORI.tgz /etc
###backup inicial###


###Ajusta ssh###
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
/etc/init.d/ssh restart
###Ajusta ssh###


###Insere Script to PATH###
sed -i -e '$a\' ~/.bashrc && echo 'export PATH=$PATH:/etc/scripts' >>~/.bashrc && sed -i -e '$a\' ~/.bashrc
###Insere Script to PATH###


###Muda senha Root###
echo -e "123456\n123456 | passwd root
###Muda senha Root###


#useradd -p $(openssl passwd -1 mustelide) ftplogan
