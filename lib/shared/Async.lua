-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Debug Logs
-- ════════════════════════════════════════════════════════════════════════════════════ --
local filename = function()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("^.*/(.*).lua$") or str
end
print("[SHARED - DEBUG] : " .. filename() .. ".lua gestartet");

-- ════════════════════════════════════════════════════════════════════════════════════ --
-- Object Visual
-- ════════════════════════════════════════════════════════════════════════════════════ --

---@class Async 
Async = {}

---@important: THIS FUNCTION IS CLIENT ONLY AND WILL NOT WORK ON THE SERVER.
--- Performs a task while doing a screen fade (in & out). 
---@param time number
---@param func function
function Async.ScreenFade(time, func)
    Citizen.CreateThread(function()
        DoScreenFadeOut(1000)
        Citizen.Wait(1500)
        if func ~= nil then 
            func()
        end
        Citizen.Wait(time)
        DoScreenFadeIn(1000)
    end)
end


--- Don't ask me the purpose of this shit it is purely aesthetic. 
--- There is no benefit in using this function other than knowing it's async.
---@param func function
function Async.Task(func)
    if not func then 
        return 
    end
    CreateThread(function()
        func()
    end)
end

--- Intended to be more readable and understandable than the function of cfx. 
---@param func any
---@return promise
function Async.Await(func)
    if not func then 
        return 
    end 
    local promise = promise.new() 
    func(promise) 
    return Citizen.Await(promise)
end