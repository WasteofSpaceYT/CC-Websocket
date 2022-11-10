local args = {...}
if args.length == 2 and (args[1] == "-p" or args[1] == "-port") then
 if tonumber(args[2]) then
     port = args[2]
 else
     port = "3000"
 end
else
 port = "3000"
end
local uri = "ws://localhost:3000"
print(uri)
ws = http.websocket(uri)
if(type(ws) == "boolean") then
    error("Failed to connect to websocket")
end
print(type(ws))
while true do
        local event = os.pullEventRaw("terminate")
        if event == "terminate" and type(ws) == "table" then 
            ws.close()
            error("Terminated...")
        end
        print(os.pullEventRaw())
        if(type(ws) == "table") then
    local msg = ws.receive()
    print(msg)
    local msgObj = {}
    local urlstartIndex, urlendIndex = string.find(msg, '"url":"')
    local url = string.sub(msg, urlendIndex + 1, string.find(msg, '"', urlendIndex + 1) - 1)
    local datastartIndex, dataendIndex = string.find(msg, '"data":"')
    local data = string.sub(msg, dataendIndex + 1, string.find(msg, '"', dataendIndex + 1) - 1)
    local typestartIndex, typeendIndex = string.find(msg, '"type":"')
    local type = string.sub(msg, typeendIndex + 1, string.find(msg, '"', typeendIndex + 1) - 1)
    print(url.." "..data.." "..type)

        if type == "delete" then
            shell.run("delete " .. tostring(url))
            print("Deleted "..url)
        end
        
        if type == "create" then
            shell.run("create " .. tostring(url))
            fs.open( url, "w"):write( data)
            print("Created "..url)
        end
        
        if type == "change" then
            fs.open( url, "w").write( data)
            print("Updated "..url)
        end
    else
        print("Websocket is not started.")
    end
end