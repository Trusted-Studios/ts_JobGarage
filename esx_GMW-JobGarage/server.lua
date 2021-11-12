---@diagnostic disable: undefined-global, trailing-space

ESX = nil 

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
local file = filename()
ESX.RegisterServerCallback('GMW_Scripts:FileStartetd', function(source, cb)
    cb(file)
end)
