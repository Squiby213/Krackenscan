#!/bin/bash

Green="\033[1;32m"
Red="\033[1;31m"

if [ ! -e /usr/games/lolcat ];then

	sudo apt install lolcat 
fi

echo -e "[+] KRACKENSCAN-START [+]" | lolcat

if [ -z "$1" ]
then
        echo -e "$Red ERROR: ./krakenscan.sh <IP>"
        exit 1
fi

echo "----- QNMAP -----" >> $1

echo -e "$Green [+] Running Quick Nmap Scan..."
nmap $1 >> $1

echo 

cat $1 | lolcat

echo "----- LNMAP -----" >> $1

echo -e "$Green [+] Running Full Nmap Scan..."
nmap -A -Pn $1 >> $1

echo

cat $1 | lolcat

echo "----- Enum4Linux -----" >> $1

echo -e "$Green [+] Running Enum4Linux..."
enum4linux $1 2>/dev/null >> $1

echo

cat $1 | lolcat

echo

if [ ! -e /usr/bin/gobuster ];then

       sudo apt install gobuster -y
fi

echo "----- DIRB -----" >> $1

echo -e "$Green [+] Running Gobuster..."
gobuster dir -u http://$1 -w /usr/share/wordlists/dirb/common.txt --no-error 2>/dev/null >> $1

echo "----- WHATWEB -----"

echo -e "$Green [+] Running Whatweb..."
whatweb $1 -v >> $1

cat $1 | lolcat
