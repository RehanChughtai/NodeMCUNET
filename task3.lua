wifi.setmode(wifi.STATION)
station_cfg={}
station_cfg.ssid="VM3980916" 
station_cfg.pwd="xcmz5qgVbjsh"
station_cfg.save=false
wifi.sta.config(station_cfg)

LEDpin = 2                
gpio.mode(LEDpin, gpio.OUTPUT)
server = net.createServer(net.TCP, 120)

function receiver(sck, data)
  if string.find(data, "ON")  then
   sck:send("\r\nON")       
   gpio.write(LEDpin, gpio.HIGH)
  elseif string.find(data, "OFF")  then
   sck:send("\r\nOFF")
   gpio.write(LEDpin, gpio.LOW)
  elseif string.find(data, "EXIT")  then
   sck:close()
  else
   sck:send("\r\nCommand Not Found...!!!")
  end
end

if server then
  server:listen(80, function(conn)
  conn:on("receive", receiver)
  conn:send("Hello Client\r\n")
  conn:send("1. Send 'ON' command to turn on LED\r\n")
  conn:send("2. Send 'OFF' command to turn off LED\r\n")
  conn:send("3. Send 'EXIT' command to Exit\r\n")
  end)
end
