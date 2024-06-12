#!/bin/bash
prefix=$HOME/.local/share/wineprefixes/OnlyRetroRobloxHere

#text colours
Green='\033[1;32m'
Red='\033[1;31m'
Yellow='\033[1;33m'
Blue='\033[1;34m'
Reset='\033[m'


echo " "



if [ -f /etc/debian_version ]; then
distro_guess="Debian"
distro_check="dpkg -l"
distro_install="apt install"
distro_update=" sudo apt update"
fi

if [ -f /etc/redhat-release ]; then
distro_guess="Fedora"
distro_check="rpm -q"
distro_install="yum install"
distro_update="dnf update && dnf upgrade"
fi

if [ -f /etc/SuSE-release ]; then
distro_guess="OpenSUSE"
distro_check="zypper search -i"
distro_install="zypper install"
distro_update="zypper update"
fi

if [ -f /etc/arch-release ]; then
distro_guess="Arch"
distro_check="pacman -Qs"
distro_install="pacman -S"
distro_update="pacman -Syu"
fi

if test -z $distro_guess; then
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
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-gnutls > /dev/null; then
  	 sudo $distro_install lib32-gnutls;
fi

# install "lib32-alsa-plugins" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-alsa-plugins > /dev/null; then
  	 sudo $distro_install lib32-alsa-plugins;
fi

# install "lib32-libpulse" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-libpulse > /dev/null; then
  	 sudo $distro_install lib32-libpulse;
fi

# install "lib32-openal" if missing.
if [ $distro_guess = "Arch" ] && ! $distro_check lib32-openal > /dev/null; then
  	 sudo $distro_install lib32-openal;
fi

# install "xdg-utils" if missing.
if ! $distro_check xdg-utils > /dev/null; then
  sudo $distro_install xdg-utils;
fi

if ! $distro_check 7z > /dev/null && ! $distro_check p7zip > /dev/null; then
  sudo $distro_install 7z && sudo $distro_install p7zip;
fi

#install wine
if ! $distro_check wine > /dev/null && ! $distro_check wine-core > /dev/null; then
	sudo dpkg --add-architecture i386
	sudo $distro_install wine
fi

echo ""

#Check for an existing install
if [ -d "$prefix" ]; then
    echo -e "${Yellow}You seem to already have OnlyRetroRobloxHere installed."
    echo -e "${Yellow}Proceeding will completely wipe your previous install!${Reset}"
    read -p "Are you sure you want to continue? (y/N) " doReinstall
    case $doReinstall in
        [Yy]* ) echo "Reinstalling..." && rm -rf $prefix && rm ~/.local/share/applications/OnlyRetroRobloxHere.desktop && rm ~/Desktop/OnlyRetroRobloxHere.desktop;;
        [Nn]* ) exit 1;;
        * ) exit 1;;
    esac
fi

orrhArchive=$(find . -maxdepth 1 -name 'OnlyRetroRobloxHere-v*.7z' -type f | tail -n 1)

if ((${#orrhArchive} <= 3)); then
    echo "${Red}OnlyRetroRobloxHere-vX.X.X.X.7z was not found!"
    echo "${Yellow}Make sure OnlyRetroRobloxHere-vX.X.X.X.7z is in the same folder as the script!${Reset}"
    exit 1
fi

WINEPREFIX=$prefix winetricks -q wininet winhttp mfc80 mfc90 gdiplus wsh56 urlmon pptfonts corefonts dxvk
WINEPREFIX=$prefix winetricks wininet=builtin winihttp=native

#Install dotnet 6 redist
wget https://download.visualstudio.microsoft.com/download/pr/856b04b7-f893-4fb1-9205-052413fde70f/09996e15acebe136113a3aa77b28fe5e/aspnetcore-runtime-6.0.27-win-x64.exe
wget https://download.visualstudio.microsoft.com/download/pr/d57db805-d384-4ddb-b4a0-a9b4f7b37400/6e762dcde412cceafa16725e393663ab/dotnet-runtime-6.0.27-win-x64.exe
wget https://download.visualstudio.microsoft.com/download/pr/d0849e66-227d-40f7-8f7b-c3f7dfe51f43/37f8a04ab7ff94db7f20d3c598dc4d74/windowsdesktop-runtime-6.0.29-win-x64.exe
WINEPREFIX=$prefix wine aspnetcore-runtime-6.0.27-win-x64.exe /q
WINEPREFIX=$prefix wine dotnet-runtime-6.0.27-win-x64.exe /q
WINEPREFIX=$prefix wine windowsdesktop-runtime-6.0.29-win-x64.exe /q


7z x -t7z $orrhArchive -oOnlyRetroRobloxHere/
mv OnlyRetroRobloxHere/ $prefix/drive_c/ProgramData/

#Cleanup
rm aspnetcore-runtime-6.0.27-win-x64.exe
rm dotnet-runtime-6.0.27-win-x64.exe
rm windowsdesktop-runtime-6.0.29-win-x64.exe


#Icon
wget https://gist.github.com/assets/66651363/58d0c0b6-18ac-44b8-a390-c6237237975c -O $prefix/drive_c/ProgramData/OnlyRetroRobloxHere/Icon.png
#Wine-TKG
mkdir /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine
wget https://github.com/Kron4ek/Wine-Builds/releases/download/9.5/wine-9.5-staging-tkg-amd64.tar.xz -O /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine/wine-9.5-staging-tkg-amd64.tar.xz
#wget https://github.com/Kron4ek/Wine-Builds/releases/download/9.5/wine-9.5-staging-tkg-x86.tar.xz -O /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine/wine-9.5-staging-tkg-x86.tar.xz
tar -xf /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine/wine-9.5-staging-tkg-amd64.tar.xz -C /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine
#tar -xf /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine/wine-9.5-staging-tkg-x86.tar.xz -C /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine


#Create Desktop Shortcut (If you're on a different architecture than amd64 replace the "wine" with a wine binary suitable for your CPU.)
echo "[Desktop Entry]" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Name=OnlyRetroRobloxHere" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Comment=${orrhArchive:2:-3}" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Icon=$prefix/drive_c/ProgramData/OnlyRetroRobloxHere/Icon.png" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Exec=env WINEPREFIX=\"$HOME/.local/share/wineprefixes/OnlyRetroRobloxHere\" /home/$USER/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere/wine/wine-9.5-staging-tkg-amd64/bin/wine C:\\\\\\\\ProgramData\\\\\\\\OnlyRetroRobloxHere\\\\\\\\OnlyRetroRobloxHere.exe" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Type=Application" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Categories=Games;" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "StartupNotify=true" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "Path=$HOME/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
echo "StartupWMClass=OnlyRetroRobloxHere.exe" >> ~/.local/share/applications/OnlyRetroRobloxHere.desktop
cp ~/.local/share/applications/OnlyRetroRobloxHere.desktop ~/Desktop/OnlyRetroRobloxHere.desktop

#Remove stuff
rm -r /home/$USER/Downloads/only-retro-roblox-here-archive
#Open
WINEPREFIX=$prefix wine C:\\\\\\\\ProgramData\\\\\\\\OnlyRetroRobloxHere\\\\\\\\OnlyRetroRobloxHere.exe
