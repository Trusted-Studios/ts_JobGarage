-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[CLIENT - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

---@class Game 
Game = {}

--- returns if the wanted distance between the ped and a target coord is reached or not.
---@param ped number
---@param targetCoords vector3
---@param distance number
---@return boolean
function Game.GetDistance(ped, targetCoords, distance)
    local coords = GetEntityCoords(ped)
    local dist = Vdist(coords, targetCoords)
    return dist <= distance
end

--- Creates a target for a coord. 
---@param ped number
---@param targetCoords vector3
---@param distance_1 number 
---@param distance_2 number 
---@param marker boolean
---@param normal_function function
---@param else_function function
function Game.Target(ped, targetCoords, distance_1, distance_2, marker, normal_function, else_function)
    if Game.GetDistance(ped, targetCoords, distance_1) then
        if marker and type(marker) == "boolean" then 
            local x, y, z = table.unpack(targetCoords)
            Game.AddMarker(x, y, z)
        elseif marker and type(marker) == "function" then 
            marker()
        end
        if Game.GetDistance(ped, targetCoords, distance_2) then
            if normal_function then
                normal_function()
            end
        else 
            if else_function then 
                else_function()
            end
        end
    end
end

--- Adds a Blip and returns it.
---@param coords vector3
---@param type number
---@param scale number 
---@param colour number 
---@param enableWaypoint boolean
---@param BlipLabel string
---@param shortRange boolean
---@return number
function Game.AddBlip(coords, type, scale, colour, enableWaypoint, BlipLabel, shortRange)
    local x, y, z = table.unpack(coords)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, type)
    SetBlipScale(blip, scale)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, shortRange)
    SetBlipRoute(blip, enableWaypoint)
    SetBlipRouteColour(blip, colour)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(BlipLabel)
    EndTextCommandSetBlipName(blip)
    return blip
end