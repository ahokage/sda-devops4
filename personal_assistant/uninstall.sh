#!/bin/bash

USERNAME_FILE="username.file"
LOG_PATH="logs"

echo "The app is being uninstalled"
rm $USERNAME_FILE
rm -rf $LOG_PATH


sleep 2
echo "Application uninstalled!"
