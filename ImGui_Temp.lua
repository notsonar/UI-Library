local required = {
    getrawmetatable   = getrawmetatable or false,
    request           = http_request or request or (http and http.request) or (syn and syn.request) or false,
    getsenv           = getsenv or false,
    listfiles         = listfiles or listdir or syn_io_listdir or false,
    isfolder          = isfolder or false,
    hookfunction      = hookfunction or hookfunc or replaceclosure or false,
    newcclosure       = newcclosure or false,
    getnamecallmethod = getnamecallmethod or false,
    checkcaller       = checkcaller or false,
}

for a, b in pairs(required) do
    if b == false then
        game:GetService("Players").LocalPlayer:Kick()
        task.wait(0.1)
        game:GetService("Players").LocalPlayer:Kick("Missing: " .. a .. ".")
        return
    end
end

local executor = identifyexecutor()

local allowedExecutors = {
    ["Madium"] = true,
    ["Potassium"] = true,
	["Xeno"] = false,
	["Volt"] = true,
}

local function sendNotification(title, text, duration)
    duration = duration or 5
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration
        })
    end)
end

if allowedExecutors[executor] == true then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/toasty-dev/pissblox/main/modules/fakedrawinglib.lua"))()
else
    sendNotification("Executor Not Supported!", "The executor you are using is not supported, Please check supported executors in the discord", 10)
    return
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/makerpastaa/roblox_stuff/refs/heads/main/assets/Library"))()

loadstring(game:HttpGet("https://raw.githubusercontent.com/toasty-dev/pissblox/main/modules/fakedrawinglib.lua"))()

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local femboyset = {
    Enabled = false,
    ClassName = "Silent",
    ToggleKey = "RightAlt",
    TeamCheck = false,
    VisibleCheck = false, 
    TargetPart = "HumanoidRootPart",
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false, 
    HitChance = 100,
    NoSpread = false,
    NoRecoil = false,
    InfAmmo = false,
    RapidFire = false,
    WalkSpeed = 5,
    WalkEnabled = false,
    WalkKey = "X",
    BHopEnabled = false,
    NoclipEnabled = false,
    NoclipKey = "V",
    AntiKick = false,
    AutoCollectHealth = false,
    CollectRange = 25,
    Killall = false,
    GodMode = false,
    GodModeAll = false,
    CustomGun = false,
    CustomHands = false,
    RemoveHands = false,
    ESPEnabled = false,
    BoxESP = false,
    BoxColor = Color3.fromRGB(255, 255, 255),
    HighlightESP = false,
    HighlightColor = Color3.fromRGB(255, 255, 255),
    ESPTeamCheck = false,
    HealthBar = false,
    NameESP = false,
    DistanceESP = false,
    ToolESP = false,
    TracersEnabled = false,
    TracerTexture = "Lightning Bolt",
    TracerColor = Color3.fromRGB(255, 0, 0),
    TracerWidth = 0.2,
    TracerLifetime = 0.5,
    HitSoundEnabled = false,
    HitSoundType = "neverlose",
    HitSoundVolume = 1,
    WatermarkText = "femboy.club | dev",
    SpinBot = false,
    SpinSpeed = 10,
    DesyncEnabled = false,
    DesyncMode = "Random",
    RandomMin = -2,
    RandomMax = 2,
    RandomSpeed = 20,
    InvisibleY = -50, 
    ChatTagEnabled = false,
    CurrentTagText = "femboy.club",
}

getgenv().femboyset     = femboyset
local MainFileName      = "femboy.club"
local SelectedFile, FileToSave = "", ""
local Camera                  = workspace.CurrentCamera
local Players                 = game:GetService("Players")
local RunService              = game:GetService("RunService")
local GuiService              = game:GetService("GuiService")
local UserInputService        = game:GetService("UserInputService")
local HttpService             = game:GetService("HttpService")
local TweenService            = game:GetService("TweenService")
local LocalPlayer             = Players.LocalPlayer
local Mouse                   = LocalPlayer:GetMouse()
local GetChildren             = game.GetChildren
local GetPlayers              = Players.GetPlayers
local WorldToScreen           = Camera.WorldToScreenPoint
local WorldToViewportPoint    = Camera.WorldToViewportPoint
local GetPartsObscuringTarget = Camera.GetPartsObscuringTarget
local FindFirstChild          = game.FindFirstChild
local RenderStepped           = RunService.RenderStepped
local GuiInset                = GuiService.GetGuiInset
local GetMouseLocation        = UserInputService.GetMouseLocation
local resume                  = coroutine.resume 
local create                  = coroutine.create

local lolzparts = {"Head", "HumanoidRootPart"}

local target_line = Drawing.new("Line")
target_line.Visible = false
target_line.ZIndex = 999 
target_line.Color = Color3.fromRGB(54, 57, 241)
target_line.Thickness = 1

local fov_circle = Drawing.new("Circle")
fov_circle.Thickness = 1
fov_circle.NumSides = 100
fov_circle.Radius = 180
fov_circle.Filled = false
fov_circle.Visible = false
fov_circle.ZIndex = 999
fov_circle.Transparency = 1
fov_circle.Color = Color3.fromRGB(54, 57, 241)

local kkjfdgndsgaskjfaewoigoiakdflajkgfdnakvvdsafas = Instance.new("Folder")
kkjfdgndsgaskjfaewoigoiakdflajkgfdnakvvdsafas.Name = "kkjfdgndsgaskjfaewoigoiakdflajkgfdnakvvdsafas"
kkjfdgndsgaskjfaewoigoiakdflajkgfdnakvvdsafas.Parent = game:GetService("CoreGui")

local esp_data = {}
local noclipconne = nil
local Clip = false
local desyncT = {enabled = false, loc = CFrame.new()}
local desynchook = nil
local randomoffseT = Vector3.new(0, 0, 0)
local randomTimer = 0
local desyncactive = false
local spinbotactiv = false
local spinbotconnectt = nil
local autocollecthealthth = false
local autocollectconn = nil
local walkhact = false
local walkhaccon = nil
local bhopenb = false

local expectedargs = {
    Raycast = {
        ArgCountRequired = 3,
        Args = {
            "Instance", "Vector3", "Vector3", "RaycastParams"
        }
    }
}

local hitsounds = {
    ["neverlose"] = 97643101798871,
    ["primordial"] = 85340682645435,
    ["beamware"] = 92614567965693,
    ["fatality"] = 106586644436584,
    ["skeet"] = 5633695679,
    ["bell"] = 6534947240,
    ["1"] = 5902468562,
}

local tracerss = {
    ["Lightning Bolt"] = "rbxassetid://12781806168",
    ["Lightning Bolt 2"] = "rbxassetid://7151778302",
    ["Laser"] = "rbxassetid://5864341017",
    ["Red Laser"] = "rbxassetid://6333823534",
    ["DNA"] = "rbxassetid://6511613786",
}

local origsound = {}

function calcchanger(Percentage)
    Percentage = math.floor(Percentage)
    local chance = math.floor(Random.new().NextNumber(Random.new(), 0, 1) * 100) / 100
    return chance <= Percentage / 100
end

local function getoffsetrand()
    if femboyset.DesyncMode == "Random" then
        local minVal = femboyset.RandomMin or -2
        local maxVal = femboyset.RandomMax or 2
        local changeRate = femboyset.RandomSpeed or 20
        
        if minVal > maxVal then
            minVal, maxVal = maxVal, minVal
        end

        randomTimer = randomTimer + 1
        local shouldChange = (math.random(1, 100) <= changeRate) or (randomTimer > 60)
        
        if shouldChange then
            randomoffseT = Vector3.new(
                math.random() * (maxVal - minVal) + minVal,
                math.random() * (maxVal - minVal) + minVal,
                math.random() * (maxVal - minVal) + minVal
            )
            randomTimer = 0
        end
        
        return CFrame.new(randomoffseT)
        
    elseif femboyset.DesyncMode == "Invisible" then
        return CFrame.new(0, femboyset.InvisibleY or -50, -2)
    end
    
    return CFrame.new(0, 0, -2)
end

