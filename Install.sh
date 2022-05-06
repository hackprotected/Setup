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


# INSTALLATION OF KALI-ANONSURF : https://github.com/Und3rf10w/kali-anonsurf

git clone https://github.com/Und3rf10w/kali-anonsurf ~/./Kali-Anonsurf

cd ~/Kali-Anonsurf/

sudo sh installer.sh

echo "Anonsurf has been successfully installed!"

# KALI-ANONSURF INSTALLED, PROCEED.

while true; do
    read -p "Start anonsurf? (y/N) " yn
    case $yn in
        [Yy]* ) sudo anonsurf start;;
        [Nn]* ) break;;
        * ) break;;
    esac
done



echo "this is a test lol"
