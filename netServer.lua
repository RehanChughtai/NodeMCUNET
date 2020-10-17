srv = net.createServer(net.TCP,30)
--TCP, 30s for an inactive client to be disconnected
--try srv = net.createServer(net.UDP,10)
pinLED=4
srv:listen(2020, function(conn)
    conn:send("Send to all clients who connect to Port 80, hello world! \n") 
    conn:on("receive", function(conn, s)
        print(s)
        conn:send(s)
    end)
    conn:on("connection",function(conn, s)
    conn:send("Now in connection, hello Dalin from Server\n") 
    end)
    conn:on("disconnection", function(conn, s) 
    print("Now we are disconnected\n") 
    end)
    conn:on("sent",function(conn, s)
    print("Message has been sent out from the Server\n")
    end)
    conn:on("receive", function(conn, s)
    print("What we receive from the Client\n" .. s .. "\n")
    conn:send("Now you can play with the data sent by client like\n"..s) 
    conn:send(gpio.write(pinLED1, gpio.LOW)
--    "Now you can play with the data sent by client like\n"
--    lighton=0
--    pinLED1=4
--    gpio.mode(pinLED1, gpio.OUTPUT)
--    mytimer = tmr.create()
--    mytimer:register(2000, 1, function() 
--    print("Blink LED1")
--    if lighton==0 then 
--        lighton=1
--        gpio.write(pinLED1, gpio.LOW)
--    else 
--        lighton=0 
--        gpio.write(pinLED1, gpio.HIGH)
--    end 
--    end)
    
    end) 
end
)
--srv:close()


mytimer:start()
