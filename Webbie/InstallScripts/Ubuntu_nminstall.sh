#!/bin/bash
#
# Execute this script with sudo!
#
read -p 'Set Web Directory (Example: /var/www/html/networkmanager) ' directory
read -p 'Copy the download link of the NetworkManager file in Discord  ' downloadlink
#
#
cd /tmp
#
#
apt-get install -y software-properties-common
#
add-apt-repository ppa:ondrej/php
#
apt-get update
apt-get install -y sudo apache2 nano zip
#
apt-get install -y php7.2 php7.2-cli php7.2-cgi php7.2-curl php7.2-mysql php7.2-common php7.2-pdo php7.2-xml php7.2-mbstring libapache2-mod-php7.2
#
a2enmod rewrite
service apache2 restart
#
wget -O webbie.zip $downloadlink
mkdir $directory
unzip /tmp/webbie.zip -d $directory
#
chmod 777 $directory/inc/php/dep/protected/config.php
chmod 777 $directory/inc/json/protected/settings.json
chmod 777 -R $directory/inc/php/dep/languages
#
exit
