local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local SimpleUILibrary = {}

local function createRoundedFrame(name, parent, size, position, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = size
    frame.Position = position
    frame.BackgroundColor3 = backgroundColor
    frame.BorderSizePixel = 0
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame

    return frame
end

local function createLabel(text, parent, position)
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(1, -20, 0, 30)
    label.Position = position
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SourceSansBold
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 14
    label.Parent = parent
    return label
end

function SimpleUILibrary.createWindow(title, size)
    local gui = Instance.new("ScreenGui")
    gui.Name = "SimpleUILibrary"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = createRoundedFrame("MainFrame", gui, size or UDim2.new(0, 300, 0, 350), UDim2.new(0.5, -150, 0.5, -175), Color3.new(0.1, 0.1, 0.1))

    local titleBar = createRoundedFrame("TitleBar", mainFrame, UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), Color3.new(0.08, 0.08, 0.08))
    createLabel(title, titleBar, UDim2.new(0, 10, 0, 0))

    local contentFrame = createRoundedFrame("ContentFrame", mainFrame, UDim2.new(1, -20, 1, -40), UDim2.new(0, 10, 0, 35), Color3.new(0.15, 0.15, 0.15))

    -- Make the window draggable
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    return contentFrame
end

function SimpleUILibrary.createButton(parent, text, callback)
    local button = createRoundedFrame("Button", parent, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, #parent:GetChildren() * 40), Color3.new(0.2, 0.2, 0.2))
    createLabel(text, button, UDim2.new(0, 0, 0, 0))

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            callback()
        end
    end)

    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)}):Play()
    end)

    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)}):Play()
    end)

    return button
end

function SimpleUILibrary.createTextbox(parent, placeholderText, callback)
    local textbox = createRoundedFrame("Textbox", parent, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, #parent:GetChildren() * 40), Color3.new(0.2, 0.2, 0.2))

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -20, 1, 0)
    input.Position = UDim2.new(0, 10, 0, 0)
    input.BackgroundTransparency = 1
    input.Font = Enum.Font.SourceSans
    input.TextColor3 = Color3.new(1, 1, 1)
    input.TextSize = 14
    input.PlaceholderText = placeholderText
    input.Text = ""
    input.Parent = textbox

    input.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(input.Text)
        end
    end)

    return textbox
end

function SimpleUILibrary.createToggle(parent, text, callback)
    local toggle = createRoundedFrame("Toggle", parent, UDim2.new(1, -20, 0, 30), UDim2.new(0, 10, 0, #parent:GetChildren() * 40), Color3.new(0.2, 0.2, 0.2))
    createLabel(text, toggle, UDim2.new(0, 0, 0, 0))

    local toggleButton = createRoundedFrame("ToggleButton", toggle, UDim2.new(0, 40, 0, 20), UDim2.new(1, -50, 0.5, -10), Color3.new(0.3, 0.3, 0.3))
    local toggleIndicator = createRoundedFrame("ToggleIndicator", toggleButton, UDim2.new(0, 16, 0, 16), UDim2.new(0, 2, 0.5, -8), Color3.new(0.8, 0.8, 0.8))

    local toggled = false

    local function updateToggle()
        local targetPosition = toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        local targetColor = toggled and Color3.new(0, 0.7, 0) or Color3.new(0.3, 0.3, 0.3)

        TweenService:Create(toggleIndicator, TweenInfo.new(0.2), {Position = targetPosition}):Play()
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
    end

    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggled = not toggled
            updateToggle()
            callback(toggled)
        end
    end)

    return toggle
end

return SimpleUILibrary
