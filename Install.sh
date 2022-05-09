#!/bin/bash

# GOTO for bash, based upon https://stackoverflow.com/a/31269848/5353461
goto() {
  label=$1
  cmd=$(sed -En "/^[[:space:]]*#[[:space:]]*$label:[[:space:]]*#/{:a;n;p;ba};" "$0")
  eval "$cmd"
  exit
}

start=${1:-start}

echo \\n
echo -------------
echo setup script for debian based systems
echo -------------
echo \\n

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

sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
sudo apt install -y software-properties-common macchanger
echo \\
sudo macchanger -r wlan0 eth0
echo \\
sudo add-apt-repository deb http://http.kali.org/kali kali-rolling main contrib non-free
sudo apt install -y secure-delete bluez-tools btscanner wipe nwipe glances ufw gufw yubioath-desktop chromium firefox-esr keepassxc bluez blueman bluetooth bluez-alsa-utils bluez-dbgsym bluez-firmware thunar mousepad
sudo apt remove -y bluez-cups bluez-cups-dbgsym  
sudo unattended-upgrades -d
sudo service bluetooth start

# INSTALLATION OF KALI-ANONSURF : https://github.com/hackprotected/kali-anonsurf
# I will try to fork this & fix all the errors soon :) -- Update: I have forked it, working out the errors on https://github.com/hackprotected/kali-anonsurf Update no.2: I DID IT OMG MY CODE WORKS WOOOOOO

echo \\n
echo "Anonsurf Install : https://github.com/hackprotected/kali-anonsurf/ -- Original credits to https://github.com/Und3rf10w/ "
echo \\n

git clone https://github.com/hackprotected/kali-anonsurf ~/Kali-Anonsurf
cd ~/Kali-Anonsurf/
sudo sh installer.sh

echo \\n
echo "Anonsurf has been successfully installed!"
echo \\n

# KALI-ANONSURF INSTALLED, PROCEED.

while true; do
    read -p "Start anonsurf? !! May slow the rest of this process down !! (y/N) " yn
    case $yn in
        [Yy]* ) sudo anonsurf start;;
        [Nn]* ) break;;
        * ) break;;
    esac
done

# PIMPMYKALI : https://github.com/Dewalt-arch/pimpmykali

echo \\n
echo "PimpMyKali Install : https://github.com/Dewalt-arch/pimpmykali/ "
echo \\n

sudo srm -rv ~/PimpMyKali/
git clone https://github.com/Dewalt-arch/pimpmykali ~/PimpMyKali
cd ~/PimpMyKali/
sudo sh pimpmykali.sh

# PIMPMYKALI COMPLETED, PROCEED.

echo \\n
echo "PimpMyKali completed. "
echo \\n 

# SIGNAL INSTALL https://signal.org/download#

while true; do
    read -p "Install Signal Messenger? https://signal.org/ (Y/n) " yn
    case $yn in
        [Yy]* ) goto SignalInstall;;
        [Nn]* ) goto NoSignalInstall;;
        * ) goto SignalInstall;;
    esac
done

# SignalInstall: #
    
    wget -O- https://updates.signal.org/desktop/sudo apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg
    
    cat signal-desktop-keyring.gpg | sudo tee -a /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/nullecho 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/sudo apt xenial main' |\ sudo tee -a /etc/sudo apt/sources.list.d/signal-xenial.list 
    sudo apt update && sudo sudo apt install signal-desktop
    goto SuccessfulSignalInstall

# NoSignalInstall: #

    \\n
    echo "Signal not installed, proceeding. "
    \\n
    
    goto Done

# SuccessfulSignalInstall: #

    \\n
    echo "Signal install complete. "
    \\n

# Done: #
