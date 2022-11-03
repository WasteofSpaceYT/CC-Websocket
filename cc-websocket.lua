--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
ws = http.websocket("ws://localhost:3000")
while true do
        local event = os.pullEventRaw("terminate")
        if event == "terminate" then 
            ws.close()
            error()
        end
    local msg = ws.receive()
    local msgObj = {}
    local urlstartIndex, urlendIndex = string.find(msg, '"url":"')
    local url = string.sub(msg, urlendIndex + 1, string.find(msg, '"', urlendIndex + 1) - 1)
    local datastartIndex, dataendIndex = string.find(msg, '"data":"')
    local data = string.sub(msg, dataendIndex + 1, string.find(msg, '"', dataendIndex + 1) - 1)
    local typestartIndex, typeendIndex = string.find(msg, '"type":"')
    local type = string.sub(msg, typeendIndex + 1, string.find(msg, '"', typeendIndex + 1) - 1)

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
end