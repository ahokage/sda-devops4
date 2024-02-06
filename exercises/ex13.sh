#!/bin/bash

#Setup
DAYS_OF_THE_WEEK="Mon Tue Wed Thu Fri Sat Sun"
COUNTER=1
CURRENT_DAY_NUMBER=$(date +%u)
SIGN=""

#Logic
for DAY in $DAYS_OF_THE_WEEK
do
	if (( $COUNTER==$CURRENT_DAY_NUMBER ))
	then
		SIGN=" [*]"
	else
		SIGN=""
	fi
	echo "Weekday ${COUNTER}: ${DAY}${SIGN}"
	((COUNTER++))
done
