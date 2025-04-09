-- description: capture inputs to i.e. navigate in custom screens
-- from plugin: Grauly/xdg-mime.yazi
-- confirmed working up to version: 25.2.26
-- as of date: 2025/04/09

local keys = {
  { on = "q", run = "quit" },
  { on = "a", run = "action"}
}

-- requires async context
local capture_input = function()
    while true do
        local action = (keys[ya.which { cands = keys, silent = true }] or { run = "invalid" }).run
	-- needs to be put here, so you actually stop with the loop
        if action == "quit" then
            return
        end
        act_user_input(action)
    end
end

local act_input = function(action)
    if action == "action" then
	-- do something
    end
    -- just chain else if's here, you can also handle the invalid inputs.
end
