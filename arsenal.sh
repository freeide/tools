#!/bin/bash
# Author: Nick Frichette
# Intended OS: Kali Linux/Debian
# Description: A quick script to install some tools after 
#     the OS has been flashed.

# Root check
if [ $EUID != 0 ]; then
    echo "[!] To install you must run as root."
    exit 1
fi 

echo "#########################################"
echo "#                                       #"
echo "#                Arsenal                #"
echo "#                                       #"
echo "# Give ordinary people the right tools, #"
echo "#  and they will design and build the   #"
echo "#      most extraordinary things.       #"
echo "#                                       #"
echo "#########################################"

read -p "[?] Are you sure you want to install the Arsenal? [Y/n]: " answer
if [ $answer != "Y" ]; then
    echo "[!] Did not answer yes. Exiting."
fi

# They answered yes so let's install some tools

echo "[+] Updating the OS"
apt update
apt upgrade -y
apt dist-upgrade -y

echo "[+] Installing i3wm"
apt install -y i3

echo "[+] Downloading Personal Configs"
wget https://github.com/Frichetten/dotfiles/archive/master.zip -O /tmp/dotfiles.zip
unzip /tmp/dotfiles.zip -d /tmp
cp -r /tmp/dotfiles-master/* ~/.config/
rm ~/.config/README.md

echo "[+] Install Polybar"
apt install -y cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev \
    libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev \
    libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm \
    libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev libpulse-dev \
    libxcb-composite0-dev
git clone https://github.com/jaagr/polybar.git
mv polybar/ /tmp/
cd /tmp/polybar
./build.sh
cd ~/tools

echo "[!] Need to Fix Polybar"
echo "Run 'xrandr --listmonitors' and get the monitor name"
echo "of the monitor you'd like to use. Replace this in the"
echo "Polybar config at ~/.config/polybar/config"
read -p "[?] Are you done? [Y/n]: " answer
if [ $answer != "Y" ]; then
    echo "[!] Did not answer yes. Exiting."
fi

echo "[+] Install PyWal"
pip3 install --user pywal
echo 'PATH="${PATH}:${HOME}/.local/bin"' >> ~/.bashrc

echo "[+] Install Ranger"
apt install -y ranger

echo "[+] Install arandr"
apt install -y arandr

echo "[+] Install Rofi"
apt install -y rofi

echo "[+] Install Nitrogen"
apt install -y nitrogen

echo "[+] Install Neofetch"
apt install -y neofetch

echo "[-] Remove Terminator"
# Kali includes terminator by default and I hate it
apt remove -y terminator

echo "[+] Install i3-gaps"
apt install -y libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb \
    libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
    libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
    libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
    libxcb-xrm0 libxcb-xrm-dev autoconf
cd /tmp
git clone https://www.github.com/Airblader/i3 i3-gaps
cd /tmp/i3-gaps
autoreconf --force --install
rm -rf /tmp/i3-gaps/build
mkdir -p /tmp/i3-gaps/build
cd /tmp/i3-gaps/build
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
make install
cd ~/tools

echo "[+] Install Scrot"
apt install -y scrot

echo "[+] Install feh"
apt install -y feh

echo "[+] Install dunst"
apt install -y dunst

echo "[+] Install xautolock"
apt install -y xautolock

echo "[+] Install compton"
apt install -y compton

echo "[+] Install docker"
apt install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo 'deb [arch=amd64] https://download.docker.com/linux/debian buster stable' | sudo tee -a /etc/apt/sources.list.d/docker.list
apt update
apt install -y docker-ce

echo "[+] Install aws cli"
pip3 install --upgrade awscli

echo "[+] Install ScoutSuite"
pip3 install scoutsuite

echo "[+] Install dirsearch"
mkdir ~/scripts
cd ~/scripts
git clone https://github.com/maurosoria/dirsearch.git
cd ~/tools
