#!/bin/bash

cat /etc/passwd

if [ "$?" -eq "0" ]
then 
 echo "OK"
 exit 0
else
 echo "NO"
 exit 1
fi
