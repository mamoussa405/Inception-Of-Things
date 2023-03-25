#!/bin/bash
SERVER_IP=$1
SERVER_PORT=6443
SERVER_URL="https://${SERVER_IP}:${SERVER_PORT}"
K3S_TOKEN_FILE="/vagrant/.confs/server_token.txt"

curl -sfL https://get.k3s.io | K3S_URL=${SERVER_URL} K3S_TOKEN_FILE=${K3S_TOKEN_FILE}  INSTALL_K3S_EXEC="--flannel-iface=eth1" sh - && echo "K3s Agent is Running ......."
sudo rm -rf /vagrant/.confs
sudo apt install -y net-tools > /dev/null