local function desyncstart()
    if desyncactive then return end
    desyncactive = true
    
    RunService.Heartbeat:Connect(function()
        if not femboyset.DesyncEnabled or not LocalPlayer.Character then return end
        
        local character = LocalPlayer.Character
        local root = character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        desyncT.loc = root.CFrame
        
        local offset = getoffsetrand()
        local newCFrame = desyncT.loc * offset
        
        root.CFrame = newCFrame
        
        RunService.RenderStepped:Wait()
        if root then
            root.CFrame = desyncT.loc
        end
    end)
end

local function plsstopsync()
    desyncactive = false
    randomoffseT = Vector3.new(0, 0, 0)
    randomTimer = 0
end

local function toggledesync()
    if femboyset.DesyncEnabled then
        Library:Notify("DONT USE BULLET TRACERS WITH DESYNC BC ITS BROKE IT!!")
        desyncstart()
    else
        plsstopsync()
    end
end

local function hookingdesync()
    if desynchook then return end
    
    desynchook = hookmetamethod(game, "__index", newcclosure(function(self, key)
        if femboyset.DesyncEnabled and not checkcaller() and 
           key == "CFrame" and 
           LocalPlayer.Character and 
           self == LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            return desyncT.loc
        end
        return desynchook(self, key)
    end))
end

do 
    if not isfolder(MainFileName) then 
        makefolder(MainFileName);
    end
    
    if not isfolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId))) then 
        makefolder(string.format("%s/%s", MainFileName, tostring(game.PlaceId)))
    end
end

local Files = listfiles(string.format("%s/%s", "femboy.club", tostring(game.PlaceId)))

local function weaponsmodsapl()
    local backpack = LocalPlayer.Backpack
    local character = LocalPlayer.Character
    
    if not backpack and not character then return end
    
    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") then
            local success, settingModule = pcall(function()
                return require(tool.Setting)
            end)
            
            if success and settingModule then
                if femboyset.NoSpread then
                    settingModule["Spread"] = 0
                end
                if femboyset.NoRecoil then
                    settingModule["Recoil"] = 0
                end
                if femboyset.InfAmmo then
                    settingModule["ReloadTime"] = 0
                end
                if femboyset.RapidFire then
                    settingModule["FireRate"] = 0.05
                end
            end
        end
    end
    
    if character then
        local tool = character:FindFirstChildOfClass("Tool")
        if tool then
            local success, settingModule = pcall(function()
                return require(tool.Setting)
            end)
            
            if success and settingModule then
                if femboyset.NoSpread then
                    settingModule["Spread"] = 0
                end
                if femboyset.NoRecoil then
                    settingModule["Recoil"] = 0
                end
                if femboyset.InfAmmo then
                    settingModule["ReloadTime"] = 0
                end
                if femboyset.RapidFire then
                    settingModule["FireRate"] = 0.05
                end
            end
        end
    end
end

local function infammolop()
    while true do
        if femboyset.InfAmmo then
            weaponsmodsapl()
        end
        wait(0.1) 
    end
end

local function weapontrack()
    if LocalPlayer.Character then
        LocalPlayer.Character.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                wait(0.1) 
                weaponsmodsapl()
            end
        end)
    end
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        character.ChildAdded:Connect(function(child)
            if child:IsA("Tool") then
                wait(0.1)
                weaponsmodsapl()
            end
        end)
    end)
    
    LocalPlayer.Backpack.ChildAdded:Connect(function(tool)
        if tool:IsA("Tool") then
            wait(0.1)
            weaponsmodsapl()
        end
    end)
end

local function antikicklolz()
    while true do
        if femboyset.AntiKick then
            local players = Players:GetPlayers()
            local targetPlayers = {}
            
            for _, player in ipairs(players) do
                if player ~= LocalPlayer then
                    table.insert(targetPlayers, player)
                end
            end
            
            if #targetPlayers > 0 then
                local randomPlayer = targetPlayers[math.random(1, #targetPlayers)]
                local args = {randomPlayer}
                
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("RequestVotekick"):FireServer(unpack(args))
                end)
            end
        end
        wait(1) 
    end
end

local function visualapply()
    local arms = Camera:FindFirstChild("Arms")
    if arms then
        local ct_arms = arms:FindFirstChild("ct_arms")
        if ct_arms then
            if femboyset.CustomHands then
                ct_arms.Material = Enum.Material.ForceField
            else
                ct_arms.Material = Enum.Material.Plastic 
            end
            
            if femboyset.RemoveHands then
                ct_arms.Transparency = 1
            else
                ct_arms.Transparency = 0
            end
        end
        
        local handle = arms:FindFirstChild("Handle")
        if handle then
            if femboyset.CustomGun then
                handle.Material = Enum.Material.ForceField
            else
                handle.Material = Enum.Material.Plastic 
            end
        end
    end
end

local function visaullop()
    while true do
        visualapply()
        wait(0.1) 
    end
end

local function visualtracking()
    Camera.ChildAdded:Connect(function(child)
        if child.Name == "Arms" then
            wait(0.1)
            visualapply()
        end
    end)
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        wait(1)
        visualapply()
    end)
    
    visualapply()
end

local function spinbotapl()
    if spinbotactiv then return end
    spinbotactiv = true
    
    local function setupspspps()
        local character = LocalPlayer.Character
        if not character then return end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        if humanoid.Health <= 0 then
            stopspinbot()
            return
        end

        for i, v in pairs(rootPart:GetChildren()) do
            if v.Name == "Spinning" then
                v:Destroy()
            end
        end
        
        local Spin = Instance.new("BodyAngularVelocity")
        Spin.Name = "Spinning"
        Spin.Parent = rootPart
        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
        Spin.AngularVelocity = Vector3.new(0, femboyset.SpinSpeed, 0)
    end
    
    setupspspps()
    
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health <= 0 then
                    stopspinbot()
                end
            end)
        end
    end

    LocalPlayer.CharacterAdded:Connect(function(character)
        if spinbotactiv then
            wait(2)
            setupspspps()
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if humanoid.Health <= 0 then
                        stopspinbot()
                    end
                end)
            end
        end
    end)
end

local function stopspinbot()
    if not spinbotactiv then return end
    spinbotactiv = false
    
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            for i, v in pairs(rootPart:GetChildren()) do
                if v.Name == "Spinning" then
                    v:Destroy()
                end
            end
        end
    end
end

local function togglespinbot()
    if femboyset.SpinBot then
        spinbotapl()
    else
        stopspinbot()
    end
end

local function aplhitsounds(soundName)
    if not femboyset.HitSoundEnabled then return end
    
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local gunHUD = playerGui:WaitForChild("GunHUD")
    local hitmarkKill = gunHUD:FindFirstChild("HitmarkKill")
    local hitmarkHit = gunHUD:FindFirstChild("HitmarkHit")
    local KillSound = playerGui:FindFirstChild("KillSound")

    if not (hitmarkKill and hitmarkHit and KillSound) then return end
    
    local soundId = hitsounds[femboyset.HitSoundType]
    if not soundId then return end
   
    
    HitmarkHit.SoundId = "rbxassetid://" .. tostring(soundId)
    HitmarkHit.Volume = femboyset.HitSoundVolume
    KillSound.SoundId = "rbxassetid://" .. tostring(soundId)
    KillSound.Volume = 0
    hitmarkKill.SoundID = "rbxassetid://" .. tostring(soundId)
    hitmarkKill.volume = 0

end

local function aplybhop()
    local function setypbhop()
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end
        
        humanoid.JumpHeight = 4
        humanoid.UseJumpPower = false
    end
    
    setypbhop()
    
    LocalPlayer.CharacterAdded:Connect(function(character)
        if femboyset.BHopEnabled then
            wait(1)
            setypbhop()
        end
    end)
end

local function plsstopbhop()
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpHeight = 7.2
            humanoid.UseJumpPower = true
        end
    end
end

local function togglehop()
    if femboyset.BHopEnabled then
        aplybhop()
    else
        plsstopbhop()
    end
end

