# Prompt the user for their username
read -p "Enter your username: " username

goverlay_desktop_file="/usr/share/applications/orrh.desktop"
sudo echo "[Desktop Entry]" > "$goverlay_desktop_file"
sudo echo "Name=OldRoblox" >> "$goverlay_desktop_file"
sudo echo "Exec=wine /home/twig/.wine/drive_c/ProgramData/OnlyRetroRobloxHere/OnlyRetroRobloxHere.exe" >> "$goverlay_desktop_file"
sudo echo "Icon=/usr/share/icons/ORRH.png" >> "$goverlay_desktop_file"
sudo echo "Type=Application" >> "$goverlay_desktop_file"
sudo echo "Categories=Games;" >> "$goverlay_desktop_file"

# Replace USER_PLACEHOLDER with the actual username
sed -i "s|USER_PLACEHOLDER|$username|g" "$goverlay_desktop_file"
echo "\e[0;31mShortcut created.ORRH\e"
sleep 5
