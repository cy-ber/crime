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

echo "-------------------------- GENERATE  AKUN SSH ---------------------------"


	echo "           DEVELOPED BY YUSUF-ARDIANSYAH atau (082139743432)          "

echo ""

read -p "Berapa hari akun aktif: " AKTIF

	uname=trial-`</dev/urandom tr -dc X-Z0-9 | head -c4`
	masaaktif="$AKTIF"
	pass=`</dev/urandom tr -dc a-f0-9 | head -c9`
	clear

clear
echo -e ""| lolcat
echo -e ""| lolcat
echo -e ""| lolcat
echo -e ""| lolcat
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $uname
exp="$(chage -l $uname | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$pass\n$pass\n"|passwd $uname &> /dev/null
echo -e ""| lolcat
echo -e "|       Informasi Akun Baru SSH      |" | boxes -d dog | lolcat
echo -e "============[[-SERVER-PREMIUM-]]===========" | lolcat
echo -e "     Host: $MYIP                           " | lolcat
echo -e "     Username: $username                   " | lolcat
echo -e "     Password: $password                   " | lolcat
echo -e "     Port default dropbear: 777            " | lolcat
echo -e "     Port default SSL/TLS : 443            " | lolcat
echo -e "     Port default openSSH : 80             " | lolcat
echo -e "     Port default squid   : 8080           " | lolcat
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
