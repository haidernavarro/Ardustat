import ardustatlibrary as ard
import time
the_socket = 7777

connresult = ard.connecttosocket(the_socket)

print connresult

socketinstance = connresult["socket"]

print ard.ocv(the_socket)
for i in range(0,10):
	time.sleep(.3)
	print ard.socketread(socketinstance)

print ard.potentiostat(2,the_socket)
for i in range(0,10):
	time.sleep(.3)
	print ard.socketread(socketinstance)

print ard.potentiostat(1,the_socket)
for i in range(0,10):
	time.sleep(.3)
	print ard.socketread(socketinstance)
