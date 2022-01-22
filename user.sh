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
"

echo -ne "
-------------------------------------------------------------------------
                            Yay & ZSH
-------------------------------------------------------------------------
"

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~
touch "~/.cache/zshhistory"
git clone "https://github.com/Phaenom/zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -s "~/zsh/.zshrc" ~/.zshrc

echo -ne "
-------------------------------------------------------------------------
                        Install AUR Software
-------------------------------------------------------------------------
"
yay -S --noconfirm --needed - < pkg-files/aur-pkgs.txt


echo -ne "
-------------------------------------------------------------------------
                        Copy Config
-------------------------------------------------------------------------
"

# copy over all dotfile folders
cp -r .config/* ~/.config/
sleep 1

chmod -R +x ~/.config/bspwm
chmod -R +x ~/.config/polybar/scripts

echo -ne "
-------------------------------------------------------------------------
                            POLYBAR
-------------------------------------------------------------------------
"

git clone git clone --depth=1 https://github.com/adi1090x/polybar-themes.git
bash polybar-themes/setup.sh
bash ~/.config/polybar/launch.sh --cuts

echo -ne "
-------------------------------------------------------------------------
                            WALLPAPER
-------------------------------------------------------------------------
"

# Setup Wallpaper
mkdir ~/Wallpaper
cp -R wallpaper/* ~/Wallpaper
nitrogen --no-recurse ~/Wallpaper/mix_4k.jpg

echo -ne "
-------------------------------------------------------------------------
                            CURSORS
-------------------------------------------------------------------------
"

# Layan Cursors
mkdir -p $HOME/build
cd "$HOME/build"
git clone https://github.com/vinceliuice/Layan-cursors
cd Layan-cursors
sudo ./install.sh

echo -ne "
-------------------------------------------------------------------------
                            COMPLETE
-------------------------------------------------------------------------
"
sleep 3

exit