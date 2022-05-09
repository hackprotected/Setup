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
apt install -y secure-delete bluez-tools btscanner wipe nwipe glances ufw gufw yubioath-desktop chromium firefox-esr keepassxc bluez blueman bluetooth bluez-alsa-utils bluez-dbgsym bluez-firmware thunar mousepad
apt remove -y bluez-cups bluez-cups-dbgsym  
sudo unattended-upgrades -d
sudo service bluetooth start


# INSTALLATION OF KALI-ANONSURF : https://github.com/Und3rf10w/kali-anonsurf
# I will try to fork this & fix all the errors soon :) -- Update: I have forked it, working out the errors on https://github.com/hackprotected/kali-anonsurf
echo " "
echo "Anonsurf Install : https://github.com/Und3rf10w/kali-anonsurf/ "
echo " "

git clone https://github.com/Und3rf10w/kali-anonsurf ~/./Kali-Anonsurf
cd ~/Kali-Anonsurf/
sudo sh installer.sh

echo "Anonsurf has been successfully installed!"

# KALI-ANONSURF INSTALLED, PROCEED.

while true; do
    read -p "Start anonsurf? !! May slow the rest of this process down !! (y/N) " yn
    case $yn in
        [Yy]* ) sudo anonsurf start;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

# PIMPMYKALI : https://github.com/Dewalt-arch/pimpmykali.git

echo " "
echo "PimpMyKali Install : https://github.com/Dewalt-arch/pimpmykali.git/ "
echo " "

git clone https://github.com/Dewalt-arch/pimpmykali.git ~/./PimpMyKali
cd ~/PimpMyKali/
sudo sh pimpmykali.sh

# PIMPMYKALI INSTALLED, PROCEED.

echo "this is a test lol"
