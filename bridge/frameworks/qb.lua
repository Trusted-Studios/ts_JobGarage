if not Config.Framework == 'QBCore' then 
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
-- QB Shared
-- ════════════════════════════════════════════════════════════════════════════════════ --

QBCore = {}

QBCore.Shared = exports["es_extended"]:getSharedObject()

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

---@important: THIS IS EXPERIMENTAL CODE AND HAS NOT BEEN TESTED!!

function QBCore:HasJob(job)
    local PlayerData = self.Shared?.Functions?.GetPlayerData()
    return job and PlayerData?.job?.name == job or true  
end

function QBCore:HasGrade(grade)
    local PlayerData = self.Shared?.Functions?.GetPlayerData()
    return PlayerData?.job?.grade?.level >= grade 
end