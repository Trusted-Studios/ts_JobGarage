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

RMenu.Add("GMW_Scripts:JobGarage", "mainMenu", RageUI.CreateMenu(Config.Text['menu_name'], "~p~Trusted Studios~s~ & ~b~GMW", 1450, 0))

Menu = {
    mainMenu = RMenu:Get("GMW_Scripts:JobGarage", "mainMenu"),
    Data = nil
}

function Menu:Open(data)
    if not data then 
        print("^1[ERROR]^0 - please check your config files for errors!")
        return 
    end     
    self.Data = data
    RageUI.Visible(self.mainMenu, not RageUI.Visible(self.mainMenu))
end

function Menu:Main()
    RageUI.IsVisible(self.mainMenu, function()
        for vehicle, data in pairs(self.Data) do 
            if not Bridge:HasGrade(data.grade or 0) then 
                goto continue
            end 
            RageUI.Button(type(data) == 'string' and data or data.label, nil, {}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    Spawn:Vehicle(vehicle, data, self.Data.SpawnCoords)
                end
            })
            ::continue::
        end
        RageUI.Separator("-")
        RageUI.Button(Config.Text['store'], nil, {}, true, {
            onSelected = function()
                RageUI.CloseAll()
                Spawn:Store()
            end
        }) 
    end)
end

Async.Task(function()
    while true do
        Wait(0)
        Menu:Main()
    end
end)