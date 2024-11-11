local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Utility functions
local function createTween(object, info, properties)
    local tween = TweenService:Create(object, TweenInfo.new(info[1], info[2], info[3]), properties)
    return tween
end

function Library:CreateWindow(title)
    -- Main GUI Components
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local ElementsHolder = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    
    -- Properties
    GUI.Name = "DarkLibrary"
    GUI.Parent = game.CoreGui
    
    Main.Name = "Main"
    Main.Parent = GUI
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.Position = UDim2.new(0.5, -150, 0.5, -175)
    Main.Size = UDim2.new(0, 300, 0, 350)
    Main.Active = true
    Main.Draggable = true
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 8)
    Title.Size = UDim2.new(1, -20, 0, 20)
    Title.Font = Enum.Font.Gotham
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    
    ElementsHolder.Name = "ElementsHolder"
    ElementsHolder.Parent = Main
    ElementsHolder.BackgroundTransparency = 1
    ElementsHolder.Position = UDim2.new(0, 5, 0, 40)
    ElementsHolder.Size = UDim2.new(1, -10, 1, -45)
    ElementsHolder.ScrollBarThickness = 2
    ElementsHolder.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 45)
    
    UIListLayout.Parent = ElementsHolder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    local Window = {}
    
    function Window:AddButton(text, callback)
        local Button = Instance.new("TextButton")
        local ButtonUICorner = Instance.new("UICorner")
        
        Button.Name = "Button"
        Button.Parent = ElementsHolder
        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Font = Enum.Font.Gotham
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 13
        Button.AutoButtonColor = false
        
        ButtonUICorner.CornerRadius = UDim.new(0, 4)
        ButtonUICorner.Parent = Button
        
        Button.MouseEnter:Connect(function()
            createTween(Button, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            createTween(Button, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            }):Play()
        end)
        
        Button.MouseButton1Click:Connect(function()
            callback()
        end)
    end
    
    function Window:AddToggle(text, callback)
        local Toggle = Instance.new("TextButton")
        local ToggleUICorner = Instance.new("UICorner")
        local ToggleIndicator = Instance.new("Frame")
        local ToggleIndicatorCorner = Instance.new("UICorner")
        
        Toggle.Name = "Toggle"
        Toggle.Parent = ElementsHolder
        Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Toggle.Size = UDim2.new(1, 0, 0, 30)
        Toggle.Font = Enum.Font.Gotham
        Toggle.Text = text
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextSize = 13
        Toggle.AutoButtonColor = false
        
        ToggleUICorner.CornerRadius = UDim.new(0, 4)
        ToggleUICorner.Parent = Toggle
        
        ToggleIndicator.Name = "Indicator"
        ToggleIndicator.Parent = Toggle
        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
        ToggleIndicator.Position = UDim2.new(1, -35, 0.5, -8)
        ToggleIndicator.Size = UDim2.new(0, 25, 0, 16)
        
        ToggleIndicatorCorner.CornerRadius = UDim.new(0, 4)
        ToggleIndicatorCorner.Parent = ToggleIndicator
        
        local toggled = false
        
        Toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            callback(toggled)
            
            if toggled then
                createTween(ToggleIndicator, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundColor3 = Color3.fromRGB(65, 255, 65)
                }):Play()
            else
                createTween(ToggleIndicator, {0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out}, {
                    BackgroundColor3 = Color3.fromRGB(255, 65, 65)
                }):Play()
            end
        end)
    end
    
    function Window:AddTextbox(placeholder, callback)
        local Textbox = Instance.new("TextBox")
        local TextboxUICorner = Instance.new("UICorner")
        
        Textbox.Name = "Textbox"
        Textbox.Parent = ElementsHolder
        Textbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Textbox.Size = UDim2.new(1, 0, 0, 30)
        Textbox.Font = Enum.Font.Gotham
        Textbox.PlaceholderText = placeholder
        Textbox.Text = ""
        Textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
        Textbox.TextSize = 13
        Textbox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
        
        TextboxUICorner.CornerRadius = UDim.new(0, 4)
        TextboxUICorner.Parent = Textbox
        
        Textbox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(Textbox.Text)
            end
        end)
    end
    
    function Window:AddLabel(text)
        local Label = Instance.new("TextLabel")
        local LabelUICorner = Instance.new("UICorner")
        
        Label.Name = "Label"
        Label.Parent = ElementsHolder
        Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Label.Size = UDim2.new(1, 0, 0, 30)
        Label.Font = Enum.Font.Gotham
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 13
        
        LabelUICorner.CornerRadius = UDim.new(0, 4)
        LabelUICorner.Parent = Label
    end
    
    return Window
end

return Library