local function StartWalkHack()
    if walkhact then return end
    walkhact = true
    
    local hb = RunService.Heartbeat
    
    walkhaccon = hb:Connect(function(delta)
        local chr = LocalPlayer.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
        
        if walkhact and chr and hum and hum.Parent then
            if hum.MoveDirection.Magnitude > 0 then
                chr:TranslateBy(hum.MoveDirection * femboyset.WalkSpeed * delta * 50)
            end
        end
    end)
end

local function some11notaproveit()
    walkhact = false
    if walkhaccon then
        walkhaccon:Disconnect()
        walkhaccon = nil
    end
end

local function toglewalkh()
    if femboyset.WalkEnabled then
        StartWalkHack()
    else
        some11notaproveit()
    end
end

local function autocollectheal()
    if autocollecthealthth then return end
    autocollecthealthth = true
    
    autocollectconn = RunService.Heartbeat:Connect(function()
        if not femboyset.AutoCollectHealth then
            stopautocolect()
            return
        end
        
        local character = LocalPlayer.Character
        if not character then return end
        
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then return end

        local healthStorage = workspace:FindFirstChild("HPPackStorage")
        if not healthStorage then return end
        
        local playerPos = humanoidRootPart.Position

        for _, healthPack in ipairs(healthStorage:GetChildren()) do
            if healthPack:IsA("Part") or healthPack:IsA("MeshPart") then
                local healthPos = healthPack.Position
                local distance = (playerPos - healthPos).Magnitude

                if distance <= femboyset.CollectRange then
                    healthPack.CFrame = humanoidRootPart.CFrame
                    wait(0.05)
                end
            end
        end
    end)
end

local function stopautocolect()
    autocollecthealthth = false
    if autocollectconn then
        autocollectconn:Disconnect()
        autocollectconn = nil
    end
end

local function toggleautocoletctc()
    if femboyset.AutoCollectHealth then
        autocollectheal()
    else
        stopautocolect()
    end
end

local function some11aproveitbtw()
    getgenv().text = {"$$ femboy.club on top $$","J.","femboy kill all.lua","femboy cummed in ur face(,,>ï¹<,,)", ">.<", "rape me:3", "*cums cutely ðŸŽ€ *", "ðŸ³â€ðŸŒˆsayðŸ¥›gexðŸ¥µ"}

    for _, player in pairs(Players:GetPlayers()) do
        if femboyset.TeamCheck and player.Team == LocalPlayer.Team then
            continue
        end
        
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local targetPart = player.Character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and targetPart then
                local textt = getgenv().text[math.random(1, #getgenv().text)]
                local args = {
                    {
                        rayInstance = targetPart,
                        rayPosition = targetPart.Position,
                        rayMaterial = Enum.Material.Plastic,
                        rayNormal = Vector3.new(0, 1, 0)
                    },
                    targetPart.Position,
                    Vector3.new(0, 1, 0),
                    8,
                    {
                        MainDamage = math.huge,
                        BackstabDamage = math.huge,
                        AltDamage = math.huge
                    },
                    2,
                    false,
                    textt
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("MeleeAttack"):FireServer(unpack(args))
            end
        end
    end
end

local function WOWITSGODMODLOLOL()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Head") then return end
    
    local args = {
        {
            rayInstance = LocalPlayer.Character.Head,
            rayPosition = LocalPlayer.Character.Head.Position,
            rayMaterial = Enum.Material.Fabric,
            rayNormal = Vector3.new(0, 1, 0)
        },
        "Snowball",
        -math.huge,
        3,
        false
    }
    
    local success, result = pcall(function()
        game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ProjectileHit"):FireServer(unpack(args))
    end)
end

local function impoorgivemeskins()
    local skinsrep = game:GetService("ReplicatedStorage"):FindFirstChild("Skins")
    
    if not skinsrep then
        Library:Notify('skins folder not found in repo =)', 3)
        return false
    end
    
    local localPlayerSkins = LocalPlayer:FindFirstChild("Skins")

    if localPlayerSkins then
        localPlayerSkins:Destroy()
        task.wait(0.1)
    end

    local skinslp = skinsrep:Clone()
    skinslp.Parent = LocalPlayer
    
    Library:Notify('skins successfully spawned', 3)
    task.wait(.2)
    Library:Notify('(its beta function if its bugged im fix it later)', 3)
    return true
end

local function WOWITSGODMODLOLOLALL()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("Head") then
            local args = {
                {
                    rayInstance = player.Character.Head,
                    rayPosition = player.Character.Head.Position,
                    rayMaterial = Enum.Material.Fabric,
                    rayNormal = Vector3.new(0, 1, 0)
                },
                "Snowball",
                -math.huge,
                3,
                false
            }
            
            local success, result = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("ProjectileHit"):FireServer(unpack(args))
            end)
        end
    end
end

local godmodework = false
local godmodeallwork = false
local connectgodmde = nil
local connectgodmodeall = nil

local function startgm()
    if godmodework then return end
    godmodework = true
    
    connectgodmde = RunService.Heartbeat:Connect(function()
        if femboyset.GodMode then
            WOWITSGODMODLOLOL()
        end
    end)
end

local function stopgm()
    godmodework = false
    if connectgodmde then
        connectgodmde:Disconnect()
        connectgodmde = nil
    end
end

local function startgmAll()
    if godmodeallwork then return end
    godmodeallwork = true
    
    connectgodmodeall = RunService.Heartbeat:Connect(function()
        if femboyset.GodModeAll then
            WOWITSGODMODLOLOLALL()
        end
    end)
end

local function stopgmAll()
    godmodeallwork = false
    if connectgodmodeall then
        connectgodmodeall:Disconnect()
        connectgodmodeall = nil
    end
end

local function togglegm()
    if femboyset.GodMode then
        startgm()
    else
        stopgm()
    end
end

local function togglegmAll()
    if femboyset.GodModeAll then
        startgmAll()
    else
        stopgmAll()
    end
end

local function odetzalupku()
    local args = {
        [1] = true,
        [2] = SelectedTag,
        [3] = SelectedColor,
        [4] = ""
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EquipTag"):FireServer(unpack(args))
    Library:Notify("tag: " .. SelectedTag .. " equiped", 3)
end

local function nocliplop()
    if Clip == false and LocalPlayer.Character ~= nil then
        for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true then
                child.CanCollide = false
            end
        end
    end
end

local function startnoclip()
    if noclipconne then return end
    Clip = false
    noclipconne = RunService.Stepped:Connect(nocliplop)
end

local function stopnoclip()
    if not noclipconne then return end
    Clip = true
    noclipconne:Disconnect()
    noclipconne = nil
    
    if LocalPlayer.Character then
        for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") then
                child.CanCollide = true
            end
        end
    end
end

local function togglenoclip()
    if femboyset.NoclipEnabled then
        startnoclip()
    else
        stopnoclip()
    end
end

local function CreateTracer(StartPos, EndPos)
    task.spawn(function()
        local Attachment1 = Instance.new("Attachment")
        local Attachment2 = Instance.new("Attachment")
        local Holder = Instance.new("Part")
        
        Holder.Name = "TracerHolder"
        Holder.Anchored = true
        Holder.CanCollide = false
        Holder.Transparency = 1
        Holder.Size = Vector3.zero
        Holder.Parent = workspace
        
        Attachment1.Parent = Holder
        Attachment2.Parent = Holder
        Attachment1.WorldPosition = StartPos
        Attachment2.WorldPosition = EndPos
        
        local Beam = Instance.new("Beam")
        Beam.Attachment0 = Attachment1
        Beam.Attachment1 = Attachment2
        Beam.Texture = tracerss[femboyset.TracerTexture] or tracerss["Lightning Bolt"]
        Beam.TextureMode = Enum.TextureMode.Wrap
        Beam.TextureSpeed = 10
        Beam.FaceCamera = true
        Beam.LightEmission = 1
        Beam.Width0 = femboyset.TracerWidth
        Beam.Width1 = femboyset.TracerWidth
        Beam.Color = ColorSequence.new(femboyset.TracerColor)
        Beam.Transparency = NumberSequence.new(0)
        Beam.Parent = Holder
        
        task.wait(femboyset.TracerLifetime)
        for i = 1, 30 do
            task.wait(0.033)
            Beam.Transparency = NumberSequence.new(i / 30)
        end
        Holder:Destroy()
    end)
end

local OldFire
OldFire = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local Args = {...}
    local Method = getnamecallmethod()
    
    if Method == "FireServer" and Self.Name == "FireGun" and not checkcaller() and femboyset.TracersEnabled then
        local RayData = Args[1]
        if RayData and RayData.rayPosition then
            local StartPos = workspace.CurrentCamera.CFrame.Position
            local EndPos = RayData.rayPosition
            CreateTracer(StartPos, EndPos)
        end
    end
    
    return OldFire(Self, unpack(Args))
end))

local function createesp(plr)
    if plr == LocalPlayer or esp_data[plr] then return end
    
    local box = Drawing.new("Square")
    box.Color = femboyset.BoxColor
    box.Thickness = 1
    box.Filled = false
    
    local outline = Drawing.new("Square")
    outline.Color = Color3.new(0, 0, 0)
    outline.Thickness = 1.8
    outline.Filled = false
    
    local name = Drawing.new("Text")
    name.Size = 13
    name.Font = 2
    name.Color = Color3.new(1, 1, 1)
    name.Outline = true
    name.Center = true
    
    local dist = Drawing.new("Text")
    dist.Size = 13
    dist.Font = 2
    dist.Color = Color3.new(1, 1, 1)
    dist.Outline = true
    dist.Center = true
    
    local tool = Drawing.new("Text")
    tool.Size = 12
    tool.Font = 2
    tool.Color = Color3.new(1, 1, 1)
    tool.Outline = true
    
    local health_bg = Drawing.new("Square")
    health_bg.Filled = true
    health_bg.Color = Color3.new(0, 0, 0)
    health_bg.Transparency = 0.6
    
    local health_bar = Drawing.new("Square")
    health_bar.Filled = true
    
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.8
    hl.OutlineTransparency = 0
    hl.FillColor = femboyset.HighlightColor
    hl.OutlineColor = femboyset.HighlightColor
    hl.Parent = kkjfdgndsgaskjfaewoigoiakdflajkgfdnakvvdsafas
    
    esp_data[plr] = {
        box = box,
        outline = outline,
        name = name,
        dist = dist,
        tool = tool,
        health_bg = health_bg,
        health_bar = health_bar,
        hl = hl
    }
end

local function removeesp(plr)
    if esp_data[plr] then
        for _, v in pairs(esp_data[plr]) do 
            if v.Remove then 
                v:Remove() 
            end 
        end
        esp_data[plr].hl:Destroy()
        esp_data[plr] = nil
    end
end

local function getbbox(char)
    local cf, size = char:GetBoundingBox()
    local c = {
        cf * CFrame.new(size.X/2, size.Y/2, size.Z/2),
        cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2),
        cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2),
        cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2),
        cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2),
        cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2),
        cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2),
        cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2)
    }
    local minX, minY = 1/0, 1/0
    local maxX, maxY = -1/0, -1/0
    for _, v in pairs(c) do
        local s, on = Camera:WorldToViewportPoint(v.Position)
        if on then
            minX = math.min(minX, s.X) 
            minY = math.min(minY, s.Y)
            maxX = math.max(maxX, s.X) 
            maxY = math.max(maxY, s.Y)
        end
    end
    if minX == 1/0 then return end
    return Vector2.new(minX, minY), Vector2.new(maxX, maxY)
