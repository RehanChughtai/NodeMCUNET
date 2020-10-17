wifi.sta.disconnect()
wifi.setmode(wifi.STATIONAP)  -- enter AP mode for wifi setting!
--ESP SSID generated wiht its chipid
wifi.ap.config({ssid="ESP8266_"..node.chipid()
, auth=wifi.OPEN})
enduser_setup.manual(true)
enduser_setup.start(
  function()
    print("Connected to wifi as:" .. wifi.sta.getip())
    enduser_setup.stop();
    dofile("netReadDHTLAN.lua");
  end,
  function(err, str)
    print("enduser_setup: Err #" .. err .. ": " .. str)
  end
);