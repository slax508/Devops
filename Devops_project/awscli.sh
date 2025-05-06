#!/bin/bash

# Update the package list
sudo apt update -y

# Install prerequisites
sudo apt install -y curl unzip apt-transport-https ca-certificates software-properties-common

# Install AWS CLI (latest version)
echo "Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf awscliv2.zip aws
echo "AWS CLI installed successfully."

# Install kubectl (latest version)
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl
echo "kubectl installed successfully."

# Install eksctl (latest version)
echo "Installing eksctl..."
curl -sL "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
echo "eksctl installed successfully."

# Install Docker
echo "Installing Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc
sudo apt update -y
sudo apt install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
echo "Docker installed successfully."

# Install Minikube
echo "Installing Minikube..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
rm minikube-linux-amd64
echo "Minikube installed successfully."

# Verify installations
echo "Verifying installations..."
aws --version
kubectl version --client --output=yaml
eksctl version
docker --version
minikube version

echo "All tools installed successfully."