end

local function updesp()
    if not femboyset.ESPEnabled then
        for _, d in pairs(esp_data) do
            d.box.Visible = false 
            d.outline.Visible = false 
            d.name.Visible = false
            d.dist.Visible = false 
            d.tool.Visible = false 
            d.health_bg.Visible = false
            d.health_bar.Visible = false 
            d.hl.Enabled = false
        end
        return
    end
    
    local mypos = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    mypos = mypos and mypos.Position
    
    for plr, d in pairs(esp_data) do
        local char = plr.Character
        if not char then
            d.box.Visible = false 
            d.outline.Visible = false 
            d.name.Visible = false
            d.dist.Visible = false 
            d.tool.Visible = false 
            d.health_bg.Visible = false
            d.health_bar.Visible = false 
            d.hl.Enabled = false
            continue
        end
        
        if femboyset.ESPTeamCheck and plr.Team == LocalPlayer.Team then
            d.box.Visible = false 
            d.outline.Visible = false 
            d.name.Visible = false
            d.dist.Visible = false 
            d.tool.Visible = false 
            d.health_bg.Visible = false
            d.health_bar.Visible = false 
            d.hl.Enabled = false
            continue
        end
        
        local hum = char:FindFirstChildOfClass("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        local toolobj = char:FindFirstChildWhichIsA("Tool")
        
        if not (hum and root and hum.Health > 0) then
            d.box.Visible = false 
            d.outline.Visible = false 
            d.name.Visible = false
            d.dist.Visible = false 
            d.tool.Visible = false 
            d.health_bg.Visible = false
            d.health_bar.Visible = false 
            d.hl.Enabled = false
            continue
        end
        
        local min, max = getbbox(char)
        if not min then
            d.box.Visible = false 
            d.outline.Visible = false 
            d.name.Visible = false
            d.dist.Visible = false 
            d.tool.Visible = false 
            d.health_bg.Visible = false
            d.health_bar.Visible = false 
            continue
        end
        
        local size = max - min
        d.box.Position = min 
        d.box.Size = size 
        d.box.Visible = femboyset.BoxESP
        
        d.outline.Position = min - Vector2.new(1, 1) 
        d.outline.Size = size + Vector2.new(2, 2) 
        d.outline.Visible = femboyset.BoxESP
        
        if femboyset.NameESP then
            d.name.Text = plr.DisplayName
            d.name.Position = Vector2.new(min.X + size.X/2, min.Y - 18)
            d.name.Visible = true
        else
            d.name.Visible = false
        end
        
        if femboyset.DistanceESP and mypos then
            d.dist.Text = math.floor((root.Position - mypos).Magnitude) .. "m"
            d.dist.Position = Vector2.new(min.X + size.X/2, max.Y + 2)
            d.dist.Visible = true
        else
            d.dist.Visible = false
        end
        
        if toolobj and femboyset.ToolESP then
            d.tool.Text = toolobj.Name
            d.tool.Position = Vector2.new(max.X + 5, min.Y + 2)
            d.tool.Visible = true
        else
            d.tool.Visible = false
        end
        
        if femboyset.HealthBar then
            local hp = hum.Health / hum.MaxHealth
            local h = size.Y * hp
            d.health_bg.Position = Vector2.new(min.X - 6, min.Y)
            d.health_bg.Size = Vector2.new(2, size.Y)
            d.health_bg.Visible = true
            
            d.health_bar.Position = Vector2.new(min.X - 6, min.Y + size.Y - h)
            d.health_bar.Size = Vector2.new(2, h)
            d.health_bar.Color = Color3.fromHSV(math.clamp(hp * 0.33, 0, 0.33), 1, 1)
            d.health_bar.Visible = true
        else
            d.health_bg.Visible = false
            d.health_bar.Visible = false
        end
        
        if femboyset.HighlightESP then
            d.hl.Adornee = char
            d.hl.FillColor = femboyset.HighlightColor
            d.hl.OutlineColor = femboyset.HighlightColor
            d.hl.Enabled = true
        else
            d.hl.Enabled = false
        end
    end
end

local function initiliazeesp()
    for plr, _ in pairs(esp_data) do
        removeesp(plr)
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            createesp(player)
        end
    end
    
    Players.PlayerAdded:Connect(function(player)
        wait(1)
        createesp(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        removeesp(player)
    end)
end

local function hitsoundssetup()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local gunHUD = playerGui:WaitForChild("GunHUD")
    local hitmarkKill = gunHUD:FindFirstChild("HitmarkKill")
    local hitmarkHit = gunHUD:FindFirstChild("HitmarkHit")
    local KillSound = playerGui:FindFirstChild("KillSound")
    
    if not (hitmarkKill and hitmarkHit and KillSound) then
        return false
    end

    origsound["KillSound"] = KillSound.SoundId
    return true
end

local function resethitsounds()
    local playerGui = LocalPlayer:WaitForChild("PlayerGui")
    local gunHUD = playerGui:WaitForChild("GunHUD")
    local hitmarkKill = gunHUD:FindFirstChild("HitmarkKill")
    local hitmarkHit = gunHUD:FindFirstChild("HitmarkHit")
    local KillSound = playerGui:FindFirstChild("KillSound")
    
    if not (hitmarkKill and hitmarkHit and KillSound) then return end
    
    if origsound["HitmarkKill"] then
        hitmarkKill.SoundId = origsound["HitmarkKill"]
    end
    
    if origsound["HitmarkHit"] then
        hitmarkHit.SoundId = origsound["HitmarkHit"]
    end

    if origsound["KillSound"] then
        KillSound.SoundId = origsound["KillSound"]
    end

    hitmarkKill.Volume = 1
    hitmarkHit.Volume = 1
    KillSound.Volume = 1
end

local function togglehitsouddns()
    if femboyset.HitSoundEnabled then
        aplhitsounds(femboyset.HitSoundType)
    else
        resethitsounds()
    end
end

local function GetFiles()
    local out = {}
    for i = 1, #Files do
        local file = Files[i]
        if file:sub(-4) == '.lua' then
            local pos = file:find('.lua', 1, true)
            local start = pos

            local char = file:sub(pos, pos)
            while char ~= '/' and char ~= '\\' and char ~= '' do
                pos = pos - 1
                char = file:sub(pos, pos)
            end

            if char == '/' or char == '\\' then
                table.insert(out, file:sub(pos + 1, start - 1))
            end
        end
    end
    
    return out
end

local function UpdateFile(FileName)
    assert(FileName or FileName == "string", "oopsies");
    writefile(string.format("%s/%s/%s.lua", MainFileName, tostring(game.PlaceId), FileName), HttpService:JSONEncode(femboyset))
end

local function LoadFile(FileName)
    assert(FileName or FileName == "string", "oopsies");
    
    local File = string.format("%s/%s/%s.lua", MainFileName, tostring(game.PlaceId), FileName)
    local ConfigData = HttpService:JSONDecode(readfile(File))
    for Index, Value in next, ConfigData do
        femboyset[Index] = Value
    end
end

local function getPositionOnScreen(Vector)
    local Vec3, OnScreen = WorldToScreen(Camera, Vector)
    return Vector2.new(Vec3.X, Vec3.Y), OnScreen
end

local function ValidateArguments(Args, RayMethod)
    local Matches = 0
    if #Args < RayMethod.ArgCountRequired then
        return false
    end
    for Pos, Argument in next, Args do
        if typeof(Argument) == RayMethod.Args[Pos] then
            Matches = Matches + 1
        end
    end
    return Matches >= RayMethod.ArgCountRequired
end

local function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

local function getMousePosition()
    return GetMouseLocation(UserInputService)
end

local function IsPlayerVisible(Player)
    local PlayerCharacter = Player.Character
    local LocalPlayerCharacter = LocalPlayer.Character
    
    if not (PlayerCharacter or LocalPlayerCharacter) then return end 
    
    local PlayerRoot = FindFirstChild(PlayerCharacter, femboyset.TargetPart) or FindFirstChild(PlayerCharacter, "HumanoidRootPart")
    
    if not PlayerRoot then return end 
    
    local CastPoints, IgnoreList = {PlayerRoot.Position, LocalPlayerCharacter, PlayerCharacter}, {LocalPlayerCharacter, PlayerCharacter}
    local ObscuringObjects = #GetPartsObscuringTarget(Camera, CastPoints, IgnoreList)
    
    return ((ObscuringObjects == 0 and true) or (ObscuringObjects > 0 and false))
end

local function getClosestPlayer()
    if not femboyset.TargetPart then return end
    local Closest
    local DistanceToMouse
    for _, Player in next, GetPlayers(Players) do
        if Player == LocalPlayer then continue end
        if femboyset.TeamCheck and Player.Team == LocalPlayer.Team then continue end

        local Character = Player.Character
        if not Character then continue end
        
        if femboyset.VisibleCheck and not IsPlayerVisible(Player) then continue end

        local HumanoidRootPart = FindFirstChild(Character, "HumanoidRootPart")
        local Humanoid = FindFirstChild(Character, "Humanoid")
        if not HumanoidRootPart or not Humanoid or Humanoid and Humanoid.Health <= 0 then continue end

        local ScreenPosition, OnScreen = getPositionOnScreen(HumanoidRootPart.Position)
        if not OnScreen then continue end

        local Distance = (getMousePosition() - ScreenPosition).Magnitude
        if Distance <= (DistanceToMouse or femboyset.FOVRadius or 2000) then
            Closest = ((femboyset.TargetPart == "Random" and Character[lolzparts[math.random(1, #lolzparts)]]) or Character[femboyset.TargetPart])
            DistanceToMouse = Distance
        end
    end
    return Closest
end

Library:SetWatermark(femboyset.WatermarkText)

local Window = Library:CreateWindow({Title = '$$ femboy.club $$', Center = true, AutoShow = true, TabPadding = 8, MenuFadeTime = 0.2})
local SilentAimTab = Window:AddTab("main")
local VisualsTab = Window:AddTab("visuals")
local AntiAimTab = Window:AddTab("anti Aim")
local MiscTab = Window:AddTab("misc")
local ConfigsTab = Window:AddTab("configs")

local MainBOX = SilentAimTab:AddLeftTabbox("main") do
    local Main = MainBOX:AddTab("main")
    
    Main:AddToggle("aim_Enabled", {Text = "silent aim"}):AddKeyPicker("aim_Enabled_KeyPicker", {Default = "RightAlt", SyncToggleState = true, Mode = "Toggle", Text = "Enabled", NoUI = false});
    Main:AddToggle("TeamCheck", {Text = "team check", Default = femboyset.TeamCheck}):OnChanged(function()
        femboyset.TeamCheck = Toggles.TeamCheck.Value
    end)
    Main:AddToggle("VisibleCheck", {Text = "visible check", Default = femboyset.VisibleCheck}):OnChanged(function()
        femboyset.VisibleCheck = Toggles.VisibleCheck.Value
    end)
    Main:AddDropdown("TargetPart", {AllowNull = true, Text = "target part", Default = femboyset.TargetPart, Values = {"Head", "HumanoidRootPart", "Random"}}):OnChanged(function()
        femboyset.TargetPart = Options.TargetPart.Value
    end)
    Main:AddSlider('HitChance', {
        Text = 'hit chance',
        Default = 100,
        Min = 0,
        Max = 100,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.HitChance = Options.HitChance.Value
    end)
end

local VisualsFOVBOX = SilentAimTab:AddRightTabbox("fov visuals") do
    local Visuals = VisualsFOVBOX:AddTab("fov visuals")
    
    Visuals:AddToggle("Visible", {Text = "fov circle"}):AddColorPicker("Color", {Default = Color3.fromRGB(54, 57, 241)}):OnChanged(function()
        fov_circle.Visible = Toggles.Visible.Value
        femboyset.FOVVisible = Toggles.Visible.Value
    end)
    Visuals:AddSlider("Radius", {Text = "fov circle radius", Min = 0, Max = 360, Default = 130, Rounding = 0}):OnChanged(function()
        fov_circle.Radius = Options.Radius.Value
        femboyset.FOVRadius = Options.Radius.Value
    end)
    Visuals:AddToggle("MousePosition", {Text = "silent aim target"}):AddColorPicker("MouseVisualizeColor", {Default = Color3.fromRGB(54, 57, 241)}):OnChanged(function()
        target_line.Visible = Toggles.MousePosition.Value 
        femboyset.ShowSilentAimTarget = Toggles.MousePosition.Value 
        if not Toggles.MousePosition.Value then
            target_line.Visible = false
        end
    end)
end

local ESPBOX = VisualsTab:AddLeftTabbox("esp") do
    local ESP = ESPBOX:AddTab("esp")
    
    ESP:AddToggle("ESPEnabled", {Text = "esp enabled", Default = femboyset.ESPEnabled}):OnChanged(function()
        femboyset.ESPEnabled = Toggles.ESPEnabled.Value
        if femboyset.ESPEnabled then
            initiliazeesp()
        else
            for plr, _ in pairs(esp_data) do
                removeesp(plr)
            end
        end
    end)
    
    ESP:AddToggle("ESPTeamCheck", {Text = "team check", Default = femboyset.ESPTeamCheck}):OnChanged(function()
        femboyset.ESPTeamCheck = Toggles.ESPTeamCheck.Value
    end)
    
    ESP:AddToggle("BoxESP", {Text = "box esp", Default = femboyset.BoxESP}):AddColorPicker("BoxColor", {Default = Color3.fromRGB(255, 255, 255)}):OnChanged(function()
        femboyset.BoxESP = Toggles.BoxESP.Value
        femboyset.BoxColor = Options.BoxColor.Value
    end)
    
    ESP:AddToggle("NameESP", {Text = "name esp", Default = femboyset.NameESP}):OnChanged(function()
        femboyset.NameESP = Toggles.NameESP.Value
    end)
    
    ESP:AddToggle("DistanceESP", {Text = "distance esp", Default = femboyset.DistanceESP}):OnChanged(function()
        femboyset.DistanceESP = Toggles.DistanceESP.Value
    end)
    
    ESP:AddToggle("ToolESP", {Text = "tool esp", Default = femboyset.ToolESP}):OnChanged(function()
        femboyset.ToolESP = Toggles.ToolESP.Value
    end)
    
    ESP:AddToggle("HealthBar", {Text = "health bar", Default = femboyset.HealthBar}):OnChanged(function()
        femboyset.HealthBar = Toggles.HealthBar.Value
    end)
    
    ESP:AddToggle("HighlightESP", {Text = "highlight esp", Default = femboyset.HighlightESP}):AddColorPicker("HighlightColor", {Default = Color3.fromRGB(255, 255, 255)}):OnChanged(function()
        femboyset.HighlightESP = Toggles.HighlightESP.Value
        femboyset.HighlightColor = Options.HighlightColor.Value
    end)
end

local CustomizationBOX = VisualsTab:AddRightTabbox("customization") do
    local Customization = CustomizationBOX:AddTab("customization")
    
    Customization:AddToggle("CustomGun", {Text = "forcefield gun", Default = femboyset.CustomGun}):OnChanged(function()
        femboyset.CustomGun = Toggles.CustomGun.Value
        visualapply()
    end)
    
    Customization:AddToggle("CustomHands", {Text = "forcefield hands", Default = femboyset.CustomHands}):OnChanged(function()
        femboyset.CustomHands = Toggles.CustomHands.Value
        visualapply()
    end)
    
    Customization:AddToggle("RemoveHands", {Text = "remove hands", Default = femboyset.RemoveHands}):OnChanged(function()
        femboyset.RemoveHands = Toggles.RemoveHands.Value
        visualapply()
    end)

    Customization:AddButton("better gui", function()
        LocalPlayer.PlayerGui.MainMenu.ColourBackground.BackgroundColor3 = Color3.fromRGB(255,0,255)
        LocalPlayer.PlayerGui.MainMenu.Background.PlayerInfo.Level.Level.Text = "femboy.club user"
        LocalPlayer.PlayerGui.MainMenu.Background.PlayerInfo.Level.XP.Text = "femboy."
        LocalPlayer.PlayerGui.MainMenu.Background.PlayerInfo.Level.Prestige.Text = "club"
        LocalPlayer.PlayerGui.MainMenu.Background.PlayerInfo.Level.Prestige.Position = UDim2.new{0,0},{0,0}
        LocalPlayer.PlayerGui.GunHUD.GunInfo.UIStroke.Transparency = 1
        LocalPlayer.PlayerGui.GunHUD.GunInfo.GunName.TextTransparency = 1
        LocalPlayer.PlayerGui.GunHUD.GunInfo.GunName.UIStroke.Transparency = 1
        LocalPlayer.PlayerGui.GunHUD.GunInfo.BackgroundTransparency = 1
        LocalPlayer.PlayerGui.GunHUD.GunInfo.FireType.TextTransparency = 1
        LocalPlayer.PlayerGui.GunHUD.GunInfo.FireType.UIStroke.Transparency = 1
        LocalPlayer.PlayerGui.GunHUD.Healthbar.Health.BackgroundColor3 = Color3.fromRGB(255,0,255)
        LocalPlayer.PlayerGui.EmoteWheel.OpenMobile:Destroy()
        LocalPlayer.PlayerGui.Weapons.Background.Melee:Destroy()
        LocalPlayer.PlayerGui.Weapons.Background.Primary:Destroy()
        LocalPlayer.PlayerGui.Weapons.Background.Secondary:Destroy()
        LocalPlayer.PlayerGui.GunHUD.Healthbar.UIStroke:Destroy()
        LocalPlayer.PlayerGui.GunHUD.Healthbar.Title:Destroy()
        LocalPlayer.PlayerGui.GunHUD.Healthbar.UIGradient:Destroy()
        LocalPlayer.PlayerGui.MainMenu.ColourBackground.UIGradient:Destroy()
        LocalPlayer.PlayerGui.DailyMissions:Destroy()

        while true do
            task.wait(.1)
            LocalPlayer.PlayerGui.MainMenu.Background.Title.Text = "$$$ femboy.club $$$"
        end

        Library:Notify('applied', 3)
    end)
end

local TracersBOX = VisualsTab:AddLeftTabbox("bullet tracers") do
    local Tracers = TracersBOX:AddTab("bullet tracers")
    
    Tracers:AddToggle("TracersEnabled", {Text = "bullet tracers", Default = femboyset.TracersEnabled}):OnChanged(function()
        femboyset.TracersEnabled = Toggles.TracersEnabled.Value
    end)
    
    Tracers:AddDropdown("TracerTexture", {
        AllowNull = false,
        Text = "texture style",
        Default = femboyset.TracerTexture,
        Values = {"Lightning Bolt", "Lightning Bolt 2", "Laser", "Red Laser", "DNA"}
    }):OnChanged(function()
        femboyset.TracerTexture = Options.TracerTexture.Value
    end)
    
    local ColorPickerToggle = Tracers:AddToggle("TracerColorToggle", {Text = "tracer color", Default = true})
    ColorPickerToggle:AddColorPicker("TracerColor", {Default = femboyset.TracerColor})
 
    ColorPickerToggle:OnChanged(function()
    end)

    task.spawn(function()
        while true do
            task.wait()
            if Options and Options.TracerColor then
                if femboyset.TracerColor ~= Options.TracerColor.Value then
                    femboyset.TracerColor = Options.TracerColor.Value
                end
            end
        end
    end)
    
    Tracers:AddSlider("TracerWidth", {
        Text = "tracer width",
        Default = femboyset.TracerWidth,
        Min = 0.05,
        Max = 1,
        Rounding = 2,
    }):OnChanged(function()
        femboyset.TracerWidth = Options.TracerWidth.Value
    end)
    
    Tracers:AddSlider("TracerLifetime", {
        Text = "lifetime",
        Default = femboyset.TracerLifetime,
        Min = 0.1,
        Max = 2,
        Rounding = 1,
    }):OnChanged(function()
        femboyset.TracerLifetime = Options.TracerLifetime.Value
    end)
end

local HitSoundBOX = VisualsTab:AddRightTabbox("hit sounds") do
    local HitSound = HitSoundBOX:AddTab("hit sounds")
    
    HitSound:AddToggle("HitSoundEnabled", {Text = "hit sounds", Default = femboyset.HitSoundEnabled}):OnChanged(function()
        femboyset.HitSoundEnabled = Toggles.HitSoundEnabled.Value
        togglehitsouddns()
    end)
    
    HitSound:AddDropdown("HitSoundType", {
        AllowNull = false,
        Text = "hit sound type",
        Default = femboyset.HitSoundType,
        Values = {"neverlose", "primordial", "beamware", "fatality", "skeet", "1", "bell"}
    }):OnChanged(function()
        femboyset.HitSoundType = Options.HitSoundType.Value
        if femboyset.HitSoundEnabled then
            aplhitsounds(femboyset.HitSoundType)
        end
    end)
    
    HitSound:AddSlider("HitSoundVolume", {
        Text = "hit sound volume",
        Default = 1,
        Min = 0,
        Max = 5,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.HitSoundVolume = Options.HitSoundVolume.Value
        if femboyset.HitSoundEnabled then
            aplhitsounds(femboyset.HitSoundType)
        end
    end)
end

local SpinBotBOX = AntiAimTab:AddLeftTabbox("spin bot") do
    local SpinBot = SpinBotBOX:AddTab("spin bot")
    
    SpinBot:AddToggle("SpinBot", {Text = "spin bot", Default = femboyset.SpinBot}):OnChanged(function()
        femboyset.SpinBot = Toggles.SpinBot.Value
        togglespinbot()
    end)
    
    SpinBot:AddSlider("SpinSpeed", {
        Text = "spin Speed",
        Default = 10,
        Min = 1,
        Max = 50,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.SpinSpeed = Options.SpinSpeed.Value
        if spinbotactiv then
            stopspinbot()
            spinbotapl()
        end
    end)
end

local DesyncBOX = AntiAimTab:AddRightTabbox("desync") do
    local Desync = DesyncBOX:AddTab("desync")
    
    Desync:AddToggle("DesyncEnabled", {Text = "enable desync", Default = femboyset.DesyncEnabled}):OnChanged(function()
        femboyset.DesyncEnabled = Toggles.DesyncEnabled.Value
        toggledesync()
        if femboyset.DesyncEnabled then
            hookingdesync()
        end
    end)
    
    Desync:AddDropdown("DesyncMode", {
        AllowNull = false,
        Text = "desync mode",
        Default = femboyset.DesyncMode,
        Values = {"Random", "Invisible"}
    }):OnChanged(function()
        femboyset.DesyncMode = Options.DesyncMode.Value
    end)
    
    Desync:AddSlider("RandomMin", {
        Text = "random min",
        Default = -2,
        Min = -10,
        Max = 10,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.RandomMin = Options.RandomMin.Value
    end)
    
    Desync:AddSlider("RandomMax", {
        Text = "random max",
        Default = 2,
        Min = -10,
        Max = 10,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.RandomMax = Options.RandomMax.Value
    end)
    
    Desync:AddSlider("RandomSpeed", {
        Text = "change speed",
        Default = 20,
        Min = 1,
        Max = 100,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.RandomSpeed = Options.RandomSpeed.Value
    end)
    
    Desync:AddSlider("InvisibleY", {
        Text = "invisible Y",
        Default = -50,
        Min = -100,
        Max = 0,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.InvisibleY = Options.InvisibleY.Value
    end)
end

local WeaponModsBOX = MiscTab:AddLeftTabbox("Weapon Modifications") do
    local Main = WeaponModsBOX:AddTab("weapon mods")
    
    Main:AddToggle("NoSpread", {Text = "no spread", Default = femboyset.NoSpread}):OnChanged(function()
        femboyset.NoSpread = Toggles.NoSpread.Value
        weaponsmodsapl()
    end)
    
    Main:AddToggle("NoRecoil", {Text = "no recoil", Default = femboyset.NoRecoil}):OnChanged(function()
        femboyset.NoRecoil = Toggles.NoRecoil.Value
        weaponsmodsapl()
    end)
    
    Main:AddToggle("InfAmmo", {Text = "inf ammo", Default = femboyset.InfAmmo}):OnChanged(function()
        femboyset.InfAmmo = Toggles.InfAmmo.Value
        weaponsmodsapl()
    end)
    
    Main:AddToggle("RapidFire", {Text = "rapid fire", Default = femboyset.RapidFire}):OnChanged(function()
        femboyset.RapidFire = Toggles.RapidFire.Value
        weaponsmodsapl()
    end)
end

local WalkHackBOX = MiscTab:AddLeftTabbox("movement") do
    local WalkHack = WalkHackBOX:AddTab("movement")
    
    WalkHack:AddToggle("WalkEnabled", {Text = "cframe walk", Default = femboyset.WalkEnabled}):AddKeyPicker("WalkKeyPicker", {Default = "X", SyncToggleState = true, Mode = "Toggle", Text = "cframe walk", NoUI = false}):OnChanged(function()
        femboyset.WalkEnabled = Toggles.WalkEnabled.Value
        toglewalkh()
    end)
    
    WalkHack:AddSlider("WalkSpeed", {
        Text = "cframe speed",
        Default = 5,
        Min = 1,
        Max = 10,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.WalkSpeed = Options.WalkSpeed.Value
    end)

    WalkHack:AddToggle("BHopEnabled", {Text = "bhop", Default = femboyset.BHopEnabled}):OnChanged(function()
        femboyset.BHopEnabled = Toggles.BHopEnabled.Value
        togglehop()
    end)
    
    WalkHack:AddToggle("NoclipEnabled", {Text = "noclip", Default = femboyset.NoclipEnabled}):AddKeyPicker("NoclipKeyPicker", {Default = "V", SyncToggleState = true, Mode = "Toggle", Text = "noclip", NoUI = false}):OnChanged(function()
        femboyset.NoclipEnabled = Toggles.NoclipEnabled.Value
        togglenoclip()
    end)
end

local ExploitBOX = MiscTab:AddRightTabbox("exploits") do
    local Exploit = ExploitBOX:AddTab("exploits")
    
    Exploit:AddToggle("AntiKick", {Text = "anti kick", Default = femboyset.AntiKick}):OnChanged(function()
        femboyset.AntiKick = Toggles.AntiKick.Value
    end)
    
    Exploit:AddToggle("AutoCollectHealth", {Text = "auto collect health", Default = femboyset.AutoCollectHealth}):OnChanged(function()
        femboyset.AutoCollectHealth = Toggles.AutoCollectHealth.Value
        toggleautocoletctc()
    end)
    
    Exploit:AddSlider("CollectRange", {
        Text = "collect range",
        Default = 25,
        Min = 10,
        Max = 100,
        Rounding = 1,
        Compact = false,
    }):OnChanged(function()
        femboyset.CollectRange = Options.CollectRange.Value
    end)
    
    Exploit:AddToggle("KillAll", {Text = "kill all", Default = femboyset.Killall}):OnChanged(function()
        femboyset.Killall = Toggles.KillAll.Value
    end)

    Exploit:AddToggle("GodMode", {Text = "god mode localplayer", Default = femboyset.GodMode}):OnChanged(function()
        femboyset.GodMode = Toggles.GodMode.Value
        togglegm()
    end)
    
    Exploit:AddToggle("GodModeAll", {Text = "god mode all", Default = femboyset.GodModeAll}):OnChanged(function()
        femboyset.GodModeAll = Toggles.GodModeAll.Value
        togglegmAll()
    end)

    Exploit:AddButton("spawn all skins", function()
        impoorgivemeskins()
    end)   
end

local chattagsbox = MiscTab:AddRightTabbox("chattagssss") do
    local chattagtab = chattagsbox:AddTab("chat tags")
    
    chattagtab:AddDropdown("Tags", {
        AllowNull = false,
        Default = femboyset.CurrentTagText,
        Values = {"femboy.club", "yaica.agency", "Owner", "Admin", "Developer"}
    }):OnChanged(function()
        SelectedTag = Options.Tags.Value

        if SelectedTag == "femboy.club" then
            SelectedColor = Color3.fromRGB(255, 0, 255)
        elseif SelectedTag == "yaica.agency" then
            SelectedColor = Color3.fromRGB(0, 0, 0)
        elseif SelectedTag == "Owner" then
            SelectedColor = Color3.fromRGB(255, 0, 0)
        elseif SelectedTag == "Admin" then
            SelectedColor = Color3.fromRGB(255, 255, 255)
        elseif SelectedTag == "Developer" then
            SelectedColor = Color3.fromRGB(0, 0, 255)
        end
    end)

    chattagtab:AddButton("equip tag", function()
        odetzalupku()
    end)

    chattagtab:AddButton("remove tag", function()
        local args = {[1] = false, [2] = "", [3] = Color3.new(255, 255, 255), [4] = ""}
        pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("EquipTag"):FireServer(unpack(args))
            Library:Notify("tag removed", 3)
        end)
    end)
end

local CreateConfigurationBOX = ConfigsTab:AddLeftTabbox("create configuration") do 
    local Main = CreateConfigurationBOX:AddTab("create configuration")
    
    Main:AddInput("CreateConfigTextBox", {Default = "", Numeric = false, Finished = false, Text = "Create Configuration to Create", Placeholder = "File Name here"}):OnChanged(function()
        if Options.CreateConfigTextBox.Value and string.len(Options.CreateConfigTextBox.Value) ~= "" then 
            FileToSave = Options.CreateConfigTextBox.Value
        end
    end)
    
    Main:AddButton("create configuration file", function()
        if FileToSave ~= "" or FileToSave ~= nil then 
            UpdateFile(FileToSave)
        end
    end)
end

local debugg = ConfigsTab:AddLeftTabbox("debug") do 
    local Main = debugg:AddTab("debug")
    Main:AddButton("unload lib", function()
        Library:Unload()
    end)
end

local SaveConfigurationBOX = ConfigsTab:AddRightTabbox("save configuration") do 
    local Main = SaveConfigurationBOX:AddTab("save configuration")
    Main:AddDropdown("SaveConfigurationDropdown", {AllowNull = true, Values = GetFiles(), Text = "choose configuration to save"})
    Main:AddButton("save configuration", function()
        if Options.SaveConfigurationDropdown.Value then 
            UpdateFile(Options.SaveConfigurationDropdown.Value)
        end
    end)
end

local LoadConfigurationBOX = ConfigsTab:AddRightTabbox("Load Configuration") do 
    local Main = LoadConfigurationBOX:AddTab("Load Configuration")
    
    Main:AddDropdown("LoadConfigurationDropdown", {AllowNull = true, Values = GetFiles()})
    Main:AddButton("Load Configuration", function()
        if table.find(GetFiles(), Options.LoadConfigurationDropdown.Value) then
            LoadFile(Options.LoadConfigurationDropdown.Value)
            
            Toggles.TeamCheck:SetValue(femboyset.TeamCheck)
            Toggles.VisibleCheck:SetValue(femboyset.VisibleCheck)
            Options.TargetPart:SetValue(femboyset.TargetPart)
            Toggles.Visible:SetValue(femboyset.FOVVisible)
            Options.Radius:SetValue(femboyset.FOVRadius)
            Toggles.MousePosition:SetValue(femboyset.ShowSilentAimTarget)
            Options.HitChance:SetValue(femboyset.HitChance)
            Toggles.NoSpread:SetValue(femboyset.NoSpread)
            Toggles.NoRecoil:SetValue(femboyset.NoRecoil)
            Toggles.InfAmmo:SetValue(femboyset.InfAmmo)
            Toggles.RapidFire:SetValue(femboyset.RapidFire)
            Toggles.CustomGun:SetValue(femboyset.CustomGun)
            Toggles.CustomHands:SetValue(femboyset.CustomHands)
            Toggles.RemoveHands:SetValue(femboyset.RemoveHands)
            Toggles.AntiKick:SetValue(femboyset.AntiKick)
            Toggles.WalkEnabled:SetValue(femboyset.WalkEnabled)
            Options.WalkSpeed:SetValue(femboyset.WalkSpeed)
            Toggles.BHopEnabled:SetValue(femboyset.BHopEnabled)
            Toggles.NoclipEnabled:SetValue(femboyset.NoclipEnabled)
            Toggles.ESPEnabled:SetValue(femboyset.ESPEnabled)
            Toggles.BoxESP:SetValue(femboyset.BoxESP)
            Options.BoxColor:SetValue(femboyset.BoxColor)
            Toggles.NameESP:SetValue(femboyset.NameESP)
            Toggles.DistanceESP:SetValue(femboyset.DistanceESP)
            Toggles.ToolESP:SetValue(femboyset.ToolESP)
            Toggles.HealthBar:SetValue(femboyset.HealthBar)
            Toggles.HighlightESP:SetValue(femboyset.HighlightESP)
            Options.HighlightColor:SetValue(femboyset.HighlightColor)
            Toggles.ESPTeamCheck:SetValue(femboyset.ESPTeamCheck)
            Toggles.SpinBot:SetValue(femboyset.SpinBot)
            Options.SpinSpeed:SetValue(femboyset.SpinSpeed)
            Toggles.AutoCollectHealth:SetValue(femboyset.AutoCollectHealth)
            Toggles.KillAll:SetValue(femboyset.Killall)
            Options.CollectRange:SetValue(femboyset.CollectRange)
            Toggles.GodMode:SetValue(femboyset.GodMode)
            Toggles.GodModeAll:SetValue(femboyset.GodModeAll)
            Toggles.HitSoundEnabled:SetValue(femboyset.HitSoundEnabled)
            Options.HitSoundType:SetValue(femboyset.HitSoundType)
            Options.HitSoundVolume:SetValue(femboyset.HitSoundVolume)
            Toggles.DesyncEnabled:SetValue(femboyset.DesyncEnabled)
            Options.DesyncMode:SetValue(femboyset.DesyncMode)
            Options.RandomMin:SetValue(femboyset.RandomMin)
            Options.RandomMax:SetValue(femboyset.RandomMax)
            Options.RandomSpeed:SetValue(femboyset.RandomSpeed)
            Options.InvisibleY:SetValue(femboyset.InvisibleY)
            
            weaponsmodsapl()
            visualapply()
            toglewalkh()
            togglehop()
            togglenoclip()
            if femboyset.ESPEnabled then
                initiliazeesp()
            else
                for plr, _ in pairs(esp_data) do
                    removeesp(plr)
                end
            end
            togglespinbot()
            toggleautocoletctc()
            togglegm()
            togglegmAll()
            togglehitsouddns()
            toggledesync()
            if femboyset.DesyncEnabled then
                hookingdesync()
            end
        end
    end)
end

weapontrack()
visualtracking()
coroutine.wrap(infammolop)()
coroutine.wrap(antikicklolz)()
coroutine.wrap(visaullop)()

weaponsmodsapl()
visualapply()

resume(create(function()
    RenderStepped:Connect(function()
        if Toggles.MousePosition.Value and Toggles.aim_Enabled.Value then
            if getClosestPlayer() then 
                local Root = getClosestPlayer().Parent.PrimaryPart or getClosestPlayer()
                local RootToViewportPoint, IsOnScreen = WorldToViewportPoint(Camera, Root.Position)
                
                if IsOnScreen then
                    target_line.Visible = true
                    target_line.Color = Options.MouseVisualizeColor.Value
                    
                    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    target_line.From = screenCenter
                    target_line.To = Vector2.new(RootToViewportPoint.X, RootToViewportPoint.Y)
                else
                    target_line.Visible = false
                end
            else 
                target_line.Visible = false
            end
        else
            target_line.Visible = false
        end
        
        if Toggles.Visible.Value then 
            fov_circle.Visible = Toggles.Visible.Value
            fov_circle.Color = Options.Color.Value
            fov_circle.Position = getMousePosition()
        end
    end)
end))

resume(create(function()
    RenderStepped:Connect(function()
        if femboyset.Killall then
            some11aproveitbtw()
        end
    end)
end))

resume(create(function()
    RenderStepped:Connect(function()
        updesp()
    end)
end))

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
    local chance = calcchanger(femboyset.HitChance)
    if Toggles.aim_Enabled.Value and self == workspace and not checkcaller() and chance == true then
        if Method == "Raycast" then
            if ValidateArguments(Arguments, expectedargs.Raycast) then
                local A_Origin = Arguments[2]

                local HitPart = getClosestPlayer()
                if HitPart then
                    Arguments[3] = getDirection(A_Origin, HitPart.Position)

                    return oldNamecall(unpack(Arguments))
                end
            end
        end
    end
    return oldNamecall(...)
end))

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    randomoffseT = Vector3.new(0, 0, 0)
    randomTimer = 0
end)