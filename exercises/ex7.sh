#!/bin/bash

 DIRECTORY=$1

function file_counter()  {
 NUMBER_OF_FILES=$(ls -l $DIRECTORY | wc -l)
echo "$DIRECTORY"
echo "$NUMBER_OF_FILES"
}

file_counter
