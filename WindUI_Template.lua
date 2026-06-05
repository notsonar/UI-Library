local WindUI = loadstring(game:HttpGet(
	"https://raw.githubusercontent.com/notsonar/UI-Library/refs/heads/master/WindUI.lua"
))()

local Window = WindUI:CreateWindow({
	Title = "Template v0.0.0",
	Author = "By Sonarsilly",
	Logo = "rbxassetid://136744428120502",
	Theme = "Dark",
	Size = UDim2.fromOffset(600, 420),
	SideBarWidth = 200,
	Transparent = true
})

local MainTab = Window:Tab({
	Title = "Main",
	Icon = "layers"
})

MainTab:Section({
	Title = "Welcome"
})