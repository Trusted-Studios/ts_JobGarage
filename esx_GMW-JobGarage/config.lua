---@diagnostic disable: undefined-global, trailing-space, lowercase-global
--#region Code Setup
local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print(filename()..".lua gestartet");

--#endregion

-- #region Configuration 
Config = {}

-- #region Menü Infos
Config.MenuInfos = {
    _MPosition  = "right",
    _MLabel     = "Police Garage",
    _MDesc      = "~b~LSPD Garage",
    _JobName    = "police", 
    _Extras     = true 
}
-- #endregion

-- #region Garage Config
Config.JobGarage = {
    iniMenu = {
            {iniCoords = {
                {Coords = vector3(426.18, -1015.81, 28.99)},
                {Coords = vector3(423.81, -1029.18, 29.05)},
            }, 
            vehicles = {
                {Label = "Police 1", spwn = "tarleg",  Livery = 0},
                {Label = "Police 2", spwn = "police2", Livery = 0},
                {Label = "Police 3", spwn = "police3", Livery = 0},
                {Label = "Police 4", spwn = "police4", Livery = 0},

            }
        }
    }    
}
-- #endregion

-- While Schleife, damit die Koordinaten aktualisiert werden
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        Config.Disable  =  false                                     -- Soll das RMenu sofort geschlossen werden? (true = ja / false = nein)
        Config.SpawnPos =  GetEntityCoords(GetPlayerPed(-1), false)  -- oder vector3() [WICHTIG: **nicht** x, y, z]
        Config.Heading  =  GetEntityHeading(GetPlayerPed(-1))        -- oder ein float (Zahl mit nachkommastelle)
    end
end)
-- #endregion