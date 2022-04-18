#!/bin/bash

echo "Setup xkb"
sudo sed -i 's/Shift_R/less, greater/' /usr/share/X11/xkb/symbols/pc

echo "Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y \
com.mattermost.Desktop \
com.discordapp.Discord \
io.github.shiftey.Desktop \
com.spotify.Client \
org.videolan.VLC \
org.mozilla.Thunderbird \
com.brave.Browser \
com.mattjakeman.ExtensionManager

echo "GNOME Settings..."
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true
gsettings set org.gnome.desktop.peripherals.touchpad click-method 'area'

echo "Ajout de VS Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

dnf check-update
sudo dnf update -y
sudo dnf install code dnf-plugins-core gnome-tweaks guake 

echo "Update + NVIDIA Drivers..."

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf update -y
sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda vdpauinfo libva-vdpau-driver libva-utils
modinfo -F version nvidia

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc

echo "Oh-My-Bash"
nohup sh -c 'bash -c "$(wget https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh -O -)" && sed -i 's/"font"/"kitsune"/' ~/.bashrc'