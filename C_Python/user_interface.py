import serial 
from System_Interface import * 
import numpy as np 
import time
     
def read_light(s): 
	s.send_packet(">1B", 1) 
	value =  s.read_packet(1) 
	value = value - 100
	print "light lumen is :%d" %value
	return value
 
 
 
if __name__ == "__main__": 
 
	print 'initializing interface' 
	print 
	s = SDK_System_interface(serial_port="/dev/ttyUSB0", baud_rate=9600,read_timeout = None)	#115200 
	s.port.flushInput() 
 
	for i in range(100):
		InputData=open('a.txt','a')
		Tempdata=[]
		a= read_light(s)
		Tempdata.append(str(i))
		Tempdata.append(str(a))
		Data = ",".join(Tempdata)
		InputData.writelines(str(Data))
		InputData.write('\n')
		time.sleep(1)
	InputData.close()
