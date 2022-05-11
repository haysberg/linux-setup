#!/bin/bash

sh -c "$(curl -fsSL https://raw.githubusercontent.com/haysberg/linux-setup/main/fedora_home.sh)"

echo "Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y \
com.mattermost.Desktop \
com.axosoft.GitKraken \
org.mozilla.Thunderbird \
com.dropbox.Client