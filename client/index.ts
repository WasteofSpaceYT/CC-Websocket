let ws = http.websocket("http://localhost:3000")

while (true) {
    if (ws) {
        let msg = ws.receive()
        if (msg![1]) {
            let obj = JSON.parse(msg![0])
            for(const file in obj){
                let name = obj[file].name
                let paste = obj[file].paste
                if(fs.exists(`${name}.lua`)){
                    shell.run(`remove ${name}.lua`)
                }
                shell.run("pastebin get " + paste + " " + name)
            }
        }
    }
}