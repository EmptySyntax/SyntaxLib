local UILib = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Constants for styling
local COLORS = {
    Background = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(35, 35, 35),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(70, 70, 70),
    Enabled = Color3.fromRGB(0, 170, 255)
}

function UILib.new(title)
    -- Create main GUI elements
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Container = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    
    ScreenGui.Name = "UILibrary"
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = COLORS.Background
    Main.Position = UDim2.new(0.5, -150, 0.5, -125)
    Main.Size = UDim2.new(0, 300, 0, 250)
    Main.Active = true
    Main.Draggable = true
    
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 5)
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = title
    Title.TextColor3 = COLORS.Text
    Title.TextSize = 16
    
    Container.Name = "Container"
    Container.Parent = Main
    Container.BackgroundTransparency = 1
    Container.Position = UDim2.new(0, 5, 0, 40)
    Container.Size = UDim2.new(1, -10, 1, -45)
    Container.ScrollBarThickness = 2
    Container.ScrollBarImageColor3 = COLORS.Accent
    
    UIListLayout.Parent = Container
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    
    local lib = {}
    
    function lib:AddButton(text, callback)
        local Button = Instance.new("TextButton")
        local UICorner_2 = Instance.new("UICorner")
        
        Button.Name = "Button"
        Button.Parent = Container
        Button.BackgroundColor3 = COLORS.Secondary
        Button.Size = UDim2.new(1, 0, 0, 30)
        Button.Font = Enum.Font.Gotham
        Button.Text = text
        Button.TextColor3 = COLORS.Text
        Button.TextSize = 14
        Button.AutoButtonColor = false
        
        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = Button
        
        Button.MouseButton1Click:Connect(callback)
        
        return Button
    end
    
    function lib:AddTextbox(placeholder, callback)
        local Textbox = Instance.new("TextBox")
        local UICorner_2 = Instance.new("UICorner")
        
        Textbox.Name = "Textbox"
        Textbox.Parent = Container
        Textbox.BackgroundColor3 = COLORS.Secondary
        Textbox.Size = UDim2.new(1, 0, 0, 30)
        Textbox.Font = Enum.Font.Gotham
        Textbox.PlaceholderText = placeholder
        Textbox.Text = ""
        Textbox.TextColor3 = COLORS.Text
        Textbox.TextSize = 14
        Textbox.PlaceholderColor3 = COLORS.Accent
        
        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = Textbox
        
        Textbox.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                callback(Textbox.Text)
            end
        end)
        
        return Textbox
    end
    
    function lib:AddLabel(text)
        local Label = Instance.new("TextLabel")
        
        Label.Name = "Label"
        Label.Parent = Container
        Label.BackgroundTransparency = 1
        Label.Size = UDim2.new(1, 0, 0, 20)
        Label.Font = Enum.Font.Gotham
        Label.Text = text
        Label.TextColor3 = COLORS.Text
        Label.TextSize = 14
        
        return Label
    end
    
    function lib:AddToggle(text, callback)
        local Toggle = Instance.new("TextButton")
        local UICorner_2 = Instance.new("UICorner")
        local Status = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")
        
        Toggle.Name = "Toggle"
        Toggle.Parent = Container
        Toggle.BackgroundColor3 = COLORS.Secondary
        Toggle.Size = UDim2.new(1, 0, 0, 30)
        Toggle.Font = Enum.Font.Gotham
        Toggle.Text = text
        Toggle.TextColor3 = COLORS.Text
        Toggle.TextSize = 14
        Toggle.AutoButtonColor = false
        
        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = Toggle
        
        Status.Name = "Status"
        Status.Parent = Toggle
        Status.AnchorPoint = Vector2.new(1, 0.5)
        Status.BackgroundColor3 = COLORS.Accent
        Status.Position = UDim2.new(1, -5, 0.5, 0)
        Status.Size = UDim2.new(0, 20, 0, 20)
        
        UICorner_3.CornerRadius = UDim.new(0, 4)
        UICorner_3.Parent = Status
        
        local enabled = false
        Toggle.MouseButton1Click:Connect(function()
            enabled = not enabled
            Status.BackgroundColor3 = enabled and COLORS.Enabled or COLORS.Accent
            callback(enabled)
        end)
        
        return Toggle
    end
    
    return lib
end

return UILib
