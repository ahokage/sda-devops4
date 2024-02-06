#!/bin/bash

USER_PATHS=$@


for USER_PATH in $USER_PATHS
do

if [ -f $USER_PATH ]
then
 echo "The path represents a file"
elif [ -d $USER_PATH ]
then
 echo "The path represents a directory"
else
 echo "The path represents another type of file"
fi

ls -l $USER_PATH

done
