#!/bin/bash

set -e

# Install required packages
sudo apt-get install -y ca-certificates curl gnupg zip unzip git wget

# Setup Node.js 20 repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install -y nodejs

# Install Yarn globally
sudo npm i -g yarn

# Ensure the working directory exists
mkdir -p /var/www/pterodactyl
cd /var/www/pterodactyl || exit

# Install Node dependencies
yarn || true

# Download latest Blueprint release
LATEST_URL=$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest \
    | grep 'browser_download_url' | cut -d '"' -f 4)

wget -O release.zip "$LATEST_URL" || true

# Move or overwrite release.zip
cp -f release.zip /var/www/pterodactyl/release.zip

# Unzip the release
unzip -o /var/www/pterodactyl/release.zip -d /var/www/pterodactyl

# Configure Blueprint
cat > /var/www/pterodactyl/.blueprintrc <<EOL
WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";
EOL

# Make the script executable and run
chmod +x blueprint.sh
bash blueprint.sh || true

# Download Nebula blueprint
wget -O nebula.blueprint "https://drive.usercontent.google.com/u/2/uc?id=1Bh6cQ2GoWMKRIOUqdGWqxzb8LcN0bhQ5&export=download" || true
cp -f nebula.blueprint /var/www/pterodactyl

# Install Nebula blueprint
cd /var/www/pterodactyl || exit
blueprint -install nebula || true

echo "Blueprint installation finished successfully!"
