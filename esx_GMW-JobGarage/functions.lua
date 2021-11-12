--- @diagnostic disable: undefined-global, trailing-space, lowercase-global, redefined-local, undefined-doc-name

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print(filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- functions
-- ════════════════════════════════════════════════════════════════════════════════════ --

--- Farbe ist NICHT als Parameter gegeben
--- | Native Reference: https://docs.fivem.net/natives/?_0x28477EC23D892089
--- @param x integer
--- @param y integer 
--- @param z integer
--- @return Visual
function addMarker(x, y, z)
    DrawMarker(1, x, y, z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.6, 0.6, 0.5, 0, 191, 255, 100, false, true, 2, false, nil, nil, false)
end 


--- Left corner help message
--- @param text string
--- @param bleep boolean
--- @return Visual
function ShowHelp(text, bleep)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, bleep, -1)
end

--- Left bottom corner notification
--- @param text string
--- @return Visual
function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end

--- delete vehicle
--- @param entity string
--- @return function
function deleteCar(entity)
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized(entity))
end

--- Console logs
--- @param str any
--- @return debuginfo
function ConsoleDebug(str)
    if Config.Debug then 
        print(str)
    end 
end 

--- spwan vehicle
--- @param car string
function spawnCar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end
    local x, y, z = table.unpack(Config.SpawnPos)
    local vehicle = CreateVehicle(car, x, y + 0.5, z, Config.Heading, true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
end

--- Delete Vehicle ped is in
--- @return function
function delVehiclePedIsIn()
    local ped = GetPlayerPed(-1)
    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then 
        if (IsPedSittingInAnyVehicle(ped)) then 
            local veh = GetVehiclePedIsIn(ped, false)
            if (GetPedInVehicleSeat(veh, -1) == ped) then 
                SetEntityAsMissionEntity(veh, true, true) 
                deleteCar(veh)
            end 
        end 
    end
end