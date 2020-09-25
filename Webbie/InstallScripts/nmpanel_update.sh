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
		mv $directory/protected/config.ini /tmp
		mv $directory/protected/settings.json /tmp
		mv $directory/inc/php/dep/languages /tmp
		mv $directory/inc/img /tmp
		rm -rf $directory
		mkdir $directory
		unzip /tmp/webbie.zip -d $directory
		rm $directory/install.php
		rm $directory/install_data.php
		rm -rf $directory/inc/php/dep/languages
		rm -rf $directory/inc/img
		mv /tmp/config.ini $directory/protected
		mv /tmp/settings.json $directory/protected
		mv /tmp/languages $directory/inc/php/dep
		mv /tmp/img $directory/inc
		chmod 664 $directory/protected/config.ini
		chmod 777 $directory/protected/settings.json
		chmod 777 -R $directory/inc/php/dep/languages
		chmod 755 -R $directory/inc/img
		echo "Update complete."
	else
		echo "No panel location has been given. Updating the panel has failed."
	fi
else
    echo "This URL does not exist. Updating the panel has failed."
fi
