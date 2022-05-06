#!/bin/bash

# Ensure script is being run as root ( to prevent annoyances ) 

if [ $(id -u) -ne 0 ]; then
	echo "This script must be run as root"
	exit 1
fi

echo " "
echo -------------
echo setup script for debian based systems
echo -------------
echo " "

while true; do
    read -p "Continue with installation? (Y/n) " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) break;;
    esac
done

echo " "

# Installation of programs and addition of required ppa's

apt update -y
apt upgrade -y
apt autoremove -y
apt install -y software-properties-common macchanger
echo " "
sudo macchanger -r wlan0 eth0
echo " "
sudo add-apt-repository deb http://http.kali.org/kali kali-rolling main contrib non-free
apt install -y secure-delete wipe nwipe glances ufw gufw yubioath-desktop chromium firefox-esr keepassxc
sudo unattended-upgrades -d

while true; do
    read -p "Install Kali Linux toolsets? everything (e) large (l)  " yn
    case $yn in
        [Ee]* ) apt install kali-linux-everything;;
        [Ll]* ) exit;;
        * ) break;;
    esac
done

# INSTALLATION OF KALI-ANONSURF : https://github.com/Und3rf10w/kali-anonsurf

git clone https://github.com/Und3rf10w/kali-anonsurf ~/Kali-Anonsurf

cd ~/Kali-Anonsurf

rm -r /etc/apt/sources.list.d/i2p.list

rm /tmp/i2p-debian-repo.key.asc
apt update

if [[ -n $(cat /etc/os-release |grep kali) ]]
then
	apt install libservlet3.0-java 
	wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
	apt install libjetty8-java_8.1.16-4_all.deb
	apt install libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu i2p i2p-router libjbigi-jni
	apt -f install
fi

apt install -y i2p-keyring
apt install -y secure-delete tor i2p

apt install kali-anonsurf-deb-src/ kali-anonsurf.deb
apt install kali-anonsurf.deb || (apt -f install && apt install kali-anonsurf.deb)

anonsurf help

echo "Anonsurf has been successfully installed!"

# KALI-ANONSURF INSTALLED, PROCEED.





echo "this is a test lol"
