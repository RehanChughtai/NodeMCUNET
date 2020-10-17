wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="Wifi name" 
station_cfg.pwd="password"
station_cfg.save=false
wifi.sta.config(station_cfg)
mytimer=tmr.create()
mytimer:register(3000, 1, function() 
   if wifi.sta.getip()==nil then
        print("Connecting to AP...\n")
   else
        ip, nm, gw=wifi.sta.getip()
        print("IP Info: \nIP Address: ",ip)
        print("Netmask: ",nm)
        print("Gateway Addr: ",gw,"\n")
   end 
end)
mytimer:start()
