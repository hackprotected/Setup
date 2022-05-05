#!/bin/bash

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

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt install -y software-properties-common macchanger
echo " "
sudo macchanger -r wlan0 eth0
echo " "
sudo add-apt-repository deb http://http.kali.org/kali kali-rolling main contrib non-free
sudo apt-get install -y kali-linux-everything secure-delete wipe nwipe glances ufw gufw yubioath-desktop
sudo unattended-upgrades -d
