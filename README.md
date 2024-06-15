### ORRH GNU/Linux 🐧 install script 

(Make sure you have aria2 installed)

This is a fork of [KLanausse's ORRH script](https://gist.github.com/KLanausse/b0ba7e212f4cea6d725eac6be5c2d880)

Here's what my script does but KLanausse's doesn't;

Installs wine-staging-tkg-9.5-amd64 (x86 is also in the script) and adds it into the .desktop file

Install the latest ORRH release from archive.org

Run this ⬇️
```
#Command for Debian-based distros
sudo apt-get install aria2
#Command for Arch-based distros
sudo pacman -S aria2 --noconfirm
aria2c https://archive.org/download/only-retro-roblox-here-archive/only-retro-roblox-here-archive_archive.torrent --dir=/home/$USER/Downloads --seed-time=0
aria2c -d /home/$USER/Downloads/only-retro-roblox-here-archive/ https://raw.githubusercontent.com/Twig6943/OnlyRetroRobloxHere_Linux/main/ORRH.sh
chmod +x /home/$USER/Downloads/only-retro-roblox-here-archive/ORRH.sh
/home/$USER/Downloads/only-retro-roblox-here-archive/ORRH.sh
```

If you have a crappy GPU/iGPU run this script instead ⬇️
```
#Command for Debian-based distros
sudo apt-get install aria2
#Command for Arch-based distros
sudo pacman -S aria2 --noconfirm
aria2c https://archive.org/download/only-retro-roblox-here-archive/only-retro-roblox-here-archive_archive.torrent --dir=/home/$USER/Downloads --seed-time=0
aria2c -d /home/$USER/Downloads/only-retro-roblox-here-archive/ https://raw.githubusercontent.com/Twig6943/OnlyRetroRobloxHere_Linux/main/ORRH-igpu.sh
chmod +x /home/$USER/Downloads/only-retro-roblox-here-archive/ORRH-igpu.sh
/home/$USER/Downloads/only-retro-roblox-here-archive/ORRH-igpu.sh
```
