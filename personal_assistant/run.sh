#!/bin/bash

clear

#Setup
USERNAME_FILE="username.file"
USERNAME=""
LOG_FOLDER="logs"
IS_NUMBER_EXPR="^[0-9]+$"
MAIN_MENU_EXIT_CODE=0
SONG_MENU_EXIT_CODE=0

ACTIVITY_SCRIPT_PATH="resources/activities/activity.sh"
JOKES_SCRIPT_PATH="resources/jokes/jokes.sh"
WEATHER_SCRIPT_PATH="resources/weather/weather.sh"

LYRICS_FOLDER_PATH='resources/lyrics'

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
	declare -a MENU_ITEMS=('Show me the date!' 'Show me todays logs' 'What should I do today?' 'Tell me a joke' 'Show me the weather for next week' 'Show me some lyrics' )
	
	COUNTER=1
	
	for i in ${!MENU_ITEMS[@]}
	do
		echo "($COUNTER) - ${MENU_ITEMS[$i]}"
		((COUNTER++))
	done
	
	((MAIN_MENU_EXIT_CODE=COUNTER))

	echo "($COUNTER) - Exit app"
}


#show logs function
function show_logs() {
	DAILY_LOGFILE_NAME=$(date +%F).log
        LOGFILE_PATH=$LOG_FOLDER/$DAILY_LOGFILE_NAME
	
	cat $LOGFILE_PATH
}

#execute script function
function check_and_execute_script () {
	SCRIPT_PATH=$1

	#check if argument is passed
	if [ -z $SCRIPT_PATH ]
	then
		echo "Parameter not provided"
	#check if file exists
	elif ! [ -f $SCRIPT_PATH ]
	then
		echo "$SCRIPT_PATH does not exist!"	
	#check if we have executing permissions on this file
	elif ! [ -x $SCRIPT_PATH ]
	then
		chmod u+x $SCRIPT_PATH
	#execute file
	else
		source $SCRIPT_PATH
	fi
}

#display song lyrics menu
function display_song_list () {

	SONG_LIST=($(ls $LYRICS_FOLDER_PATH))
	
	COUNTER=1

	echo "-------------------------------------------------"
	for i in ${!SONG_LIST[@]}
        do
                echo "($COUNTER) - ${SONG_LIST[$i]}"
                ((COUNTER++))
        done

	((SONG_MENU_EXIT_CODE=COUNTER))
        echo "($COUNTER) - <- Go Back"
	echo "-------------------------------------------------"
}

function display_song_lyrics_menu () {

	SONG_LIST=($(ls $LYRICS_FOLDER_PATH))

	while true
	do
		display_song_list

		read -p "Choose a song from the list above or choose 'Go Back' to return to the main menu: " SONG_OPTION

		case "$SONG_OPTION" in
			"$SONG_MENU_EXIT_CODE")
				echo "Returning to main menu"
				sleep 0.8
				clear
				break;;
			*)
				      #is number     			#is greater than 0     #lower or equals to number of songs in array
				if [[ $SONG_OPTION =~ $IS_NUMBER_EXPR && $SONG_OPTION -gt 0 && $SONG_OPTION -le ${#SONG_LIST[@]} ]]
				then
					((SONG_OPTION--))
					
					echo ""
					cat $LYRICS_FOLDER_PATH/${SONG_LIST[$SONG_OPTION]}
					read -n 1 -r -s -p "Press any key to display song selection menu..." key
					echo ""
					
				else
					echo "Please provide a correct value!"
				fi

		esac

	done
}



#App Login
log_action "**************************************************"
log_action "Started the application"

while true 
do

	echo ""
	echo "******************************"
	echo "How may I help you today?"
	echo "******************************"

	display_menu

	read -p "Choose an option: " OPTION
	echo "******************************"
	echo ""

	case "$OPTION" in
		"1")
			sleep 0.8
			log_action "Asked for the date"
			echo "Hey $USERNAME, the date is $(date)"
			;;
		"2")
			sleep 0.8
			log_action "Asked to see today''s logs"
			show_logs
			;;
		"3")
			sleep 0.8
			log_action "Asked for an activity"
			check_and_execute_script $ACTIVITY_SCRIPT_PATH
			;;
		"4")
			sleep 0.8
			log_action "Asked for a joke"
			check_and_execute_script $JOKES_SCRIPT_PATH
			;;
		"5")
			sleep 0.8
			log_action "Asked for the weather"
			check_and_execute_script $WEATHER_SCRIPT_PATH
			;;
		"6")
			sleep 0.8
			log_action "Asked for lyrics"
			display_song_lyrics_menu
			;;
		"$MAIN_MENU_EXIT_CODE")
			echo "Thank you for using this App. The app will shut down in 2 seconds... Goodbye $USERNAME!"
			sleep 2
			break;;
		*)
			sleep 0.8
			echo "Please input a correct value!"
	esac

done

log_action "Exiting the app"
log_action "**************************************************"

exit 0
