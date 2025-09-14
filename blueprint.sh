#!/bin/bash
set -e

sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
apt-get update
apt-get install -y nodejs

npm i -g yarn

cd /var/www/pterodactyl
yarn

apt install -y zip unzip git curl wget

wget "$(curl -s https://api.github.com/repos/BlueprintFramework/framework/releases/latest | grep 'browser_download_url' | cut -d '"' -f 4)" -O release.zip

mv release.zip /var/www/pterodactyl/release.zip
cd /var/www/pterodactyl
unzip release.zip

touch /var/www/pterodactyl/.blueprintrc

echo \
'WEBUSER="www-data";
OWNERSHIP="www-data:www-data";
USERSHELL="/bin/bash";' >> /var/www/pterodactyl/.blueprintrc

chmod +x blueprint.sh
bash blueprint.sh

wget "https://drive.usercontent.google.com/u/2/uc?id=1Bh6cQ2GoWMKRIOUqdGWqxzb8LcN0bhQ5&export=download" -O nebula.blueprint
mv nebula.blueprint /var/www/pterodactyl

cd /var/www/pterodactyl
blueprint -install nebula
