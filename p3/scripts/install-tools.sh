#!/bin/bash
GR='\033[0;32m'
NC='\033[0m' # No Color
CYAN='\033[0;36m'
echo "----------------- ${GR}Installing Docker${NC} -------------------------------"
echo "${CYAN}==> Removing older versions...${NC}"
# Uninstall any older versions before attempting to install a new version
sudo apt-get -y remove docker docker-engine docker.io containerd runc
echo "${CYAN}==> Updating apt to the newer versions...${NC}"
# Update apt to the newer versions, and install the required packages to allow apt to use a repository over HTTPS
sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
echo "${CYAN}==> Adding Docker's official GPG key...${NC}"
# Add Docker’s official GPG key
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL -y https://download.docker.com/linux/ubuntu/gpg | sudo gpg -y --dearmor -o /etc/apt/keyrings/docker.gpg
echo "${CYAN}==> Seting up the repository...${NC}"
# Set up the repository
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "${CYAN}==> Granting read permission for the Docker public key...${NC}"
# Try granting read permission for the Docker public key file before updating the package index to avoid receiving a GPG error when runing apt-gat update
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "${CYAN}==> Updating the repo & installing Docker Engine...${NC}"
# Update the repo
sudo apt-get update
# Install Docker Engine, containerd, and Docker Compose
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Verify that the Docker Engine installation is successful by running the hello-world image
sudo docker run hello-world

echo "----------------- ${GR}Installing Kubectl${NC} -------------------------------"
sudo rm /usr/local/bin/kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo "----------------- ${GR}Installing k3d${NC} -------------------------------"
sudo rm $(which k3d)
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
