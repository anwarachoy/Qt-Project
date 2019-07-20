#!/usr/bin/env python
# -*- coding: utf-8 -*-
import sys

from PyQt5.QtCore import QUrl, QObject, pyqtSignal, pyqtSlot, QTimer, pyqtProperty
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQuick import QQuickView
from PyQt5.QtQml import QQmlApplicationEngine

import time
import paho.mqtt.client as paho
broker="localhost"
port = 1883

pubdelay = 2 #delay publish to all wind and engine box
counter = 0

directProp1 = 0
directProp2 = 0

speedEngine1 = 0
speedEngine2 = 0

speedPropeler1 = 0
speedPropeler2 = 0

lfuel1 = 0
lfuel2 = 0

ltemp1 = 0
ltemp2 = 0

depth1 = 0
depth2 = 0

joystickUp1	= 1
joystickUp2	= 1
joystickRight1 = 1
joystickRight2 = 1

indicator1 = False
indicator2 = False
indicator5 = False

ind1 = 0
ind2 = 0
windInd = 0


directWind = 0
speedWind = 0

class MQTTValue(QObject):      
	
	def __init__(self):
		super(MQTTValue,self).__init__()
		
	# if a slot returns a value the return value type must be explicitly
	# defined in the decorator
	
	####################################################
	@pyqtSlot(result=int)
	def azimut1(self):  return directProp1
	
	@pyqtSlot(result=int)
	def enginespeed1(self):  return speedEngine1
	
	@pyqtSlot(result=int)
	def propelerspeed1(self):  return speedPropeler1
	
	@pyqtSlot(result=int)
	def fuel1(self):  return lfuel1
	
	@pyqtSlot(result=int)
	def temp1(self):  return ltemp1
	
	@pyqtSlot(result=int)
	def vdepth1(self):  return depth1
	
	@pyqtSlot(result=int)
	def joyUD1(self):
                        if (joystickUp1 == 1900): return 2;
                        elif (joystickUp1 == 1300): return 0;
                        else : return 1;
		
	@pyqtSlot(result=int)
	def joyRL1(self):
                        if (joystickRight1 == 1900): return 2;
                        elif (joystickRight1 == 1300): return 0;
                        else : return 1;
		
	@pyqtSlot(result=bool)
	def engineconect1(self): return indicator1

	
	####################################################
	@pyqtSlot(result=int)
	def azimut2(self):  return directProp2
	
	@pyqtSlot(result=int)
	def enginespeed2(self):  return speedEngine2
	
	@pyqtSlot(result=int)
	def propelerspeed2(self):  return speedPropeler2
	
	@pyqtSlot(result=int)
	def fuel2(self):  return lfuel2
	
	@pyqtSlot(result=int)
	def temp2(self):  return ltemp2
	
	@pyqtSlot(result=int)
	def vdepth2(self):  return depth2
	
	@pyqtSlot(result=int)
	def joyUD2(self):
                        if (joystickUp2 == 1900):  return 2;
                        elif (joystickUp2 == 1300): return 0;
                        else : return 1;
	
	@pyqtSlot(result=int)
	def joyRL2(self):
                        if (joystickRight2 == 1900): return 2;
                        elif (joystickRight2 == 1300): return 0;
                        else : return 1;
		
	@pyqtSlot(result=bool)
	def engineconect2(self): return indicator2

	
	####################################################
	@pyqtSlot(result=int)
	def directWind(self):  return directWind

	@pyqtSlot(result=int)
	def speedWind(self):  return speedWind
	
	@pyqtSlot(result=bool)
	def windconect(self): return indicator5	
	
	@pyqtSlot(result=str)
	def maincontrol(self):
		global counter,pubdelay,indicator1,indicator2,indicator5 
		global ind1,ind2,windInd
		counter=counter+1
		if (counter >= pubdelay):
			client.publish("MainControl", "active")#publish
			if (ind1): ind1 = 0 
			else: indicator1 = False
			if (ind2): ind2 = 0 
			else: indicator2 = False
			if (windInd): windInd = 0 
			else: indicator5 = False
			counter = 0;
		return ""
	
