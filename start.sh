#!/bin/bash

###Testa ROOT###
if [[ $EUID -ne 0 ]]; then
   echo "Rode o Script como ROOT" 
   exit
fi
###Testa ROOT###


###Testa primeira execução###
if [ -d "/work" ] 
then
    	clear
	echo "Sistema ja esta Pronto, nada será alterado." 
    	echo "Atualizando O Script Tools." 
	cd /etc/scripts
	mv tools tools.old
	chmod u-x tools.old
	curl https://raw.githubusercontent.com/atedim/start/main/tools -o tools
	chmod u+x tools
else
    echo "Sistema Limpo, Preparando Ambiente inicial."
###Testa primeira execução###


##atualiza sources###
apt-get update && apt-get upgrade -y && apt-get autoremove && apt-get autoclean && apt-get clean
##atualiza sources###


###instala basicos###
apt-get install ntpdate rcconf mc rsync cifs-utils samba mhddfs htop ntfs-3g exfat-fuse exfat-utils iptraf net-tools ncdu screen vsftpd -y
###instala basicos###


###Atualiza data e hora###
unlink /etc/localtime
ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
ntpdate pool.ntp.org
###Atualiza data e hora###


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
echo -e "123456\n123456" | passwd root
###Muda senha Root###

###Cria Diretórios###
mkdir -p /work/all
mkdir -p /work/disks/2sd{1,2}
mkdir -p /work/disks/5pd{1..5}
mkdir -p /work/disks/8pd{1..8}
mkdir -p /work/gavetas/2prata
mkdir -p /work/gavetas/{5,8}preta
mkdir -p /work/rack/16{0..9}
###Cria Diretórios###


###Cria usuario FTP###
useradd -p $(openssl passwd -1 mustelide) ftplogan
#redifine senha caso ja exista
echo -e "mustelide\nmustelide" | passwd ftplogan
###Cria usuario FTP###

###Baixa Script Tools###
mkdir /etc/scripts
cd /etc/scripts
curl https://raw.githubusercontent.com/atedim/start/main/tools -o tools
chmod u+x tools
###Baixa Script Tools###

fi

