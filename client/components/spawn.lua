-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --
local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("[CLIENT - DEBUG] : " .. filename() .. ".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Code
-- ════════════════════════════════════════════════════════════════════════════════════ --

Spawn = {}

--- spawns a new vehicle based on the given data.
---@param vehicle string
---@param data string | nil | table 
---@param coords vector4
function Spawn:Vehicle(vehicle, data, coords)
    local ped <const> = PlayerPedId()
    local model = GetHashKey(vehicle)
    local x, y, z, h = table.unpack(coords or vec4(GetEntityCoords(ped), GetEntityHeading(ped)))
    
    repeat Wait(100) RequestModel(model) until HasModelLoaded(model) 
    
    Async.ScreenFade(1000, function()
        local car = CreateVehicle(model, x, y, z, h, true, false)
        
        SetPedIntoVehicle(ped, car, -1)
        SetVehicleOnGroundProperly(car)
        SetVehicleHasBeenOwnedByPlayer(car, true)
        SetModelAsNoLongerNeeded(model)
        
        local id = NetworkGetNetworkIdFromEntity(car)
        SetNetworkIdCanMigrate(id, true)
        
         for i = 1, 12, 1 do 
            if not DoesExtraExist(car, i) then 
                goto skip 
            end
            SetVehicleExtra(car, i, 1)
            ::skip::
        end
        
        if not data.defaultExtras then 
            return 
        end 
        
        for i = 1, 12, 1 do 
            if not data.defaultExtras[i] then
                goto skip 
            end
            if not DoesExtraExist(car, i) then 
                goto skip 
            end
            SetVehicleExtra(car, i, 0)
            ::skip::
        end  
        
    end)
end 

--- not the best way, but it works if the players aren't idiots and delete their own cars..
function Spawn:Store()
    DeleteEntity(GetVehiclePedIsIn(PlayerPedId()))
end