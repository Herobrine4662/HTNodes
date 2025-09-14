#!/bin/bash
set -e

echo "[*] Generating self-signed SSL certificate..."
mkdir -p /etc/certs
cd /etc/certs

openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
  -subj "/C=NA/ST=NA/L=NA/O=NA/CN=Generic SSL Certificate" \
  -keyout privkey.pem -out fullchain.pem

echo "[+] SSL certificate generated at /etc/certs/"
