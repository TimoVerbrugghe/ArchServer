## First things to do after installation
# This guide will reference other files in the ArchServer Installation folder

# Enable SSH & Haveged
	systemctl enable sshd
	systemctl enable haveged

## General Recommendations
# https://wiki.archlinux.org/index.php/General_recommendations
# Users & Groups
	useradd -m -G wheel -s /bin/bash fileserver
	EDITOR=nano visudo
		fileserver ALL=(ALL) ALL

##############################################
## Go to the 'Security' file & follow steps ##
##############################################

## Package Management

## Mirrors
	# Install reflector
	# https://wiki.archlinux.org/index.php/Reflector

	# Create pacman hook

[Trigger]
Operation = Upgrade
Type = Package
Target = pacman-mirrorlist

[Action]
Description = Updating pacman-mirrorlist with reflector and removing pacnew...
When = PostTransaction
Depends = reflector
Exec = /usr/bin/env sh -c "reflector --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist; if [[ -f /etc/pacman.d/mirrorlist.pacnew ]]; then rm /etc/pacman.d/mirrorlist.pacnew; fi"


	# Create systemd service & weekly systemd timer
		# Move reflector.service & reflector.timer to /etc/systemd/system/

## AUR
	# Change makepkg for performance & general cleanup. For this, we are going to create an additional makepkg.conf file

	mkdir .build/packages
	sudo nano /home/fileserver/.makepkg.conf

	PACKAGER="Timo Verbrugghe <timo@hotmail.be>"
	MAKEFLAGS="-j$(nproc)"
	BUILDDIR=/tmp/makepkg
	PKGDEST=~/.build/packages/ 
	BUILDENV=(!distcc color ccache check !sign)
	COMPRESSXZ=(xz -c -z - --threads=0)

	# Install yay
		git clone https://aur.archlinux.org/yay.git
		cd yay
		makepkg -si

## Networking
	# Synchronize time
	timedatectl set-timezone Europe/Brussels

## System Service
	# File Index & Search

## Console Improvements
	# Bash Additions - Bash Tips & Tricks
		# Command not found (first install pkgfile!)
		pacman -Syu pkgfile
		pkgfile --update
		
		# Search for commands in non-installed packages if command not found
		source /usr/share/doc/pkgfile/command-not-found.bash

	# Console prompt - Console Bach prompt
		# Add neofetch prompt
		# Install neofetch & move config file from config folder to /home/fileserver/Applications/neofetch/config
		yay -Syu neofetch
		nano ~/.bashrc
			if [ -f /usr/bin/neofetch ]; then neofetch --config /home/fileserver/Applications/neofetch/config; fi

## Autologin
systemctl edit getty@tty1

	[Service]
	ExecStart=
	ExecStart=-/usr/bin/agetty --autologin fileserver --noclear %I $TERM