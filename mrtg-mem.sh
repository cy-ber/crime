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

#vps="zvur";
vps="aneka";


	source="https://raw.githubusercontent.com/cy-ber/crime"


# go to root
cd

# check registered ip
wget -q -O IP $source/debian7/IP.txt
if ! grep -w -q $MYIP IP; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "zvur" ]]; then
		echo "Hubungi: DEVELOPED BY YUSUF-ARDIANSYAH atau (082139743432)"
	else
		echo "Hubungi: DEVELOPED BY YUSUF-ARDIANSYAH atau (082139743432)"
	fi
	rm -f /root/IP
	exit
fi

FREE=`free -m | grep "buffers/cache" | awk '{print $3}'`
SWAP=`free -m | grep "Swap" | awk '{print $3}'`
UP=`uptime`

echo $FREE
echo $SWAP
echo $UP
echo "----------------------------------------------------------------" 


	echo " Edited BY YUSUF-ARDIANSYAH atau (082139743432)"


	echo " TEAM-HACKER "
echo "----------------------------------------------------------------" 

cd ~/
rm -f /root/IP
