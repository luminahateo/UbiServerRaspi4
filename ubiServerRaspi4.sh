#!/bin/sh

################################################################################
#                                                                              #
#                       Ubuntu Serveur Raspberry 4                             #
#                                                                              #
################################################################################

# utilisateur par défaut: ubuntu
# mot de pass de session: ubuntu

# connaitre son nom de machine et ip:
hostname && hostname -I

# installation du wifi
# ---------------------------------------------------------------------------- #

# connaitre ces réseaux:
ls /sys/class/net
# attendu en réponse: eth0 lo wlan0

# bloquer le changement ip au redémarrage
sudo nano /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg
# # NANO Capture:
# network: {config: disabled}
# # Ctrl+O sauvegarder
# # Ctrl+X quitter

sudo nano /etc/netplan/50-cloud-init.yaml
# NANO Capture:
# # this file generated from information provided by the datasource. Changes
# # to it will not persist across an instance reboot. To disable cloud-init’s
# # network configuration capabilities, write a file
# # /etc/cloud/cloud.cfg.d/99-disable-network-config-cfg with the following:
# # network:{config: disabled}
# network:
#    ethernets:
#        etho:
#            dhcp4: true
#            optional: true
#    version: 2
#    wifis:
#        wlan0:
#            dhcp4: true
#            dhcp6: true
#            optional: true
#            access-points:
#                "WIFI-NAME":
#                    password: "WIFI-PASSWORD"
#
# # Ctrl+O sauvegarder
# # Ctrl+X quitter
sudo netplan generate
sudo netplan apply
sudo reboot

# mise à jour système
# ---------------------------------------------------------------------------- #
sudo apt update -y && sudo apt upgrade -y

# Cockpit
# prise de commande à distance : https://ipServeur:9090
# ---------------------------------------------------------------------------- #
sudo apt install -y cockpit
systemctl enable --now cockpit.socket
firewall-cmd --add-service=cockpit --permanent
firewall-cmd --reload

# utilitaire
# ---------------------------------------------------------------------------- #
sudo apt install -y links bat htop

# Création d'un lien symbolique
# ---------------------------------------------------------------------------- #
#       entre SDD --------------------------------------- (format xfs)
#       et    CARDSD ------------------------------------ (format ext4)
# ln -s /media/nomUtilisateur/nomDuDossier /home/nomUtilisateur
