del .\node_modules\
npm install express@2.5.10 socket.io serialport2 mongoskin
REM Set Windows PATH to include MongoDB utilities (needed for mongoexport)
path=%PATH%;C:\mongodb\bin
setx path "%PATH%"