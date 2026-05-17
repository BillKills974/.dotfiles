require("common")
require("env")
require("monitors")
require("autostart")
require("binds")
require("input")
require("laf")
require("rules")

local confdir = debug.getinfo(1, "S").source:sub(2):match("(.*/)") or "./"
local f = io.open(confdir .. "custom/init.lua", "r")
if f then
	io.close(f)
	require("custom")
end
