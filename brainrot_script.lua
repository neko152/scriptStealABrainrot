-- Steal a BrainRot Script
local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local BrainRotModule = {}

function BrainRotModule:AutoFarm()
    while task.wait(0.1) do
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("brainrot") or obj.Name:lower():find("collect") then
                if obj:IsA("Part") and obj:FindFirstChild("TouchInterest") then
                    firetouchinterest(HumanoidRootPart, obj, 0)
                    task.wait(0.05)
                    firetouchinterest(HumanoidRootPart, obj, 1)
                end
            end
        end
        
        for _, enemy in pairs(workspace:GetDescendants()) do
            if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("Head") then
                if enemy:FindFirstChild("Team") and enemy.Team.Value ~= Player.Team then
                    local tool = Character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
        end
    end
end

function BrainRotModule:SpeedHack(speed)
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if Humanoid then
        Humanoid.WalkSpeed = speed or 50
    end
end

function BrainRotModule:NoClip()
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

function BrainRotModule:TeleportToObjective()
    local objective = workspace:FindFirstChild("BrainRotObjective") or workspace:FindFirstChild("Goal")
    if objective then
        HumanoidRootPart.CFrame = objective.CFrame + Vector3.new(0, 5, 0)
    end
end

local function ExecuteScript()
    BrainRotModule:SpeedHack(50)
    BrainRotModule:NoClip()
    BrainRotModule:AutoFarm()
    
    while task.wait(10) do
        BrainRotModule:TeleportToObjective()
    end
end

ExecuteScript()

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.Text = "BrainRot Script\nACTIVE"
TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
TextLabel.BackgroundTransparency = 1
