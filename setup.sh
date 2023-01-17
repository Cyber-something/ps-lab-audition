#!/bin/bash

# the name of the victim user 
USER="web"

# check if the user already exists
if ! grep -q $USER /etc/passwd
then
    # create the new user
    useradd -m -s /bin/bash $USER
   
    # set a default passwrod
    echo "web:l3tmein" | chpasswd
fi


