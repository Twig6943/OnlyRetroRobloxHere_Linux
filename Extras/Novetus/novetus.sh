#!/bin/bash
#Created by Lanausse
#Special Thanks to TouseefX for helping improve it

prefix=$HOME/.local/share/wineprefixes/Novetus

#text colours
Green='\033[1;32m'
Red='\033[1;31m'
Yellow='\033[1;33m'
Blue='\033[1;34m'
Reset='\033[m'


echo " "



if [ -f /etc/debian_version ]
then
distro_guess="Debian"
distro_check="dpkg -l"
distro_install="apt install"
distro_update=" sudo apt update"
fi

if [ -f /etc/redhat-release ]
then
distro_guess="Fedora"
distro_check="rpm -q"
distro_install="yum install"
distro_update="dnf update && dnf upgrade"
fi

if [ -f /etc/SuSE-release ]
then
distro_guess="OpenSUSE"
distro_check="zypper search -i"
distro_install="zypper install"
distro_update="zypper update"
fi

if [ -f /etc/arch-release ]
then
distro_guess="Arch"
distro_check="pacman -Qs"
distro_install="pacman -S"
distro_update="pacman -Syu"
fi

if test -z $distro_guess;
then
echo -e "${Red}This Linux distro is not supported sorry. Now aborting."
exit
fi

# Now Start The Script
echo -e "${Yellow}Checking if your system is supported..."
sleep 3
# Now Check The Cpu
if ! lscpu | grep avx > /dev/null;
then
	echo -e "${Red}Cpu Does Not Have AVX For Roblox GUI"
fi

if lscpu | grep avx > /dev/null;
then
echo -e "${Green}CPU supported!"
fi

# check glibc is 2.31 or newer
if ldd --version | grep "2\\.30]\|2\\.2" > /dev/null;
then
	echo -e "${Red}Error: Your system is unsupported. Please update to glibc 2.31 or greater. Press return to continue.${Reset}"
	read -p " "
	exit
fi

echo -e "${Green}Glic 2.31 or newer is installed!"

echo -e "${Green}${distro_guess} is supported!"
echo -e "${Blue}Press Enter To Install"

read -p ""

echo -e "${Yellow}Checking if the required packages are installed...${Reset}"

# install "lib32-gnutls" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-gnutls > /dev/null ;
then
  	 sudo $distro_install lib32-gnutls;
fi

# install "lib32-alsa-plugins" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-alsa-plugins > /dev/null ;
then
  	 sudo $distro_install lib32-alsa-plugins;
fi

# install "lib32-libpulse" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-libpulse > /dev/null ;
then
  	 sudo $distro_install lib32-libpulse;
fi

# install "lib32-openal" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-openal > /dev/null ;
then
  	 sudo $distro_install lib32-openal;
fi

# install "xdg-utils" if missing.
if ! $distro_check xdg-utils > /dev/null ;
then
  sudo $distro_install xdg-utils;
fi

if ! $distro_check 7z > /dev/null && ! $distro_check p7zip > /dev/null;
then
  sudo $distro_install 7z && sudo $distro_install p7zip;
fi

echo ""

#Check for an existing install
if [ -d "$prefix" ]; then
    echo -e "${Yellow}You seem to already have Novetus installed!"
    echo -e "${Yellow}Proceeding will completely wipe your previous install!${Reset}"
    read -p "Are you sure you want to continue? (y/N) " doReinstall
    case $doReinstall in
        [Yy]* ) echo "Reinstalling..." && rm -rf $prefix && rm ~/.local/share/applications/Novetus.desktop && rm ~/Desktop/Novetus.desktop;;
        [Nn]* ) exit 1;;
        * ) exit 1;;
    esac
fi

#Look for the Novetus archive in the current folder 
novetusArchive=$(find . -maxdepth 1 -name 'novetus-windows*.zip' -type f | tail -n 1)

if ((${#novetusArchive} <= 4)); then
    echo "novetus-windows(-beta).zip was not found!"
    echo "Make sure novetus-windows(-beta).zip is in the same folder as the script!"
    exit 1
fi

#Install redist
WINEPREFIX=$prefix winetricks -q wininet winhttp mfc80 mfc90 gdiplus wsh56 urlmon pptfonts corefonts dxvk
WINEPREFIX=$prefix winetricks wininet=builtin winihttp=native

#Install Novetus
7z x $novetusArchive -oNovetus/
mv Novetus/ $prefix/drive_c/ProgramData/

if [ -d $prefix/drive_c/ProgramData/Novetus/data ]; then
	path_to_bin=C:\\\\\\\\ProgramData\\\\\\\\Novetus\\\\\\\\data\\\\\\\\bin\\\\\\\\Novetus.exe
elif [ -f $prefix/drive_c/ProgramData/Novetus/NovetusBootstrapper.exe ]; then
	path_to_bin=C:\\\\\\\\ProgramData\\\\\\\\Novetus\\\\\\\\NovetusBootstrapper.exe
else
	path_to_bin=C:\\\\\\\\ProgramData\\\\\\\\Novetus\\\\\\\\bin\\\\\\\\Novetus.exe
fi

#Icon
wget https://gist.github.com/assets/66651363/5fd13bf3-4102-4f26-a80b-c10c7281c9ba -O $prefix/drive_c/ProgramData/Novetus/Icon.png

#Create Desktop Shortcut
echo "[Desktop Entry]" >> ~/.local/share/applications/Novetus.desktop
echo "Name=Novetus" >> ~/.local/share/applications/Novetus.desktop
echo "Comment=${novetusArchive:2:-4}" >> ~/.local/share/applications/Novetus.desktop
echo "Icon=$prefix/drive_c/ProgramData/Novetus/Icon.png" >> ~/.local/share/applications/Novetus.desktop
echo "Exec=env WINEPREFIX=\"$HOME/.local/share/wineprefixes/Novetus\" wine $path_to_bin" >> ~/.local/share/applications/Novetus.desktop
echo "Type=Application" >> ~/.local/share/applications/Novetus.desktop
echo "Categories=Games;" >> ~/.local/share/applications/Novetus.desktop
echo "StartupNotify=true" >> ~/.local/share/applications/Novetus.desktop
echo "Path=$HOME/.local/share/wineprefixes/Novetus/drive_c/ProgramData/Novetus" >> ~/.local/share/applications/Novetus.desktop
echo "StartupWMClass=Novetus.exe" >> ~/.local/share/applications/Novetus.desktop
cp ~/.local/share/applications/Novetus.desktop ~/Desktop/Novetus.desktop
#sudo chmod 777 $HOME/.local/share/applications/Novetus.desktop && sudo chmod 777 $HOME/Desktop/Novetus.desktop

echo -e "${Green}Novetus had been installed successfully!${Reset}"

#Open
WINEPREFIX=$prefix wine $path_to_bin
