#!/bin/bash
#
# Execute this script with sudo!
#
#

######
#
# Environmental Variables for the script
#
# You shouldn't need or want to change these
#
# Path to temp directory
WEBBIE_TEMP_DIR=/tmp
#
# Webbie Download Path
WEBBIE_DOWNLOAD_PATH=$WEBBIE_TEMP_DIR/webbie.zip
#
######

#################################### === DO NOT CHANGE ANYTHING UNDER HERE - YOU WILL PROBABLY BREAK SOMETHING === #################################### 

read -p 'Set Web Directory (Example: /var/www/html/networkmanager) ' directory
read -p 'Copy the download link of the NetworkManager file in Discord  ' downloadlink

echo "Attempting to download the file"
wget -O $WEBBIE_DOWNLOAD_PATH $downloadlink

if test -f $WEBBIE_DOWNLOAD_PATH;
then
	if [ ! -z "$directory" ]
	then
		echo "Starting updating the panel..."
		cd $WEBBIE_TEMP_DIR
		mv $directory/protected/config.ini $WEBBIE_TEMP_DIR
		mv $directory/protected/settings.json $WEBBIE_TEMP_DIR
		mv $directory/inc/php/dep/languages $WEBBIE_TEMP_DIR
		mv $directory/inc/img $WEBBIE_TEMP_DIR
		mv $directory/addons $WEBBIE_TEMP_DIR
		rm -rf $directory
		mkdir -p $directory
		unzip $WEBBIE_DOWNLOAD_PATH -d $directory
		rm $directory/install.php
		rm $directory/install_data.php
		rm -rf $directory/inc/php/dep/languages
		rm -rf $directory/inc/img
		rm -rf $directory/addons
		mv $WEBBIE_TEMP_DIR/config.ini $directory/protected
		mv $WEBBIE_TEMP_DIR/settings.json $directory/protected
		mv $WEBBIE_TEMP_DIR/languages $directory/inc/php/dep
		mv $WEBBIE_TEMP_DIR/img $directory/inc
		mv $WEBBIE_TEMP_DIR/addons $directory
		chmod 664 $directory/protected/config.ini
		chmod 777 $directory/protected/settings.json
		chmod 777 -R $directory/inc/php/dep/languages
		chmod 755 -R $directory/inc/img
		echo "Update complete. Cleaning up downloaded file"
		rm -f $WEBBIE_DOWNLOAD_PATH
		exit 0
	else
		echo "No panel location has been given. Updating the panel has failed. Cleaning up download"
		rm -f $WEBBIE_DOWNLOAD_PATH
		exit 1
	fi
else
    echo "This URL is invalid or does not exist. Updating the panel has failed. Running cleanup..."
    rm -f $WEBBIE_DOWNLOAD_PATH
    exit 1
fi
