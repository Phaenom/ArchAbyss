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
                    Automated Arch Linux Setup
                        SCRIPTHOME: ArchAbyss
-------------------------------------------------------------------------
"

# copy over all dotfile folders
cp -r .config/* ~/.config/
sleep 1

chmod -R +x ~/.config/bspwm
chmod -R +x ~/.config/polybar/scripts

sudo pacman -Syu --needed --noconfirm - < pkg-files/pacman-pkgs.txt
sudo fc-cache -f -v

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~
touch "~/.cache/zshhistory"
git clone "https://github.com/Phaenom/zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -s "~/zsh/.zshrc" ~/.zshrc

cp -r .xinitrc /etc/X11/xinit/xinitrc

echo -ne "
-------------------------------------------------------------------------
                    Enabling Login Display Manager
-------------------------------------------------------------------------
"
systemctl enable sddm.service

echo -ne "
-------------------------------------------------------------------------
                    Setting up SDDM Theme
-------------------------------------------------------------------------
"
cat <<EOF > /etc/sddm.conf
[Theme]
Current=Nordic
EOF

echo -ne "
-------------------------------------------------------------------------
                            COMPLETE
-------------------------------------------------------------------------
"

sleep 5
exit