import * as ws from 'ws';

const server = new ws.Server({
  port: 3000,
});

server.on('connection', (socket) => {
  console.log('New connection');
  console.log('Total connections', server.clients.size);
socket.on("message", (message) => {
  // @ts-ignore
  let msgArray = message.toString().replace("[", "").replace("]", "").replaceAll('"', "").split(",")
  console.log(msgArray)
  server.clients.forEach((client) => {
    client.send(`pastebin get ${msgArray[0]} ${msgArray[1]}`);
  })
})
});
