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

echo "[*] Starting the container..."

# Detect whether 'docker-compose' or 'docker compose' is available
if command -v docker-compose &> /dev/null; then
    docker-compose up -d
elif docker compose version &> /dev/null; then
    docker compose up -d
else
    echo "❌ Error: Neither 'docker-compose' nor 'docker compose' was found. Please install Docker Compose."
    exit 1
fi

echo "[✓] Xray SOCKS proxy is up and running on port 1080."
