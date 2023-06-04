-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --

local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("^6[SHARED - DEBUG] ^0: "..filename()..".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Config
-- ════════════════════════════════════════════════════════════════════════════════════ --

Config = {}

Config.Framework = "ESX" -- "Standalone" 

Config.Garages = {
    ["police"] = {
        Label = "Police Garage",
        Job = 'police', 
        Coords = vec3(438.85, -1018.92, 28.75),
        SpawnCoords = vec4(438.67, -1026.03, 28.78, 2.85), 
        Blip = {
            id = 1, 
            scale = 0.8, 
            colour = -1,
        },
        Vehicles = {
            ['police'] = {
                label = 'Police Interceptor',
                grade = 2, 
                defaultExtras = {
                    [1] = true, 
                    [4] = true, 
                    [12] = true
                }
            },
        }
    },
    ["mechanic"] = {
        Label = "Mechanic Garage",
        Coords = vec3(0, 0, 0),
        Vehicles = {
            ['towtruck'] = 'Tow Truck'
        }
    }
}

Config.Text = {
    ['open_menu'] = "Drücke ~INPUT_CONTEXT~ um das Menü zu öffnen.",
    ['menu_name'] = 'Job Garage',
    ['store'] = "Fahrzeug einparken"
}