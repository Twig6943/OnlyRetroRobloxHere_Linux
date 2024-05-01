#!/bin/bash
#V 2.00 Twig
#Install Aria2 for Debian/Arch
sudo apt install aria2
sudo pacman -S ari2a --noconfirm
echo "Make sure you have aria2 installed!"
sleep 5
winetricks -q wininet winhttp gdiplus wsh56 urlmon dotnetdesktop6 arial pptfonts allfonts corefonts

#Aria2c VCREDIST 2005
aria2c https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE --dir=/home/$USER/Downloads
#Install VCREDIST 2005
wine /home/$USER/Downloads/vcredist_x86.EXE /q
#RM VCREDIST 2005 Setup file 
rm /home/$USER/Downloads/vcredist_x86.EXE


#Aria2c VCREDIST 2008
aria2c https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe --dir=/home/$USER/Downloads
#Install VCREDIST 2008
wine /home/$USER/Downloads/vcredist_x86.exe /q
#RM VCREDIST 2008 Setup file
rm /home/$USER/Downloads/vcredist_x86.exe


#Aria2c VCREDIST 2010
aria2c https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe --dir=/home/$USER/Downloads
#Install VCREDIST 2010
wine /home/$USER/Downloads/vcredist_x86.exe /q
#RM VCREDIST 2010
rm /home/$USER/Downloads/vcredist_x86.exe


#Download ORRH
aria2c https://archive.org/download/only-retro-roblox-here-v-1.0.4.0.7z/only-retro-roblox-here-v-1.0.4.0.7z_archive.torrent --dir=/home/$USER/Downloads --seed-time=0

#Install More Stuff
aria2c https://download.visualstudio.microsoft.com/download/pr/856b04b7-f893-4fb1-9205-052413fde70f/09996e15acebe136113a3aa77b28fe5e/aspnetcore-runtime-6.0.27-win-x64.exe --dir=/home/$USER/Downloads
aria2c https://download.visualstudio.microsoft.com/download/pr/d57db805-d384-4ddb-b4a0-a9b4f7b37400/6e762dcde412cceafa16725e393663ab/dotnet-runtime-6.0.27-win-x64.exe --dir=/home/$USER/Downloads
wine /home/$USER/Downloads/aspnetcore-runtime-6.0.27-win-x64.exe /q
wine /home/$USER/Downloads/dotnet-runtime-6.0.27-win-x64.exe /q
rm /home/$USER/Downloads/aspnetcore-runtime-6.0.27-win-x64.exe
rm /home/$USER/Downloads/dotnet-runtime-6.0.27-win-x64.exe

7z x -t7z /home/$USER/Downloads/only-retro-roblox-here-v-1.0.4.0.7z/OnlyRetroRobloxHere-v1.0.4.0.7z -o/home/$USER/Downloads/only-retro-roblox-here-v-1.0.4.0.7z/OnlyRetroRobloxHere/
mv /home/$USER/Downloads/only-retro-roblox-here-v-1.0.4.0.7z/OnlyRetroRobloxHere/ ~/.wine/drive_c/ProgramData/

#RM Useless stuff.

#Create Desktop Shortcut
echo "Creating .desktop file for ORRH"
sudo aria2c https://github.com/Twig6943/OnlyRetroRobloxHere_Linux/blob/main/ORRH.png?raw=true --dir=/home/$USER/.local/share/applications/
aria2c https://raw.githubusercontent.com/Twig6943/OnlyRetroRobloxHere_Linux/main/desktop.sh --dir=/home/$USER/Downloads
chmod +x /home/$USER/Downloads/desktop.sh
sudo /home/$USER/Downloads/desktop.sh
