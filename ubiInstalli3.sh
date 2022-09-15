#!/bin/sh

################################################################################
#                                                                              #
#                       Ubuntu Serveur Raspberry 4                             #
#                                                                              #
################################################################################

# installation d'un interface graphique
# Environnement: i3
# ---------------------------------------------------------------------------- #

# installation d'utilitaires pour installation
sudo apt install -y git make gcc autoconf

# installation du X11
sudo apt install -y xorg xinit

# installation dépendences
sudo apt install -y libpango1.0-dev libyajl-dev libstartup-notification0-dev libev-dev libtool libxkbcommon-dev libxkbcommon-x11-dev libxcb1-dev libxcb-randr0-dev libxcb-util0-dev libxcb-icccm4-dev libxcb-keysyms1-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-shape0-dev libxcb-xrm-dev xutils-dev

# installation i3
git clone https://github.com/resloved/i3
cd i3
autoreconf --force --install
rm -rf build
mkdir build
cd build
../configure --prefix=/usr --sysconfdir=/etc
make
sudo make install

# création du xinitrc
nano ~/.xinitrc
# # NANO Capture:
#
# #!/bin/sh
# #/etc/X11/xinit/xinitrc
# # global xinitrc file, used by all X sessions started by xinit (startx)
# exec /usr/bin/i3
#
# # Ctrl+O sauvegarder
# # Ctrl+X quitter

# démarrage
startx

# i3 à distance
sudo apt install xrdp
nano ~/.xsessions
# # NANO Capture:
#
# #!/bin/sh
# exec /usr/bin/i3
#
# # Ctrl+O sauvegarder
# # Ctrl+X quitter
sudo systemctl restart xrdp.service