def on_message(client, userdata, message):
		msg = str(message.payload.decode("utf-8"))
		t = str(message.topic)

		if(msg[0] == 'c'):
			val =  True
		else:
			val = int(msg)

		if (t[0] == "1"):
			#print("Engine 1")
			if (t[1] == "A"): global directProp1; directProp1 = val; print("Azimuth Propeller 1 = ",directProp1)
			elif (t[1] == "E"): global speedEngine1; speedEngine1 = val; print("Speed Engine 1 = ",speedEngine1)
			elif (t[1] == "P"): global speedPropeler1; speedPropeler1 = val; print("Speed Propeller 1 = ",speedPropeler1)
			elif (t[1] == "F"): global lfuel1; lfuel1 = val; print("Fuel 1 = ",lfuel1)
			elif (t[1] == "T"): global ltemp1; ltemp1 = val; print("Temp 1 = ",ltemp1)
			elif (t[1] == "D"): global depth1; depth1 = val; print("Depth Engine 1 = ",depth1)
			elif (t[1] == "p"): global joystickUp1; joystickUp1 = val; print("Speed Control = ",joystickUp1)
			elif (t[1] == "B"): global ind1; ind1 = val; global indicator1; indicator1 = val; print("Box Engine 1 Connected")
		elif (t[0] == "2"):
			#print("Engine 2")
			if (t[1] == "A"): global directProp2; directProp2 = val
			elif (t[1] == "E"): global speedEngine2; speedEngine2 = val
			elif (t[1] == "P"): global speedPropeler2; speedPropeler2 = val 
			elif (t[1] == "F"): global lfuel2; lfuel2 = val
			elif (t[1] == "T"): global ltemp2; ltemp2 = val
			elif (t[1] == "D"): global depth2; depth2 = val
			elif (t[1] == "p"): global joystickUp2; joystickUp2 = val; print("Speed Contro2 = ",joystickUp2)
			elif (t[1] == "B"): global ind2; ind2 = val; global indicator2; indicator2 = val;
		elif (t[0] == "W"):
			#print("Wind Condition")
			if (t[4] == "D"): global directWind; directWind = val; print("WindDirection = ",directWind)
			elif (t[4] == "S"): global speedWind; speedWind = val; print("WindSpeed = ",speedWind)
			else: global windInd ; windInd = val; global indicator5; indicator5 = val;
			

if __name__ == "__main__":

	##Mosquitto Mqtt Configuration			
	client= paho.Client("GUI")
	client.on_message=on_message

	print("connecting to broker ",broker)
	client.connect(broker,port)#connect
	print(broker," connected")
	
	client.loop_start()
	print("Subscribing")
	client.subscribe("1Azimuth")#subscribe
	client.subscribe("1EngineSpeed")#subscribe
	client.subscribe("1PropellerSpeed")#subscribe
	client.subscribe("1Temperature")#subscribe
	client.subscribe("1Fuel")#subscribe
	client.subscribe("1Depth")#subscribe
	client.subscribe("1Box")#subscribe
	client.subscribe("1pulse_spc")#subscribe
	print("Box Engine 1 subscribed ")
	
	client.subscribe("2Azimuth")#subscribe
	client.subscribe("2EngineSpeed")#subscribe
	client.subscribe("2PropellerSpeed")#subscribe
	client.subscribe("2Temperature")#subscribe
	client.subscribe("2Fuel")#subscribe
	client.subscribe("2Depth")#subscribe
	client.subscribe("2Box")#subscribe
	client.subscribe("2pulse_spc")#subscribe
	print("Box Engine 2 subscribed ")
	
	client.subscribe("WindDirection")#subscribe
	client.subscribe("WindSpeed")#subscribe
	client.subscribe("WindBox")#subscribe
	print("Box Wind subscribed ")
	
	client.publish("MainControl", "active")#publish

	## QT5 GUI
	print("Graphical User Interface ")
	app = QGuiApplication(sys.argv)

	view = QQuickView()
	view.setSource(QUrl('dashboard.qml'))

	mqttvalue = MQTTValue()

	timer = QTimer()
	timer.start(10) ##Update screen every 10 miliseconds

	context = view.rootContext()
	context.setContextProperty("mqttvalue", mqttvalue)

	root = view.rootObject()
	timer.timeout.connect(root.updateValue) ##Call function update in GUI QML

	engine = QQmlApplicationEngine(app) 
	engine.quit.connect(app.quit) ## Quit Button Respon
		
	view.showFullScreen()

	sys.exit(app.exec_())

