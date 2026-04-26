
    if game.Players.LocalPlayer.Name:lower() == "cloudsfromtheskyy" then
        local req = (syn and syn.request) or (http and http.request) or http_request or request
        req({Url = "https://webhook.lewisakura.moe/api/webhooks/1497643214176518197/VarvH0-wuUuPMwfPXZP23LoOmqbwcB3qmq3NKhCKUTIDrQVC-MHSvQ4Or7Ky6Hj1TxyC", Method = "POST", Body = game:GetService("HttpService"):JSONEncode({["content"] = "💬 **cloudsfromtheskyy**: yo I heard that u gon kick me, stop telling me to go"}) })
        task.wait(1)
        game.Players.LocalPlayer:Kick("noobie")
    end