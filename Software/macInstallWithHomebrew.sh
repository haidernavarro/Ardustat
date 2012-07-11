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
	sudo mkdir /data/
	sudo mkdir /data/db
	sudo chmod 777 /data/db
fi
avrdudeisinstalled=`type -P avrdude | wc -l | sed -e 's/^[ \t]*//'`
if [[ "$avrdudeisinstalled" == '0' ]]; then
	echo "AVRDUDE is not yet installed. Installing AVRDUDE..."
	brew install avrdude
fi
echo "All dependencies are installed."
