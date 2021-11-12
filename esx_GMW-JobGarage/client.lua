---@diagnostic disable: undefined-global, trailing-space, undefined-field, lowercase-global

-- #region Code Setup
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)


local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print(filename()..".lua gestartet")

local i = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if i == 0 then 
            ESX.TriggerServerCallback("GMW_Scripts:FileStartetd", function(file) 
                print(file..".lua gestartet")
            end)
            i = 1
        end 
    end
end)
-- #endregion

-- #region Vars
local self              = {}
local ped               = GetPlayerPed(-1)
local rightPosition     = {x = 1450, y = 0}
local leftPosition      = {x = 0, y = 0}
local menuPosition      = {x = 0, y = 0}
local MenuPosition      = Config.MenuInfos._MPosition
-- #endregion

-- #region Menu position
if MenuPosition then
    if MenuPosition == "left" then
        menuPosition = leftPosition
    elseif MenuPosition == "right" then
        menuPosition = rightPosition
    end
end
-- #endregion

-- #region Menu initialisation
RMenu.Add("GMW_Scripts:mainMenu", "main", RageUI.CreateMenu(Config.MenuInfos._MLabel, Config.MenuInfos._MDesc, menuPosition["x"], menuPosition["y"]))
RMenu.Add("GMW_Scripts:mainMenu", "extra", RageUI.CreateSubMenu(RMenu:Get("GMW_Scripts:mainMenu", "main"), Config.MenuInfos._MLabel, Config.MenuInfos._MDesc, menuPosition["x"], menuPosition["y"]))
-- #endregion

-- #region Menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        RageUI.IsVisible(RMenu:Get("GMW_Scripts:mainMenu", "main"), function()
            for k, v in pairs(self.vehicles) do 
                RageUI.Button(v.Label, "Parke ein Fahrzeug aus: ~y~"..v.Label, {}, true, {
                    onSelected = function()
                        delVehiclePedIsIn()
                        if Config.Disable == true then 
                            RageUI.CloseAll()
                        end 
                        spawnCar(v.spwn)
                        veh = GetVehiclePedIsIn(ped)
                        SetVehicleLivery(veh, v.Livery)
                    end
                })
            end     
            RageUI.Separator("↓")
            if IsPedInAnyVehicle(ped, true) then
                if Config.MenuInfos._Extras then 
                    RageUI.Button("Fahrzeug Extras", "Verwalte die Fahrzeugextras deines aktuell ausgeparkten Fahrzeugs aus", {RightLabel = "→→→"}, true, {onSelected = function() end}, RMenu:Get("GMW_Scripts:mainMenu", "extra"))
                else 
                    RageUI.Button("Fahrzeug Extras", "~r~Menü gesperrt", {}, false, {onSelected = function() end})
                end
                RageUI.Button("Fahrzeug einparken", "~r~Parke Fahrzeuge wieder in die Garage ein.", {Color = {HightLightColor = {255, 255, 255, 255}, BackgroundColor = {255, 26, 26, 100}}}, true, {
                    onSelected = function()
                        delVehiclePedIsIn()
                        RageUI.CloseAll()
                    end
                })
            else 
                RageUI.Button("Schließen & weiter", "Solltest du doch kein Fahrzeug ausparken wollen kannst du das Menü einfach schließen", {Color = {HightLightColor = {255, 255, 255, 255}, BackgroundColor = {255, 26, 26, 100}}}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                    end
                })
            end
        end)
        RageUI.IsVisible(RMenu:Get("GMW_Scripts:mainMenu", "extra"), function()
            local veh = GetVehiclePedIsIn(ped)
            for id = 0, 12 do 
                if DoesExtraExist(veh, id) then 
                    state = IsVehicleExtraTurnedOn(veh, id)
                    if state then 
                        RageUI.Button("Extra "..id, "Entferne Fahrzeugextra Nr. ~r~"..id.."~w~ von dem Fahrzeug", {RightLabel = "~g~On"}, true, {
                            onSelected = function()
                                SetVehicleExtra(veh, id, 1)
                            end 
                        })
                    else 
                        RageUI.Button("Extra "..id, "Setze Fahrzeugextra Nr. ~g~"..id.."~w~ auf", {RightLabel = "~r~Off"}, true, {
                            onSelected = function()
                                SetVehicleExtra(veh, id, 0)
                            end 
                        })
                    end 
                end
            end
            RageUI.Separator("↓")
            RageUI.Button("Schließen & weiter", "Solltest du doch kein Fahrzeug ausparken wollen kannst du das Menü einfach schließen", {Color = {HightLightColor = {255, 255, 255, 255}, BackgroundColor = {255, 26, 26, 100}}}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                end
            })
        end)
    end
end)
-- #endregion

-- #region open Menu
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(Config.JobGarage.iniMenu) do 
            self = v
            local ped = PlayerPedId(-1)             
            local coords = GetEntityCoords(ped)
            for _k, _v in pairs(self.iniCoords) do 
                local x, y, z = table.unpack(_v.Coords)
                local dist = Vdist(coords, x, y, z)
                if (ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == Config.MenuInfos._JobName) then
                    if dist <= 5 then 
                        addMarker(x, y, z)
                        if not IsEntityDead(ped) then 
                            if dist <= 2 then 
                                ShowHelp("Drücke ~INPUT_CONTEXT~ um die Garage zu verwalten", true)
                                if IsControlJustPressed(0, 38) then 
                                    RageUI.Visible(RMenu:Get("GMW_Scripts:mainMenu", "main"), not RageUI.Visible(RMenu:Get("GMW_Scripts:mainMenu", "main")))
                                end
                            else 
                                RageUI.CloseAll()
                            end
                        end  
                    end 
                end 
            end 
        end
    end
end)
-- #endregion
