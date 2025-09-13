#!/bin/bash
set -e

echo "==============================="
echo "     Tailscale Installer"
echo "==============================="
echo "1) Install Tailscale"
echo "2) Uninstall Tailscale"
echo
read -rp "Choose an option [1/2]: " choice

install_tailscale() {
    echo "Installing Tailscale..."
    curl -fsSL https://tailscale.com/install.sh | sh

    if systemctl list-unit-files | grep -q tailscaled; then
        systemctl enable --now tailscaled
        echo "Tailscale service started and enabled!"
    fi

    echo
    echo "Run 'tailscale up' to log in and start using Tailscale."
}

uninstall_tailscale() {
    echo "Stopping and disabling Tailscale..."
    systemctl stop tailscaled || true
    systemctl disable tailscaled || true

    echo "Removing Tailscale packages..."
    if command -v apt >/dev/null 2>&1; then
        apt remove --purge -y tailscale tailscale-archive-keyring
    elif command -v yum >/dev/null 2>&1; then
        yum remove -y tailscale
    elif command -v dnf >/dev/null 2>&1; then
        dnf remove -y tailscale
    elif command -v pacman >/dev/null 2>&1; then
        pacman -Rns --noconfirm tailscale
    elif command -v apk >/dev/null 2>&1; then
        apk del tailscale
    fi

    echo "Tailscale has been uninstalled."
}

case "$choice" in
    1)
        install_tailscale
        ;;
    2)
        uninstall_tailscale
        ;;
    *)
        echo "Invalid option. Exiting."
        exit 1
        ;;
esac
