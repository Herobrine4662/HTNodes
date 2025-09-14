#!/bin/bash

while true; do
    clear
    echo "========= HTNodes Installer ========="
    echo "1) Install Playit"
    echo "2) Install Tailscale"
    echo "3) Install Pterodactyl Panel"
    echo "4) Install Pterodactyl Wings"
    echo "5) Install SSL Certificates"
    echo "6) HTNodes Startup"
    echo "7) Exit"
    echo "====================================="
    read -p "Choose an option: " choice

    case $choice in
        1)
            bash <(curl -sSL https://raw.githubusercontent.com/Herobrine4662/HTNodes/main/playit.sh)
            ;;
        2)
            bash <(curl -sSL https://raw.githubusercontent.com/Herobrine4662/HTNodes/main/tailscale.sh)
            ;;
        3)
            bash <(curl -sSL https://raw.githubusercontent.com/Herobrine4662/HTNodes/main/panel.sh)
            ;;
        4)
            bash <(curl -sSL https://raw.githubusercontent.com/Herobrine4662/HTNodes/main/wings.sh)
            ;;
        5)
            bash <(curl -sSL https://raw.githubusercontent.com/Herobrine4662/HTNodes/main/ssl.sh)
            ;;
        6)
            bash <(curl -sSL https://raw.githubusercontent.com/Herobrine4662/HTNodes/main/start.sh)
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice!"
            sleep 2
            ;;
    esac
done
