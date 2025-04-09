-- description: two helper functions that I use to store and retrieve information across the different sync and async functions of my plugin.
-- from plugin: wylie102/duckdb.yazi
-- confired working up to version: 25.4.8
-- as of date: 2025/04/09

local set_state = ya.sync(function(state, key, value)
	state.opts = state.opts or {}
	state.opts[key] = value
end)

local get_state = ya.sync(function(state, key)
	state.opts = state.opts or {}
	return state.opts[key]
end)
