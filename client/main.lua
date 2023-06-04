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

JobGarage = {}

function JobGarage:init()
    for garage, data in pairs(Config.Garages) do 
        if data.Blip then 
            Game.AddBlip(data.Coords, data.Blip.id, data.Blip.scale, data.Blip.colour, false, data.Label, true)
        end     
    end
end 

function JobGarage:Main()
    local ped = PlayerPedId()
    for garage, data in pairs(Config.Garages) do 
        if not Bridge:HasJob(data.Job) then 
            goto continue
        end     
        Game.Target(ped, data.Coords, 4, 2, true, function()
            Visual.ShowHelp(Config.Text["open_menu"], true)
            if IsControlJustPressed(0, 38) then 
                Menu:Open(data.Vehicles)
            end 
        end, function()
            RageUI.CloseAll()
        end)
        ::continue::
    end
end

Async.Task(function()
    while true do 
        Wait(0)
        JobGarage:Main()
    end
end)