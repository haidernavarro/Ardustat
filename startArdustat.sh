#!/bin/bash

cd ./Software

unamestr=`uname`							#The architecture of the machine

if [[ "$unamestr" == 'Darwin' ]]; then
	PATH=$PATH:/usr/local/bin/ #Fix Platypus-related bug with incorrect PATH
fi

#Test to see whether everything has been installed
nodejsisinstalled=`type -P node | wc -l | sed -e 's/^[ \t]*//'`
if [[ "$nodejsisinstalled" == '0' ]]; then
	echo "Node.JS is not yet installed."
	exit 1;
fi
mongodbisinstalled=`type -P mongo | wc -l | sed -e 's/^[ \t]*//'`
if [[ "$mongodbisinstalled" == '0' ]]; then
	echo "MongoDB is not yet installed."
	exit 1;
fi
avrdudeisinstalled=`type -P avrdude | wc -l | sed -e 's/^[ \t]*//'`
if [[ "$avrdudeisinstalled" == '0' ]]; then
	echo "AVRDUDE is not yet installed."
	exit 1;
fi
echo "All dependencies are installed."

#Install node.js libraries if they haven't been installed yet
if [[ ! -d "./node_modules" ]]; then
	echo "Installing node.js libraries..."
	npm install express@2.5.10 socket.io serialport@0.7.5 mongoskin 
execSync
	echo "Finished installing node.js libraries"
fi

#Start mongodb daemon if it's not running
daemonisrunning=`ps -aAc | grep mongod | wc -l | sed -e 's/^[ \t]*//'`
if [[ $daemonisrunning == "0" ]]; then
	mongod --quiet &
fi


#Detect arduino device files
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

#Start express server
if [[ $numofarduinos == "1" ]]; then
	node expressserver.js $arduinos $1 $2 $3
	exit
fi
echo You appear to have multiple arduinos connected. Please select one:
select fname in $arduinos;
do
	node expressserver.js $fname $1 $2 $3
	break;
done
