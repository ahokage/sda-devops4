#!/bin/bash

while true
do
        echo "(a or A) Display disk usage."
        echo "(b or B) Display system uptime."
        echo "(c or C) Display logged user."
        echo "(q or Q or exit) Quit."
        read -p "Choose an option: " OPTION

        case "$OPTION" in
		"a"|"A")
			echo $(df);;
		"b"|"B")
			echo $(uptime);;
		"c"|"C")
			echo $(who);;
		"q"|"Q"|"exit")
			echo "Goodbye!"
			exit 0;;
		*)
			echo "The chosen option is not valid"
        esac
        echo " "
done
