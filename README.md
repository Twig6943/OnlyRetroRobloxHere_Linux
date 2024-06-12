###ORRH Linux install script (Make sure you have aria2 installed)

```
#Command for Debian-based distros
sudo apt-get install aria2
#Command for Arch-based distros
sudo pacman -S aria2 --noconfirm
aria2c https://archive.org/download/only-retro-roblox-here-archive/only-retro-roblox-here-archive_archive.torrent --dir=/home/$USER/Downloads --seed-time=0
aria2c -d /home/$USER/Downloads/only-retro-roblox-here-archive/ https://gist.githubusercontent.com/KLanausse/b0ba7e212f4cea6d725eac6be5c2d880/raw/655f5d0adfa2c0236468bb79a2f96506ef067c67/ORRH_linux_setup_and_install.sh
chmod +x /home/$USER/Downloads/only-retro-roblox-here-archive/ORRH_linux_setup_and_install.sh
sh /home/$USER/Downloads/ORRH_linux_setup_and_install.sh
```
