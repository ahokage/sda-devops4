#!/bin/bash

clear

#Setup
USERNAME_FILE="username.file"
USERNAME=""
LOG_FOLDER="logs"
IS_NUMBER_EXPR="^[0-9]+$"

#Check if userfile is present
if ! [ -e $USERNAME_FILE ]
then
	echo "The app is not installed. Exiting..."
	sleep 1.5
	exit 0
fi

#Say hello to user
USERNAME=$(<$USERNAME_FILE)
echo "Greetings $USERNAME"

#setup a log method
function log_action() {
	DAILY_LOGFILE_NAME=$(date +%F).log
	LOGFILE_PATH=$LOG_FOLDER/$DAILY_LOGFILE_NAME
	LOG_LINE=$1

	if ! [ -e $LOGFILE_PATH ]
	then
		touch $LOGFILE_PATH
	fi
	
	if ! [ -z "$LOG_LINE" ]
	then
		echo "$(date +'%F %T') User $USERNAME -> $LOG_LINE" >> $LOGFILE_PATH
	fi
}

#display a menu
function display_menu() {
	declare -a MENU_ITEMS=('Show me the date!' 'Show me todays logs' 'New menu')
	COUNTER=1
	
	for i in ${!MENU_ITEMS[@]}
	do
		echo "($COUNTER) - ${MENU_ITEMS[$i]}"
		((COUNTER++))
	done
	
	echo "($COUNTER) - Exit app"
}

log_action "Started the application"

while true 
do
	display_menu

	read -p "Choose an option: " OPTION

	case "$OPTION" in
		"1")
			sleep 0.8
			log_action "Asked for the date"
			echo "Hey $USERNAME, the date is $(date)"
			;;
		"2")
			exit 0;;
	esac

done


