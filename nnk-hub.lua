-- NNK HUB FOR CỘNG ĐỒNG VIỆT NAM
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RunService = game:GetService("RunService")

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "NNK Cộng Đồng Việt Nam HUB",
    LoadingTitle = "NNK CDVN",
    LoadingSubtitle = "By nnk.suy"
})

local Main = Window:CreateTab("Main")
local Troll = Window:CreateTab("Troll")
local Visual = Window:CreateTab("Visual")
local Misc = Window:CreateTab("Misc")

----------------------------------------------------
-- SPEED
----------------------------------------------------
Main:CreateSlider({
    Name = "Speed",
    Range = {16, 200},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        Humanoid.WalkSpeed = v
    end,
})

----------------------------------------------------
-- JUMP
----------------------------------------------------
Main:CreateSlider({
    Name = "Jump Power",
    Range = {50, 500},
    Increment = 1,
    CurrentValue = 50,
    Callback = function(v)
        Humanoid.JumpPower = v
    end,
})

----------------------------------------------------
-- TELEPORT
----------------------------------------------------
Main:CreateDropdown({
    Name = "Teleport tới người chơi",
    Options = {},
    CurrentOption = {},
    Callback = function(targetName)
        local plr = Players[targetName]
        if plr and plr.Character then
            Character.HumanoidRootPart.CFrame =
                plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
        end
    end,
})

local function updatePlayers()
    local list = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(list, p.Name)
        end
    end
    Main:UpdateDropdown("Teleport tới người chơi", list)
end

Players.PlayerAdded:Connect(updatePlayers)
Players.PlayerRemoving:Connect(updatePlayers)
task.wait(1)
updatePlayers()

----------------------------------------------------
-- ESP
----------------------------------------------------
Visual:CreateToggle({
    Name = "ESP người chơi",
    CurrentValue = false,
    Callback = function(state)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                if state then
                    if not p.Character:FindFirstChild("Highlight") then
                        local hl = Instance.new("Highlight")
                        hl.FillTransparency = 1
                        hl.OutlineColor = Color3.fromRGB(255, 0, 0)
                        hl.Parent = p.Character
                    end
                else
                    if p.Character:FindFirstChild("Highlight") then
                        p.Character.Highlight:Destroy()
                    end
                end
            end
        end
    end
})

----------------------------------------------------
-- TROLL
----------------------------------------------------
Troll:CreateButton({
    Name = "Xoá map (client-side)",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
            end
        end
    end
})

Troll:CreateButton({
    Name = "Xoá đồ người chơi (client-side)",
    Callback = function()
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                for _, v in pairs(p.Character:GetChildren()) do
                    if v:IsA("Accessory") then
                        v:Destroy()
                    end
                end
            end
        end
    end
})

----------------------------------------------------
-- MISC
----------------------------------------------------
Misc:CreateSlider({
    Name = "FOV",
    Range = {70, 120},
    Increment = 1,
    CurrentValue = 70,
    Callback = function(v)
        workspace.CurrentCamera.FieldOfView = v
    end
})

Misc:CreateButton({
    Name = "Reset nhân vật",
    Callback = function()
        Character:BreakJoints()
    end
})
