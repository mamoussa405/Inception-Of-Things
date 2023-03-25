#!/bin/bash
SERVER_IP=$1

sudo mkdir /vagrant/.confs
sudo touch /vagrant/.confs/server_token.txt
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --flannel-iface=eth1" sh - && echo "k3s server installed successfully......"
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/.confs/server_token.txt
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/.confs/
sudo apt install -y net-tools > /dev/null
