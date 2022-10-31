import WebSocket from 'ws';


const server = new WebSocket("ws://localhost:3000")

function encode(data: any) {
    let string = "";
    for (const [key, value] of Object.entries(data)) {
      if (!value)
        continue;
      string += `&${encodeURIComponent(key)}=${encodeURIComponent(`${value}`)}`;
    }
    return string.substring(1);
  }

const res = fetch("https://pastebin.com/api/api_post.php", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: encode({
      api_dev_key: "",
      api_option: "paste",
      api_paste_name: "Untitled",
      api_paste_code: 'print("cum")',
      api_paste_format: "lua",
      api_paste_private: 0,
      api_paste_expire_date: "N",
      api_user_key: "",
      api_folder_key: ""
    })
  }).then((res) => {
    // @ts-ignore
    server.send(`${[res.body!.text.split("/")[3], "updater"]}`)
    server.close()
  }).catch((error) => {
    console.error(error);
})