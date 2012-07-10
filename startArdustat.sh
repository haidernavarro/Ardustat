#!/bin/bash

cd ./Software

firstrun=`sed -n '1p' ./config.rc`	#The first line of the file named 'config.rc'
unamestr=`uname`							#The architecture of the machine

if [[ "$unamestr" == 'Darwin' ]]; then
	PATH=$PATH:/usr/local/bin/ #Fix Platypus-related bug with not recognizing node files
fi

if [[ "$firstrun" == 'firstrun' ]]; then
	echo "First run."
	if [[ "$unamestr" == 'Darwin' ]]; then
		echo "Mac OS X detected. Attempting to install dependencies..."
		homebrewisinstalled=`type -P brew | wc -l | sed -e 's/^[ \t]*//'`
		if [[ "$homebrewisinstalled" == '0' ]]; then
			echo "Homebrew is not yet installed. Installing homebrew..."
			/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)" #installs homebrew
		fi
		nodejsisinstalled=`type -P node | wc -l | sed -e 's/^[ \t]*//'`
		if [[ "$nodejsisinstalled" == '0' ]]; then
			echo "Node.JS is not yet installed. Installing Node.JS..."
			brew install node
		fi
		mongodbisinstalled=`type -P mongo | wc -l | sed -e 's/^[ \t]*//'`
		if [[ "$mongodbisinstalled" == '0' ]]; then
			echo "MongoDB is not yet installed. Installing MongoDB..."
			brew install mongodb
		fi
		avrdudeisinstalled=`type -P avrdude | wc -l | sed -e 's/^[ \t]*//'`
		if [[ "$avrdudeisinstalled" == '0' ]]; then
			echo "AVRDUDE is not yet installed. Installing AVRDUDE..."
			brew install avrdude
		fi
		echo "All dependencies are installed."
	fi
	
	echo "Installing node.js libraries..."
	bash ./initializeNodeJS.sh
	rm ./config.rc
	touch ./config.rc
	echo notfirstrun > ./config.rc
	echo "Finished installing node.js libraries"
fi

#Start mongodb daemon if it's not running
daemonisrunning=`ps -aAc | grep mongod | wc -l | sed -e 's/^[ \t]*//'`
if [[ $daemonisrunning == "0" ]]; then
	mongod --quiet &
fi

if [[ "$unamestr" == 'Linux' ]]; then
	arduinos=`ls -d /dev/* | grep tty[UA][SC][BM]` 				#anything of the form /dev/ttyACM* or /dev/ttyUSB*
	numofarduinos=`ls -d /dev/* | grep tty[UA][SC][BM] | wc -l` #number of results returned
fi
if [[ "$unamestr" == 'Darwin' ]]; then
	arduinos=`ls -d /dev/* | grep tty.usbmodem*`
	numofarduinos=`ls -d /dev/* | grep tty.usbmodem* | wc -l | sed -e 's/^[ \t]*//'`  #Number of results returned
fi
if [[ $arduinos == "" ]]; then
	echo No arduinos found
	exit
fi
if [[ $numofarduinos == "1" ]]; then
	needsfirmware=`node detectIfFirmwareLoaded.js $arduinos`
	if [[ $needsfirmware == "nofirmware" ]]; then
		echo "Arduino does not appear to be loaded with firmware. Loading firmware with AVRDUDE..."
		cd ../Firmware/avrdude
		bash uploadFirmware.sh $arduinos
		cd ../../Software
	fi
	node expressserver.js $arduinos $1 $2 $3
	exit
fi
echo You appear to have multiple arduinos connected. Please select one:
select fname in $arduinos;
do
	needsfirmware=`node detectIfFirmwareLoaded.js $fname`
	if [[ $needsfirmware == "nofirmware" ]]; then
		echo "Arduino does not appear to be loaded with firmware. Loading firmware with AVRDUDE..."
		cd ../Firmware/avrdude
		bash uploadFirmware.sh $fname
		cd ../../Software
	fi
	node expressserver.js $fname $1 $2 $3
	break;
done
