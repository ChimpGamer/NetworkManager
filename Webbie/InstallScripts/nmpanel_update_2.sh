#!/bin/bash
#
# Execute this script with sudo!
#
#
read -p 'Set Web Directory (Example: /var/www/html/networkmanager) ' directory
read -p 'Copy the download link of the NetworkManager file in Discord  ' downloadlink

if curl --output /dev/null --silent --head --fail "$downloadlink"
then
	if [ ! -z "$directory" ]
	then
		echo "Starting updating the panel..."
		cd /tmp
		wget -O webbie.zip $downloadlink
		mv $directory/inc/php/dep/protected/config.php /tmp
		mv $directory/inc/json/protected/settings.json /tmp
		mv $directory/inc/php/dep/languages /tmp
		rm -rf $directory
		mkdir $directory
		unzip /tmp/webbie.zip -d $directory
		rm -rf $directory/inc/php/dep/languages
		mv /tmp/config.php $directory/inc/php/dep
		mv /tmp/settings.json $directory/inc/json
		mv /tmp/languages $directory/inc/php/dep
		chmod 664 $directory/inc/php/dep/config.php
		chmod 777 $directory/inc/json/settings.json
		chmod 777 -R $directory/inc/php/dep/languages
		echo "Update complete."
	else
		echo "No panel location has been given. Updating the panel has failed."
	fi
else
    echo "This URL does not exist. Updating the panel has failed."
fi
