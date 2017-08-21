#!/bin/bash

# Arch Auto update script. Runs pacaur update without input needed from admin/user and puts everything in a logfile. 
# Will notify user if update has gone wrong.

################
# Requirements #
################

# Pacman has to be able to run without a sudo password, which can be set up by modifying sudoers file
	# EDITOR=nano visudo
	# fileserver ALL=(ALL) NOPASSWD: /usr/bin/pacman

#############
# Variables #
#############

PUSHBULLET_SCRIPT="/home/fileserver/Applications/pushbullet.sh"
UPDATE_LOG="/home/fileserver/Applications/autoupdate/autoupdate.log"

#####################
# Autoupdate Script #
#####################

printf "Starting ArchServer Auto Update. Time & Date right now is $(date)\n" >> $UPDATE_LOG 2>&1
su fileserver -c "pacaur -Syuq --noedit --noconfirm" >> $UPDATE_LOG 2>&1

# Getting return code from pacaur. If this return code is not 0 (so an error has occured with the pacaur update), notify system administrator
errorval="$?"
if [ $errorval -ne 0 ]; then
  $PUSHBULLET_SCRIPT "ERROR - ArchServer Auto update failed" "During auto update, the pacaur installer failed installing updates (error code different than 0)." >/dev/null 2>&1
	exit 1
else
  printf "ArchServer Auto update has finished without errors\n\n" >> $UPDATE_LOG 2>&1
  exit 0
fi