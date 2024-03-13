#!/bin/bash

##########################################################################################################################
# Script: ThinkInstallF
# Autor: ThinkRoot
# Versiune: 2.1

# Descriere: 
#   Acest script automatizează procesul de instalare a unui set de programe și dependințe pe un sistem Fedora.
#   Este util pentru instalarea unui set comun de programe și personalizări pe un sistem Fedora.

# Pași de utilizare:
# 1. După ce ai descărcat acest script, șterge programele de care nu ai nevoie și adaugă programele necesare pentru tine.
# 2. Deschide terminalul și navighează în directorul în care ai salvat scriptul.
# 3. Acordă permisiuni de executare pentru script folosind comanda: chmod +x ThinkInstallF.sh.
# 4. Rulează scriptul cu privilegii de superutilizator (sudo) folosind comanda: sudo ./ThinkInstallF.sh.
# 5. Scriptul va începe instalarea programelor și a personalizărilor specificate.
##########################################################################################################################

# Verificare Privilegii
if [ "$(id -u)" -ne 0 ]; then
    echo "Scriptul trebuie să ruleze cu privilegii de superutilizator. Rulează scriptul cu sudo."
    exit 1
fi

# Actualizare sistem
echo "Actualizare sistem..."
sudo dnf upgrade --refresh

# Instalare rpmfusion
echo "Instalare rpmfusion..."
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Instalare depozit openh264
echo "Instalare depozit openh264..."
sudo dnf config-manager --enable fedora-cisco-openh264

# Instalare multimedia
echo "Instalare multimedia..."
sudo dnf swap ffmpeg-free ffmpeg --allowerasing
sudo dnf groupupdate multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf install rpmfusion-free-release-tainted
sudo dnf install libdvdcss
sudo dnf install vlc-plugins-freeworld

# Instalare drivere pentru Intel
echo "Instalare drivere pentru Intel..."
sudo dnf install intel-media-driver
sudo dnf install libva-intel-driver

# Instalare Firmware
echo "Instalare Firmware..."
sudo dnf --repo=rpmfusion-nonfree-tainted install "*-firmware"

# Actualizare sistem
echo "Actualizare sistem..."
sudo dnf upgrade --refresh

# Instalare programe rpm
echo "Instalare programe rpm..."
sudo dnf install gnome-tweak gimp gimp-data-extras gimp-elsamuko gimp-paint-studio gimp-resynthesizer gimpfx-foundry gmic-gimp gimp-jxl-plugin libreoffice libreoffice-calc libreoffice-core libreoffice-data libreoffice-emailmerge libreoffice-gtk3 libreoffice-gtk4 libreoffice-impress libreoffice-pdfimport libreoffice-writer kdenlive obs-studio obs-studio-plugin-vkcapture obs-studio-plugin-vlc-video obs-studio-plugin-webkitgtk obs-studio-plugin-x264 vlc vlc-extras telegram-desktop discord filezilla polari qbittorrent gparted apostrophe file-roller pdfarranger rpi-imager git neofetch htop yt-dlp pandoc

# Instalare programe flatpak
echo "Instalare programe flatpak..."
flatpak install flathub com.github.gijsgoudzwaard.image-optimizer org.nickvision.tubeconverter com.spotify.Client io.gitlab.adhami3310.Converter eu.betterbird.Betterbird one.ablaze.floorp com.microsoft.Edge io.gitlab.librewolf-community com.microsoft.Edge com.github.eneshecan.WhatsAppForLinux org.gnome.World.PikaBackup org.gnome.World.Iotas com.bitwarden.desktop io.github.shiftey.Desktop io.github.zhrexl.thisweekinmylife

# Instalare extensii pentru GNOME
echo "Instalare extensii pentru GNOME..."
sudo dnf install gnome-shell-extension-user-theme gnome-shell-extension-appindicator gnome-shell-extension-dash-to-dock gnome-shell-extension-blur-my-shell

# Instalare teme
echo "Instalare teme..."
sudo dnf install adwaita-blue-gtk-theme adwaita-cursor-theme adwaita-icon-theme gnome-shell-theme-yaru yaru-gtk3-theme yaru-gtk4-theme yaru-icon-theme yaru-sound-theme yaru-theme la-capitaine-cursor-theme gnome-themes-extra

echo "Instalarea a fost finalizată cu succes!"

