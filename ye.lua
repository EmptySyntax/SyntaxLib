local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

function Library:CreateWindow(title)
    -- Main GUI Components
    local GUI = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TopBar = Instance.new("Frame")
    local TopBarUICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local MinimizeBtn = Instance.new("TextButton")
    local CloseBtn = Instance.new("TextButton")
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
    Title.Size = UDim2.new(1, -75, 1, 0)
    Title.Font = Enum.Font.Gotham
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = TopBar
    MinimizeBtn.BackgroundTransparency = 1
    MinimizeBtn.Position = UDim2.new(1, -50, 0, 0)
    MinimizeBtn.Size = UDim2.new(0, 25, 1, 0)
    MinimizeBtn.Font = Enum.Font.Gotham
    MinimizeBtn.Text = "-"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 16
    
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = TopBar
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Position = UDim2.new(1, -25, 0, 0)
    CloseBtn.Size = UDim2.new(0, 25, 1, 0)
    CloseBtn.Font = Enum.Font.Gotham
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 16
    
    CloseBtn.MouseEnter:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 75, 75)
        }):Play()
    end)

    CloseBtn.MouseLeave:Connect(function()
        TweenService:Create(CloseBtn, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        if Window then
            Window:Hide()
        end
    end)
    
    ElementsHolder.Name = "ElementsHolder"
    ElementsHolder.Parent = Main
    ElementsHolder.BackgroundTransparency = 1
    ElementsHolder.Position = UDim2.new(0, 5, 0, 35)
    ElementsHolder.Size = UDim2.new(1, -10, 1, -40)
    ElementsHolder.ScrollBarThickness = 2
    ElementsHolder.ScrollBarImageColor3 = Color3.fromRGB(45, 45, 45)
    ElementsHolder.ScrollingEnabled = true
    ElementsHolder.ScrollingDirection = Enum.ScrollingDirection.Y
    ElementsHolder.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will auto-update
    ElementsHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y -- Auto adjusts canvas
    ElementsHolder.ElasticBehavior = Enum.ElasticBehavior.Always -- Smooth elastic scrolling
    
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
    
    local function Notify(title, text, duration)
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = duration or 5, -- Default duration of 5 seconds
            Icon = "rbxassetid://3944680095" -- You can change this to any icon you want
        })
    end

    local Window = {
        GUI = GUI,
        Visible = true,
        
        Hide = function(self)
            self.GUI.Enabled = false
            self.Visible = false
            -- Send notification when UI is hidden
            Notify("UI Hidden", "Press RightControl to show the UI again", 3)
        end,
        
        Show = function(self)
            self.GUI.Enabled = true
            self.Visible = true
            -- Optional: Notify when UI is shown
            Notify("UI Shown", "Welcome back!", 2)
        end,
        
        Toggle = function(self)
            self.Visible = not self.Visible
            self.GUI.Enabled = self.Visible
            if not self.Visible then
                Notify("UI Hidden", "Press RightControl to show the UI again", 3)
            end
        end,
        
        Notify = Notify
    }
    
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
        
        Button.MouseButton1Down:Connect(function()
            -- Button press effect
            TweenService:Create(Button, TweenInfo.new(0.1), {
                Size = UDim2.new(0.98, 0, 0, 23), -- Slightly smaller
                Position = UDim2.new(0.01, 0, 0, 1) -- Slightly offset
            }):Play()
        end)
        
        Button.MouseButton1Up:Connect(function()
            -- Restore button size
            TweenService:Create(Button, TweenInfo.new(0.1), {
                Size = UDim2.new(1, 0, 0, 25),
                Position = UDim2.new(0, 0, 0, 0)
            }):Play()
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
        
        Label.Name = "Label"
        Label.Parent = ElementsHolder
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.new(1, 0, 0, 25) -- Initial height
        Label.Font = Enum.Font.Gotham
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        Label.TextSize = 12
        Label.TextWrapped = true -- Enable text wrapping
        Label.AutomaticSize = Enum.AutomaticSize.Y -- Automatically adjust height based on content
        Label.TextXAlignment = Enum.TextXAlignment.Left -- Left align text
        Label.TextYAlignment = Enum.TextYAlignment.Top -- Top align text
        Label.RichText = true -- Enable rich text for better formatting
    end
    
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.RightControl then
            Window:Toggle()
        end
    end)

    Notify("UI Loaded", "Press RightControl to toggle the UI", 5)

    return Window
end

return Library 
