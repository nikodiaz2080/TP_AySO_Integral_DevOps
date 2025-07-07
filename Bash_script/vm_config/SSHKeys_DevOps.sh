#!/bin/bash
# Cruza claves SSH entre las máquinas para login sin contraseña

set -e

PATH_SSH="/home/vagrant/.ssh"
UBUNTU_IP=$(getent hosts ubuntu-vm | awk 'NR==1 { print $1 }')
FEDORA_IP=$(getent hosts fedora-vm | awk 'NR==1 { print $1 }')

if [ ! -f $PATH_SSH/id_rsa ]; then
  sudo -u vagrant ssh-keygen -t rsa -b 2048 -f $PATH_SSH/id_rsa -N ""
fi

sudo -u vagrant ssh-keyscan -H $UBUNTU_IP >> "$PATH_SSH/known_hosts"
sudo -u vagrant ssh-keyscan -H $FEDORA_IP >> "$PATH_SSH/known_hosts"

if command -v dnf &> /dev/null; then # Fedora
  sudo -u vagrant sshpass -p vagrant ssh-copy-id -i "$PATH_SSH/id_rsa.pub" vagrant@$UBUNTU_IP # Copiar llave Fedora a Ubuntu
  sudo -u vagrant ssh -o StrictHostKeyChecking=no vagrant@$UBUNTU_IP "cat $PATH_SSH/id_rsa.pub" > /tmp/ubuntu_key.pub # Extraer llave Ubuntu a Fedora
  
  sudo cat /tmp/ubuntu_key.pub >> "$PATH_SSH/authorized_keys" # Autorizar llave de Ubuntu en Fedora
  sudo chown vagrant:vagrant "$PATH_SSH/authorized_keys"
  sudo chmod 600 "$PATH_SSH/authorized_keys"                                       
fi
