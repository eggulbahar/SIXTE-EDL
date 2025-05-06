#!/bin/bash

echo ">>> SIXTE INIT SCRIPT RAN <<<"

# Append to .bashrc
echo 'export SIXTE=/opt/sixte/sixte' >> ~/.bashrc
echo 'export SIMPUT=/opt/sixte/simput' >> ~/.bashrc
echo '. $SIXTE/bin/sixte-install.sh' >> ~/.bashrc
#echo 'export PFILES="$HOME/pfiles:/opt/sixte/sixte/share/sixte/pfiles:/opt/sixte/simput/share/simput/pfiles:/usr/local/heasoft-6.33.2/x86_64-pc-linux-gnu-libc2.35/syspfiles"' >> ~/.bashrc
#echo 'chmod u+w /media/home/pfiles'>> ~/.bashrc

# Append to .profile
echo 'export SIXTE=/opt/sixte/sixte' >> ~/.profile
echo 'export SIMPUT=/opt/sixte/simput' >> ~/.profile
echo '. $SIXTE/bin/sixte-install.sh' >> ~/.profile
#echo 'export PFILES="$HOME/pfiles:/opt/sixte/sixte/share/sixte/pfiles:/opt/sixte/simput/share/simput/pfiles:/usr/local/heasoft-6.33.2/x86_64-pc-linux-gnu-libc2.35/syspfiles"' >> ~/.profile
#echo 'chmod u+w /media/home/pfiles'>> ~/.profile

# Source it immediately for the current shell
export SIXTE=/opt/sixte/sixte
export SIMPUT=/opt/sixte/simput
. $SIXTE/bin/sixte-install.sh

#--------------------------------
#handle parameter files
#---------------------------------
locpfiles="$HOME/pfiles"
syspfiles="$HEADAS/syspfiles"
sixtepfiles="$SIXTE/share/sixte/pfiles"
simputpfiles="$SIMPUT/share/simput/pfiles"
PFILES="$locpfiles;$syspfiles:$sixtepfiles:$simputpfiles"




