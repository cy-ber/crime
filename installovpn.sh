#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
#MYIP=$(wget -qO- ipv4.icanhazip.com);

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`
MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
if [ "$MYIP" = "" ]; then
	MYIP=$(wget -qO- ipv4.icanhazip.com)
fi
MYIP2="s/xxxxxxxxx/$MYIP/g";
ether=`ifconfig | cut -c 1-8 | sort | uniq -u | grep venet0 | grep -v venet0:`
if [[ $ether = "" ]]; then
        ether=eth0
fi

#vps="zvur";
vps="aneka";

#if [[ $vps = "zvur" ]]; then
	#source="http://"
#else
	source="https://raw.githubusercontent.com/cy-ber/crime"
#fi

# go to root
cd

# check registered ip
wget -q -O IP $source/debian7/IP.txt
if ! grep -w -q $MYIP IP; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "zvur" ]]; then
		echo "Hubungi: editor YUSUF-ARDIANSYAH atau (082139743432)"
	else
		echo "Hubungi: editor YUSUF-ARDIANSYAH atau (082139743432)"
	fi
	rm /root/IP
	rm -f /root/IP
	exit
fi



# install openvpn
apt-get install openvpn -y
wget -O /etc/openvpn/openvpn.tar $source/debian7/openvpn-debian.tar
cd /etc/openvpn/
tar xf openvpn.tar
wget -O /etc/openvpn/1194.conf $source/debian7/1194.conf
service openvpn restart
sysctl -w net.ipv4.ip_forward=1
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf
wget -O /etc/iptables.conf $source/debian7/iptables.conf
sed -i '$ i\iptables-restore < /etc/iptables.conf' /etc/rc.local

myip2="s/ipserver/$MYIP/g";
sed -i $myip2 /etc/iptables.conf;

iptables-restore < /etc/iptables.conf
service openvpn restart

# configure openvpn client config
cd /etc/openvpn/
wget -O /etc/openvpn/client.ovpn $source/debian7/1194-client.conf

cp /etc/openvpn/client.ovpn /home/vps/public_html/client.ovpn
sed -i $myip2 /home/vps/public_html/client.ovpn
sed -i "s/ports/55/" /home/vps/public_html/client.ovpn
