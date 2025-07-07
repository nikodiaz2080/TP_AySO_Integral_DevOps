#!/bin/bash
# Instala herramientas pedidas

set -e

if command -v apt &> /dev/null; then
  apt update -y
  apt install -y htop tmux sshpass curl
else
  dnf install -y htop tmux sshpass curl
fi
