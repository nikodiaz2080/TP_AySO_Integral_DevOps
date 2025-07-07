#!/bin/bash
# Configura IP estática en Fedora sobre eth1 (interfaz privada Vagrant)

if command -v dnf &> /dev/null; then # Fedora
  ip=$(getent hosts fedora-vm | awk 'NR==1 { print $1 }')

  sudo nmcli connection delete "Wired connection 2"
  sudo nmcli con add type ethernet ifname "eth1" con-name "Wired connection 2" ipv4.method manual ipv4.addresses "$ip/24" ipv4.gateway "192.168.56.1" ipv4.never-default yes
  sudo nmcli con up "Wired connection 2"
fi
