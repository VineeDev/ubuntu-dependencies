#!/bin/bash
# This script will install all the basic dependencies in Ubuntu System
set -e

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	set -e
	if [[ $(whoami) == "root" ]]; then
		MAKE_ME_ROOT=
	else
		MAKE_ME_ROOT=sudo
        
	fi
	$MAKE_ME_ROOT apt-get install curl

	if [ -f /etc/debian_version ]; then
		echo "Ubuntu/Debian Linux detected."
		$MAKE_ME_ROOT apt update
		$MAKE_ME_ROOT apt install -y cmake pkg-config libssl-dev git gcc build-essential git clang libclang-dev
		echo "Installing VS code in ubuntu"
		$MAKE_ME_ROOT snap install --classic code
		echo "Installing docker in ubuntu"
		$MAKE_ME_ROOT apt install docker.io
		# run docker without sudo
		chown $USER:docker /var/run/docker.sock
		usermod -aG docker $USER
		systemctl start docker
		systemctl enable docker
		echo "Installing NVM (Node Version Manager) in Ubuntu"
		curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash 
		export NVM_DIR="$HOME/.nvm"
		[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  #This loads nvm
		nvm install v16.15.0
		nvm use v16.15.0
		echo "Installing Chrome"
		wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
		$MAKE_ME_ROOT apt install ./google-chrome-stable_current_amd64.deb
		echo "install git"
		$MAKE_ME_ROOT apt install git
	else
		echo "Unknown Linux distribution."
		echo "This OS is not supported with this script at present. Sorry."
		exit 1
	fi
fi
