#!/bin/bash
SERVER_IP=$1

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--bind-address=${SERVER_IP} --flannel-iface=eth1" sh - && echo "k3s server installed successfully......"
sudo apt install -y net-tools > /dev/null
sudo sh /vagrant/scripts/apps-setup.sh
