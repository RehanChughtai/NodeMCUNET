wifi.sta.autoconnect(1)
--autoconnect
wifi.sta.sethostname("uopNodeMCU")
wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="VM3980916" 
station_cfg.pwd="xcmz5qgVbjsh"
station_cfg.save=true
wifi.sta.config(station_cfg)
--wifi.sta.connect()
--wifi.sta.disconnect()
--manual connect and disconnect

mytimer = tmr.create()
mytimer:register(3000, 1, function() 
   if wifi.sta.getip()==nil then
        print("Connecting to AP...\n")
   else
        ip, nm, gw=wifi.sta.getip()
        mac = wifi.sta.getmac()
        rssi = wifi.sta.getrssi()
        print("IP Info: \nIP Address: ",ip)
        print("Netmask: ",nm)
        print("Gateway Addr: ",gw)
        print("MAC: ",mac)  
        print("RSSI: ",rssi,"\n")
   end 
end)
mytimer:start()

dhtPin = 3
dhtPin2 = 2
--GPIO pin to the DHT sensor output pin 
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(conn,request)           
        local status, temp, humi , temp_dec, humi_dec = dht.read11(dhtPin)
        local status, temp, humi , temp_dec, humi_dec = dht.read11(dhtPin2)
        local buf = ""
        if status == dht.OK then
            print(temp1..","..temp2..","..humi1..","..humi2.."\n")
        end
        buf=buf.."<html>"      
        buf=buf.."<head> <title>DHT11 LAN update</title> <meta http-equiv=\"refresh\" content=\"10\"> </head>"  
        buf=buf.."<body><p>Temperature: "..temp.."."..temp_dec.."C</p>"  
        buf=buf.."<body><p>Temperature2: "..temp2.."."..temp_dec.."C</p>" 
        buf=buf.."<p>Humidity: "..humi.."."..humi_dec.."%RH</p>" 
        buf=buf.."<p>Humidity2: "..humi2.."."..humi_dec.."%RH</p>" 
        conn:send(buf)
        conn:on("sent",function(conn) conn:close() end)         
    end)
end)
--Now connect your mobile device to the AP uopiot2020
--And use a browser view the temprature/humidity in the IP Address shown here
