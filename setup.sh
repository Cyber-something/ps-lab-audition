#!/bin/bash

USER="web"

if ! grep -q $1 /etc/passwd
then
    # User does not exist
    useradd $USER
    passwd $USER --stdin
fi



