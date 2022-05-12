#!/bin/bash

echo "Setup xkb"
sudo sed -i 's/Shift_R/less, greater/' /usr/share/X11/xkb/symbols/pc

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
gsettings set org.gnome.settings-daemon.plugins.power ambient-enabled false
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface enable-hot-corners false

echo "Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y \
com.discordapp.Discord \
com.spotify.Client \
com.brave.Browser \
com.gexperts.Tilix \
com.mattjakeman.ExtensionManager

echo "Ajout de VS Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

dnf check-update
sudo dnf update -y
sudo dnf install -y git code dnf-plugins-core gnome-tweaks 

echo "Oh-My-Bash"
nohup sh -c 'bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" && sed -i 's/"font"/"agnoster"/' ~/.bashrc'