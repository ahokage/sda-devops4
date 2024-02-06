#!/bin/bash

#inputs
read -p "Please input the number of lines you want to print: " NUMBER_OF_LINES

#validations
REGEX_EXPR='^[0-9]+$'
if ! [[ $NUMBER_OF_LINES =~ $REGEX_EXPR ]]
then
 echo "The provided value was not in the requested format"
 exit 1
fi

#logic
LINE_NUMBER=1
while read LINE
do
  if (( ${LINE_NUMBER} <= ${NUMBER_OF_LINES} ))
  then
    echo "${LINE_NUMBER}: ${LINE}"
    ((LINE_NUMBER++))
  fi
done < /etc/passwd
