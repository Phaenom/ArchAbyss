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
source $HOME/ArchAbyss/setup.conf

cd ~
git clone "https://aur.archlinux.org/yay.git"
cd ~/yay
makepkg -si --noconfirm
cd ~
touch "~/.cache/zshhistory"
git clone "https://github.com/Phaenom/zsh"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
ln -s "~/zsh/.zshrc" ~/.zshrc

yay -S --noconfirm --needed - < pkg-files/aur-pkgs.txt

# copy over all dotfile folders
cp -r ~/ArchAbyss/.config/* ~/.config/
sleep 1

# Layan Cursors
mkdir -p $HOME/build
cd "$HOME/build"
git clone https://github.com/vinceliuice/Layan-cursors
cd Layan-cursors
sudo ./install.sh

git clone https://github.com/adi1090x/polybar-themes

# Setup Wallpaper
mkdir ~/.local/share/fonts
mkdir ~/Wallpaper
cp -R wallpaper/* ~/Wallpaper

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
                    Enabling Essential Services
-------------------------------------------------------------------------
"
systemctl enable cups.service
ntpd -qg
systemctl enable ntpd.service
systemctl disable dhcpcd.service
systemctl stop dhcpcd.service
systemctl enable NetworkManager.service
systemctl enable bluetooth

echo -ne "
-------------------------------------------------------------------------
                            COMPLETE
-------------------------------------------------------------------------
"
exit