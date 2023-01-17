#!/bin/bash

USER="web"

# remove the user and the home directory
userdel -fr $USER 2> /dev/null