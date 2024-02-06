#!/bin/bash
clear
#setup
USERNAME_FILE="username.file"
LOGS_FOLDER="logs"
UNINSTALL_SCRIPT="uninstall.sh"
RUN_SCRIPT="run.sh"

read -p "Please enter your name: " USERNAME
#validation
if [[ -e $USERNAME_FILE ]]
then
        echo "The application is already installed."
        sleep 2
        exit 0
fi
if [ -z $USERNAME ]
then
        echo "The provided username is not valid, installer exiting..."
        sleep 2
        exit 0
fi
if [ -d $LOGS_FOLDER ]
then
        echo "Logs directory already exists, cannot install the application here."
        sleep 2
        exit 0
fi
echo $USERNAME > $USERNAME_FILE
mkdir $LOGS_FOLDER
if ! [ -x $UNINSTALL_SCRIPT ]
then
        chmod u+x $UNINSTALL_SCRIPT
fi

if ! [ -x $RUN_SCRIPT ]
then 
	chmod u+x $RUN_SCRIPT
fi

sleep 1.5 

echo "Application is installed!"

read -p "Do you want to start the app? (press 'y' for yes or anything else to continue)" ANSWER

if [[ $ANSWER=="y" ]]
then 
	source run.sh
fi
