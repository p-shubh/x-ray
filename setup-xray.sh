#!/bin/bash

set -e

echo "[*] Creating xray-proxy directory..."
mkdir -p xray-proxy
cd xray-proxy

echo "[*] Creating config.json..."
cat <<EOF > config.json
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 1080,
      "listen": "0.0.0.0",
      "protocol": "socks",
      "settings": {
        "auth": "noauth",
        "udp": true
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}
EOF

echo "[*] Creating docker-compose.yml..."
cat <<EOF > docker-compose.yml
version: "3.8"

services:
  xray-socks:
    image: teddysun/xray
    container_name: xray-socks
    restart: unless-stopped
    ports:
      - "1080:1080"
    volumes:
      - ./config.json:/etc/xray/config.json
EOF

echo "[*] Checking for Docker Compose..."

if command -v docker-compose &> /dev/null; then
    echo "[✓] docker-compose found. Starting the container..."
    docker-compose up -d
elif docker compose version &> /dev/null; then
    echo "[✓] docker compose found. Starting the container..."
    docker compose up -d
else
    echo "[!] Docker Compose not found. Installing docker-compose v1..."

    # Install Docker Compose v1 (for Linux x86_64)
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Verify installation
    if command -v docker-compose &> /dev/null; then
        echo "[✓] docker-compose installed successfully. Starting the container..."
        docker-compose up -d
    else
        echo "❌ Failed to install docker-compose. Please install it manually."
        exit 1
    fi
fi

echo "[✓] Xray SOCKS proxy is up and running on port 1080."
