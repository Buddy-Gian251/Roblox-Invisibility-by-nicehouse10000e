local link = "https://raw.githubusercontent.com/Buddy-Gian251/Roblox-Invisibility-by-nicehouse10000e/main/invis.lua"
local ok, result = pcall(function()
  loadstring(game:HttpGet(link))()
end)

if ok then
  print("Successfully loaded: "..link)
else
  warn("[NV] nicevisibility error: "..result)
end
