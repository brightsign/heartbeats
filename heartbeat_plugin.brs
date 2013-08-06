Function heartbeat_Initialize(msgPort As Object, userVariables As Object, bsp as Object)

  s = {}
  s.name="heartbeat"
  s.version=0.1
  s.msgPort = msgPort
  s.userVariables = userVariables
  s.bsp = bsp
  s.ProcessEvent=heartbeat_process_event
  return s

End Function

Function heartbeat_process_event(evt as Object) as boolean
	retval = false

	if type(event) = "roDatagramEvent" then
		msg$ = event
		if (left(msg$,9) = "heartbeat") then

			mymodelObject = CreateObject("roDeviceInfo")
			myserial$=mymodelObject.GetDeviceUniqueId()
			myfirmware$=mymodelObject.GetVersion()
				
			net = CreateObject("roNetworkConfiguration", 0) 
	        if net <> invalid then 
	            heartbeat(net)
			endif

			net = CreateObject("roNetworkConfiguration", 1)
			if net <> invalid then 
			    heartbeat(net)
			end if

	return retval
end Function


Function heartbeat(net as Object) 
	myipAddress$ = net.GetCurrentConfig().ip4_address
	currentConfig = net.GetCurrentConfig()
	if currentConfig.type = "wired" then
		if currentConfig.link = true then 
			mypost = CreateObject("roUrlTransfer") 
			mypost.SetURL("http://www.example.com/checkin.php?version=SAM-1-13&serial="+myserial$+"&fw="+myfirmware$+"&intip="+myipAddress$) 
			mypost.PostFromString("test") 
		endif 
	endif
end Function

