if not Config.Framework == 'ESX' then 
    return 
end

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- ESX Shared
-- ════════════════════════════════════════════════════════════════════════════════════ --

ESX = {}

ESX.Shared = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    ESX.Shared.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob', function(job)
    ESX.Shared.PlayerData.job = job
end)

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

function ESX:HasJob(job)
    return not job and true or self.Shared?.PlayerData?.job?.name == job
end

function ESX:HasGrade(grade)
    return self.Shared?.PlayerData?.job?.grade >= grade
end