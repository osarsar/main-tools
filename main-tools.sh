#!/bin/bash

# Mettre à jour le système
echo "Mise à jour du système..."
sudo apt-get update && sudo apt-get upgrade -y

# Installer Git
echo "Installation de Git..."
sudo apt-get install -y git
git --version

# Installer Make
echo "Installation de Make (build-essential)..."
sudo apt-get install -y build-essential
make --version

# Installer Docker
echo "Installation de Docker..."
sudo apt-get remove -y docker docker-engine docker.io containerd runc
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
docker --version

# Ajouter l'utilisateur actuel au groupe Docker (pour éviter sudo avec Docker)
echo "Ajout de l'utilisateur au groupe docker..."
sudo usermod -aG docker $USER

# Installer Docker Compose
echo "Installation de Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version

echo "Installation terminée avec succès ! Veuillez redémarrer votre terminal pour appliquer les changements."

