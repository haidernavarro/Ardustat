var os = require("os")

if (os.platform() == "darwin" || os.platform() == "linux") {
	//Operating system is linux or OS X
	var serialport = require("serialport")
	var SerialPort = require("serialport").SerialPort
	var serialPort = new SerialPort(process.argv[2],{baudrate:57600,parser:serialport.parsers.raw});
}
else if (os.platform().substring(0,3) == "win") {
	//Operating system is Windows
	var SerialPort = require("serialport2").SerialPort
	var serialPort = new SerialPort();
	serialPort.open(process.argv[2], {
		baudRate: 57600,
		dataBits: 8,
		parity: 'none',
		stopBits: 1,
		flowControl: false
	});
}

serialPort.on("data", dataParser);
var line = ""
function dataParser(rawdata) {
	data = rawdata.toString();
	if (data.search("\n") > -1)
	{
		line = line + data.substring(0,data.indexOf('\n'));
		gotData(line);
		line = data.substring(data.indexOf('\n')+1,data.length);
	}
	else
	{
		line = line + data;
	}		
}

function gotData(data) {
	if(data.search("GO")>-1) {
		if(data.search("ST")>-1) {
			console.log("firmware")
			serialPort.close()
			process.exit()
		}
	}
}			

dataWriter = setInterval(function() {serialPort.write("s0000")},100)

timeOut = setInterval(function() {
	console.log("nofirmware")
	serialPort.close()
	process.exit()
}, 3000)
