#!/bin/bash
# Agrega entradas a /etc/hosts para resolución de nombres

sudo cat <<EOF >> /etc/hosts
192.168.56.10 ubuntu-vm
192.168.56.11 fedora-vm
EOF
