#!/bin/bash

#-----------------------------------------------------------------------
# Test when launching container script to make sure this script has run
#-----------------------------------------------------------------------
echo ">>> SIXTE INIT SCRIPT RAN <<<"

#-------------------
# Append to .bashrc
#-------------------
echo 'export SIXTE=/opt/sixte/sixte' >> ~/.bashrc
echo 'export SIMPUT=/opt/sixte/simput' >> ~/.bashrc
echo '. $SIXTE/bin/sixte-install.sh' >> ~/.bashrc
echo 'export locpfiles=$HOME/pfiles' >> ~/.bashrc
echo "export PFILES=\"$HOME/pfiles;$HEADAS/syspfiles:/opt/sixte/sixte/share/sixte/pfiles:/opt/sixte/simput/share/simput/pfiles\"" >> ~/.bashrc

#--------------------
# Append to .profile
#--------------------
echo 'export SIXTE=/opt/sixte/sixte' >> ~/.profile
echo 'export SIMPUT=/opt/sixte/simput' >> ~/.profile
echo '. $SIXTE/bin/sixte-install.sh' >> ~/.profile
#echo 'export locpfiles=$HOME/pfiles' >> ~/.profile
#echo 'export syspfiles=$HEADAS/syspfiles' >> ~/.profile
#echo 'export sixtepfiles=$SIXTE/share/sixte/pfiles' >> ~/.profile
#echo 'export simputpfiles=$SIMPUT/share/simput/pfiles' >> ~/.profile
#echo 'export PFILES=$locpfiles;$syspfiles:$sixtepfiles:$simputpfiles' >> ~/.profile

#-----------------------------------------------------
# Source the install immediately for the current shell
#-----------------------------------------------------
#export SIXTE=/opt/sixte/sixte
#export SIMPUT=/opt/sixte/simput
#. $SIXTE/bin/sixte-install.sh

#-----------------------------------------
# Handle parameter files for current shell
#-----------------------------------------
#locpfiles="$HOME/pfiles"
#syspfiles="$HEADAS/syspfiles"
#sixtepfiles="$SIXTE/share/sixte/pfiles"
#simputpfiles="$SIMPUT/share/simput/pfiles"
#PFILES="$locpfiles;$syspfiles:$sixtepfiles:$simputpfiles"
#export PFILES




