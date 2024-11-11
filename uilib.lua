local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

function Library:CreateWindow(title)
    -- Main GUI Components
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local TopBarUICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local MinimizeBtn = Instance.new("TextButton")
    local ElementsHolder = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    
    -- Properties
    GUI.Name = "DarkLibrary"
    GUI.Parent = game.CoreGui
    
    Main.Name = "Main"
    Main.Parent = GUI
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Main.Position = UDim2.new(0.5, -100, 0.5, -125) -- Centered, thinner
    Main.Size = UDim2.new(0, 200, 0, 250) -- Thinner width
    Main.ClipsDescendants = true -- For smooth minimizing
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.Active = true
    
    TopBarUICorner.CornerRadius = UDim.new(0, 6)
    TopBarUICorner.Parent = TopBar
    
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 8, 0, 0)
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Font = Enum.Font.Gotham
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = TopBar
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(1, -25, 0, 0)
    MinimizeBtn.Size = UDim2.new(0, 25, 1, 0)
    MinimizeBtn.Font = Enum.Font.Gotham
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 16
    
    ElementsHolder.Name = "ElementsHolder"
    ElementsHolder.Parent = Main
    ElementsHolder.BackgroundTransparency = 1
    ElementsHolder.Position = UDim2.new(0, 5, 0, 35)
    ElementsHolder.Size = UDim2.new(1, -10, 1, -40)
    ElementsHolder.ScrollBarThickness = 2
    ElementsHolder.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 45)
    
    UIListLayout.Parent = ElementsHolder
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 4)
    
    -- Make TopBar draggable
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    TopBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Minimize functionality
    local minimized = false
    local originalSize = Main.Size

    MinimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        
        if minimized then
            TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 200, 0, 30)
            }):Play()
            MinimizeBtn.Text = "+"
        else
            TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = originalSize
            }):Play()
            MinimizeBtn.Text = "-"
        end
    end)
    
    local Window = {}
    
    function Window:AddButton(text, callback)
        local Button = Instance.new("TextButton")
        local ButtonUICorner = Instance.new("UICorner")
        
        Button.Name = "Button"
        Button.Parent = ElementsHolder
        Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Button.Size = UDim2.new(1, 0, 0, 25) -- Thinner height
        Button.Font = Enum.Font.Gotham
        Button.Text = text
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 12 -- Smaller text
        Button.AutoButtonColor = false
        
        ButtonUICorner.CornerRadius = UDim.new(0, 4)
        ButtonUICorner.Parent = Button
        
        Button.MouseEnter:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            TweenService:Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            }):Play()
        end)
        
        Button.MouseButton1Click:Connect(callback)
    end
    
    function Window:AddToggle(text, callback)
        local Toggle = Instance.new("TextButton")
        local ToggleUICorner = Instance.new("UICorner")
        local ToggleIndicator = Instance.new("Frame")
        local ToggleIndicatorCorner = Instance.new("UICorner")
        
        Toggle.Name = "Toggle"
        Toggle.Parent = ElementsHolder
        Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Toggle.Size = UDim2.new(1, 0, 0, 25) -- Thinner height
        Toggle.Font = Enum.Font.Gotham
        Toggle.Text = text
        Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.TextSize = 12 -- Smaller text
        Toggle.AutoButtonColor = false
        
        ToggleUICorner.CornerRadius = UDim.new(0, 4)
        ToggleUICorner.Parent = Toggle
        
        ToggleIndicator.Name = "Indicator"
        ToggleIndicator.Parent = Toggle
        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
        ToggleIndicator.Position = UDim2.new(1, -30, 0.5, -6)
        ToggleIndicator.Size = UDim2.new(0, 20, 0, 12) -- Smaller indicator
        
        ToggleIndicatorCorner.CornerRadius = UDim.new(0, 4)
        ToggleIndicatorCorner.Parent = ToggleIndicator
        
        local toggled = false
        
        Toggle.MouseButton1Click:Connect(function()
            toggled = not toggled
            callback(toggled)
            
            TweenService:Create(ToggleIndicator, TweenInfo.new(0.2), {
                BackgroundColor3 = toggled and Color3.fromRGB(65, 255, 65) or Color3.fromRGB(255, 65, 65)
            }):Play()
        end)
    end
    
    function Window:AddTextbox(placeholder, callback)
        local Textbox = Instance.new("TextBox")
        local TextboxUICorner = Instance.new("UICorner")
        
        Textbox.Name = "Textbox"
        Textbox.Parent = ElementsHolder
        Textbox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        Textbox.Size = UDim2.new(1, 0, 0, 25) -- Thinner height
        Textbox.Font = Enum.Font.Gotham
        Textbox.PlaceholderText = placeholder
        Textbox.Text = ""
        Textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
        Textbox.TextSize = 12 -- Smaller text
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
        Label.Size = UDim2.new(1, 0, 0, 25) -- Thinner height
        Label.Font = Enum.Font.Gotham
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 12 -- Smaller text
        
        LabelUICorner.CornerRadius = UDim.new(0, 4)
        LabelUICorner.Parent = Label
    end
    
    return Window
end

return Library 
