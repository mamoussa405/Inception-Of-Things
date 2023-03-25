#!/bin/bash
GR='\033[0;32m'
NC='\033[0m' # No Color
CYAN='\033[0;36m'

echo "${CYAN}==> Deleting existing k3d cluster...${NC}"
sudo k3d cluster delete iot-cluster

echo "${CYAN}==> Creating k3d cluster...${NC}"
sudo k3d cluster create iot-cluster -p "8888:30080"

echo "${CYAN}==> Creating a namespace for ArgoCD...${NC}"
sudo kubectl create namespace argocd

echo "${CYAN}==> Installing ArgoCD in the k3d cluster...${NC}"
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "${CYAN}==> Running ArgoCD and waiting for the pods to be ready...${NC}"
sleep 5;
sudo kubectl wait -n argocd --for=condition=Ready pods --all --timeout=-1s

echo "${CYAN}==> Getting ArgoCD password...${NC}"
sudo kubectl get secret argocd-initial-admin-secret -n argocd -o yaml | grep " password:" | cut -d ":" -f 2 | cut -d " " -f 2 | base64 --decode && echo

echo "${CYAN}==> Creating a namespace for development...${NC}"
sudo kubectl create namespace dev

echo "${CYAN}==> Creating a CRD for ArgoCD...${NC}"
sudo kubectl apply -f ../confs/application.yaml
while [ "$POD_STATE" != "Running" ]; do echo "Waiting for app to be created";
POD_STATE=$(sudo kubectl get po -n dev  --output="jsonpath={.items..phase}") && sleep 10;
done;

echo "${CYAN}==> Forwarding port 8080 to the argocd-server service...${NC}"
while true; do sudo kubectl port-forward svc/argocd-server -n argocd 8080:443; done > /dev/null 2>&1 &
