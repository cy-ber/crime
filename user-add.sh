#!/bin/bash

if [[ $USER != 'root' ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
#MYIP=$(wget -qO- ipv4.icanhazip.com)


echo "------------------------ MEMBUAT AKUN SSH ------------------------"| lolcat


	echo "           DEVELOPED BY YUSUF-ARDIANSYAH atau (082139743432)           " | lolcat
echo ""

read -p "Isikan username: " username

egrep "^$username" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
	echo "Username [$username] sudah ada!"
	exit 1
else
	read -p "Isikan password akun [$username]: " password
	read -p "Berapa hari akun [$username] aktif: " AKTIF

	today="$(date +"%Y-%m-%d")"
	expire=$(date -d "$AKTIF days" +"%Y-%m-%d")
	useradd -M -N -s /bin/false -e $expire $username
	echo $username:$password | chpasswd
clear
echo -e ""
echo -e ""
echo -e ""
echo -e ""| lolcat
echo -e "|       Informasi Akun Baru SSH      |" | boxes -d dog | lolcat
echo -e "============[[-SERVER-PREMIUM-]]===========" | lolcat
echo -e "     Host: $MYIP                           " | lolcat
echo -e "     Username: $username                   " | lolcat
echo -e "     Password: $password                   " | lolcat
echo -e "     Port default dropbear: 442            " | lolcat
echo -e "     Port default openSSH : 80             " | lolcat
echo -e "     Port default squid   : 8080           " | lolcat
echo -e "     Port default SSL/TLS : 443            " | lolcat
echo -e "     Auto kill user maximal login 2        " | lolcat
echo -e "-------------------------------------------" | lolcat
echo -e "     Aktif Sampai: $(date -d "$AKTIF days" +"%d-%m-%Y")" | lolcat
echo -e "===========================================" | lolcat
echo -e "     NO-CRIMINAL - CYBER,,,                " | lolcat
echo -e "===========================================" | lolcat
echo -e "   http://$MYIP:81/client.ovpn             " | lolcat
echo -e "   Script by YUSUF-ARDIANSYAH              " | lolcat
echo -e "-------------------------------------------" | lolcat
echo -e ""
echo -e ""
fi


