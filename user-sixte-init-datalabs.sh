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