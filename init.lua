
Resetta=1

-- Check if reset the AP credential
if Resetta==1 then 
 
 
    tmr.alarm(0, 5000, 0, function() dofile("connect.lua") end)
 
else
    -- Start the webserver wiht ip defined by Wi-Fi router
    tmr.alarm(0, 5000, 0, function() dofile("netReadDHTLAN.lua") end)
 
end