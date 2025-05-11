````markdown
# 🛰 Xray Proxy Setup

This project provides a simple script to set up a SOCKS5 proxy using [Xray](https://github.com/XTLS/Xray-core) and Docker.

---

## 📦 Features

- Creates an `xray-proxy` directory
- Generates a default `config.json` for a SOCKS proxy with no authentication
- Adds a `docker-compose.yml` to run Xray in Docker
- Automatically starts the proxy using Docker Compose

---

## ⚠️ Prerequisite

> **Docker and Docker Compose must be pre-installed** on your server before running the script.

### To install Docker & Docker Compose:

```bash
# Install Docker
curl -fsSL https://get.docker.com | sudo bash

# Install Docker Compose
sudo apt install docker-compose -y
````

---

## 🚀 Quick Start (Run directly from GitHub)

### Using `curl`

```bash
bash <(curl -s https://raw.githubusercontent.com/p-shubh/x-ray/main/setup-xray.sh)
```

### Using `wget`

```bash
bash <(wget -qO- https://raw.githubusercontent.com/p-shubh/x-ray/main/setup-xray.sh)
```

---

## 🛠 Manual Setup (Alternative)

1. **Clone the Repository**

   ```bash
   git clone https://github.com/p-shubh/x-ray.git
   cd x-ray
   ```

2. **Run the Setup Script**

   ```bash
   chmod +x setup-xray.sh
   ./setup-xray.sh
   ```

---

## 🔌 Proxy Access Info

Once the container is up, the SOCKS5 proxy will be available at:

```
IP Address: <your-server-ip>
Port:      1080
Protocol:  SOCKS5
Auth:      No Authentication
```

Use it with tools like browsers, `curl`, or `proxychains`.

---

## 🧼 To Stop or Remove

```bash
cd xray-proxy
docker-compose down
```

---

## 📄 License

MIT License
© [p-shubh](https://github.com/p-shubh)

```

---

Let me know if you'd like a badge (like Docker or License) added at the top of the README!
```
