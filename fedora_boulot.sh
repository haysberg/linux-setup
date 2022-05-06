#!/bin/bash

echo "Setup JetBrains Mono"
wget https://github.com/JetBrains/JetBrainsMono/raw/master/fonts/variable/JetBrainsMono%5Bwght%5D.ttf -O JetBrainsMono.ttf
wget https://github.com/JetBrains/JetBrainsMono/raw/master/fonts/variable/JetBrainsMono-Italic%5Bwght%5D.ttf -O JetBrainsMono-Italic.ttf
mkdir -p ~/.local/share/fonts 
mv ./*.ttf ~/.local/share/fonts/
fc-cache -f -v

echo "GNOME Settings..."
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'area'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'

echo "Setup xkb"
sudo sed -i 's/Shift_R/less, greater/' /usr/share/X11/xkb/symbols/pc

echo "Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y \
com.mattermost.Desktop \
com.discordapp.Discord \
com.spotify.Client \
com.axosoft.GitKraken \
org.videolan.VLC \
org.mozilla.Thunderbird \
com.brave.Browser \
com.dropbox.Client

echo "Ajout de VS Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

dnf check-update
sudo dnf update -y
sudo dnf install -y git code dnf-plugins-core gnome-tweaks guake 

echo "Oh-My-Bash"
nohup sh -c 'bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" && sed -i 's/"font"/"agnoster"/' ~/.bashrc'