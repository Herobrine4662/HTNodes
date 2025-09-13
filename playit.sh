#!/bin/bash
set -e

# ----------------- Helper functions ----------------- #
output() { echo "[*] $1"; }
success() { echo "[✔] $1"; }
error() { echo "[✖] $1"; }

# ----------------- Main commands ----------------- #

output "Adding Playit Cloud GPG key..."
curl -SsL https://playit-cloud.github.io/ppa/key.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/playit.gpg >/dev/null

output "Adding Playit Cloud repository..."
echo "deb [signed-by=/etc/apt/trusted.gpg.d/playit.gpg] https://playit-cloud.github.io/ppa/data ./" | sudo tee /etc/apt/sources.list.d/playit-cloud.list

output "Updating package lists..."
sudo apt update

output "Installing playit..."
sudo apt install -y playit

output "Starting and enabling playit service..."
sudo systemctl start playit
sudo systemctl enable playit

output "Running playit setup..."
playit setup

success "Playit installation and setup completed successfully!"
