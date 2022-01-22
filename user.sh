#!/usr/bin/env bash
echo -ne "
-------------------------------------------------------------------------
 █████╗ ██████╗  ██████╗██╗  ██╗ █████╗ ██████╗ ██╗   ██╗███████╗███████╗
██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝██╔════╝
███████║██████╔╝██║     ███████║███████║██████╔╝ ╚████╔╝ ███████╗███████╗
██╔══██║██╔══██╗██║     ██╔══██║██╔══██║██╔══██╗  ╚██╔╝  ╚════██║╚════██║
██║  ██║██║  ██║╚██████╗██║  ██║██║  ██║██████╔╝   ██║   ███████║███████║
╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝    ╚═╝   ╚══════╝╚══════╝
-------------------------------------------------------------------------
                    Automated Arch Linux Installer
                        SCRIPTHOME: ArchAbyss
-------------------------------------------------------------------------
Installing AUR Softwares
"
# You can solve users running this script as root with this and then doing the same for the next for statement. However I will leave this up to you.

yay -S --noconfirm --needed - < pkg-files/aur-pkgs.txt

# copy over all dotfile folders
cp -r .config/* ~/.config/
sleep 1

# Layan Cursors
mkdir -p $HOME/build
cd "$HOME/build"
git clone https://github.com/vinceliuice/Layan-cursors
cd Layan-cursors
sudo ./install.sh

git clone git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
bash polybar-themes/setup.sh

echo -ne "
-------------------------------------------------------------------------
                            POLYBAR
-------------------------------------------------------------------------
"
bash ~/.config/polybar/launch.sh --cuts

# Setup Wallpaper
mkdir ~/Wallpaper
cp -R wallpaper/* ~/Wallpaper

echo -ne "
-------------------------------------------------------------------------
                            COMPLETE
-------------------------------------------------------------------------
"
exit