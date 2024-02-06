#!/bin/bash

FILE_PATH="/etc/sda_passwords"

if [ -e $FILE_PATH ]
then
 echo "SDA passwords are enabled"
fi

if [ -w $FILE_PATH ]
then
 echo "You have writting permissions on $FILE_PATH"
else
 echo "You don't have writting permissions on $FILE_PATH"
fi
