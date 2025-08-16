#!/bin/bash

# Este script instala o Docker Engine no Debian 11.
# Ele deve ser executado com privilégios de superusuário (root ou com sudo).

# Garante que o script pare se algum comando falhar
set -e

echo ">>> Iniciando a instalação do Docker no Debian 11..."

# 1. Atualizar a lista de pacotes e instalar pré-requisitos
echo ">>> Passo 1: Atualizando pacotes e instalando pré-requisitos..."
apt-get update
apt-get install -y ca-certificates curl gnupg

# 2. Adicionar a chave GPG oficial do Docker
echo ">>> Passo 2: Adicionando a chave GPG oficial do Docker..."
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# 3. Configurar o repositório do Docker
echo ">>> Passo 3: Configurando o repositório do Docker..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# 4. Atualizar a lista de pacotes novamente com o novo repositório
echo ">>> Passo 4: Atualizando a lista de pacotes com o repositório do Docker..."
apt-get update

# 5. Instalar o Docker Engine, CLI, containerd e plugins
echo ">>> Passo 5: Instalando o Docker Engine e seus componentes..."
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo ">>> Instalação do Docker concluída com sucesso!"
