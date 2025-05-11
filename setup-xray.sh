#!/bin/bash

# Step 1: Create the xray-proxy folder and navigate into it
mkdir -p xray-proxy
cd xray-proxy || exit

# Step 2: Create the config.json file with the given content
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

# Step 3: Create the docker-compose.yml file with the given content
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

# Step 4: Run the container
docker-compose up -d
