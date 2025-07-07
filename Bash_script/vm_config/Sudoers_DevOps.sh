#!/bin/bash
# Agrega al usuario vagrant al grupo sudoers sin contraseña

sudo echo "vagrant ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vagrant
sudo chmod 440 /etc/sudoers.d/vagrant
