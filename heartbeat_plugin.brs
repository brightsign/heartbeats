Function heartbeat_Initialize(msgPort As Object, userVariables As Object, bsp as Object)

    h = {}
    h.name="heartbeat"
    h.version=0.1
    h.msgPort = msgPort
    h.userVariables = userVariables
    h.bsp = bsp
    h.ProcessEvent=heartbeat_process_event

    player = CreateObject("roDeviceInfo")
    h.snum=player.GetDeviceUniqueId()
    h.version=player.GetVersion()
    h.ip=""

    net = CreateObject("roNetworkConfiguration", 0) 
    if net = invalid then 
        net = CreateObject("roNetworkConfiguration", 1) 
	endif

    if net <> invalid then 
        h.ip = net.GetCurrentConfig().ip4_address
	endif

  return h
End Function



Function heartbeat_process_event(event as Object) as boolean
	retval = false

    if m.ip=""
          print "no local IP address - heartbeat disabled"
          return false
    end if

	if type(event) = "roAssociativeArray" then
        if type(event["EventType"]) = "roString"
             if (event["EventType"] = "SEND_PLUGIN_MESSAGE") then
                if event["PluginName"] = "heartbeat" then
                    print "event heartbeat"
                    pluginMessage$ = event["PluginMessage"]
                    retval = heartbeat(pluginMessage$, m)
                endif
            endif
        endif
	endif

	if type(event) = "roDatagramEvent" then
	    msg$ = event
	    retval = heartbeat(msg, m)
	end if
	return retval
end Function



Function heartbeat(msg as string, h as Object) as Object

	print "heartbeat: ";msg;"h: ";h
	retval=false
	tag=""

	if h.userVariables["heartbeat_url"]<>invalid
	    heartbeat_url=h.userVariables["heartbeat_url"].currentValue$
	else
	    heartbeat_url=""
    end if

	if h.userVariables["heartbeat_tag"]<>invalid
	    tag=h.userVariables["heartbeat_tag"].currentValue$
    end if

    if heartbeat_url<>""
		xfer = CreateObject("roUrlTransfer") 
		urlstring=heartbeat_url+"?serial="+h.snum+"&fw="+h.version+"&intip="+h.ip+"&event="+event+"&tag="+tag
		print urlstring
		xfer.SetURL(urlstring)
		xfer.GetFromString() 
	else
	    print "cannot do heartbeat since no heartbeat_url user variable is defined"
	endif

	return retval
end Function
