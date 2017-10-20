#! /usr/bin/env bash
# Run upgrades
sudo apt-get update && sudo apt-get upgrade –y
# Configure password authentication for xrdp
sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Restart ssh server (xrdp) so that password authentication is setup
sudo /etc/init.d/ssh restart
# Install xrdp, the xfce4 desktop environment with some plug-ins and a virtual network computer (vnc) server
sudo apt install xrdp xfce4 xfce4-goodies tightvncserver
# Make xfce4 the default window manager for RDP connections
echo xfce4-session> /home/ubuntu/.xsession
# Copy .xsession to the /etc/skel folder so that xfce4 is set as the default window manager for any new user accounts that are created
sudo cp /home/ubuntu/.xsession /etc/skel
# Run the sed command to update the [xrdp1] section of /etc/xrdp/xrdp.ini to allow changing of the host port you will connect to
sudo sed -i '0,/-1/s//ask-1/' /etc/xrdp/xrdp.ini
# Restart xrdp
sudo service xrdp restart
