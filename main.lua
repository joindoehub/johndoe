print(">>> JOHN DOE HUB v3 LOADING <<<") -- DEBUG: xác nhận file mới
-- ==========================================
-- 1. SERVICES
-- ==========================================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local CollectionService = game:GetService("CollectionService")

-- ==========================================
-- 2. PLAYER & CHARACTER
-- ==========================================
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui", 30)
if not PlayerGui then
    warn("[john doe hub] PlayerGui chưa sẵn sàng, đang retry UI...")
    PlayerGui = Player:WaitForChild("PlayerGui", 30)
end

local function ensureImmediateMenu()
    if not PlayerGui then return end
    if PlayerGui:FindFirstChild("JohnDoeImmediateUI") then return end

    local gui = Instance.new("ScreenGui")
    gui.Name = "JohnDoeImmediateUI"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 1000
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    gui.Parent = PlayerGui
    gui.Enabled = true

    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 620, 0, 310)
    main.Position = UDim2.new(0.5, -310, 0.5, -155)
    main.BackgroundColor3 = Color3.fromRGB(20, 11, 13)
    main.BorderSizePixel = 0
    main.Parent = gui

    local mainCorner = Instance.new("UICorner")
    mainCorner.CornerRadius = UDim.new(0, 18)
    mainCorner.Parent = main

    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = Color3.fromRGB(255, 90, 90)
    mainStroke.Thickness = 1.2
    mainStroke.Parent = main

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 64)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
    topBar.BorderSizePixel = 0
    topBar.Parent = main

    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 18)
    topCorner.Parent = topBar

    local logo = Instance.new("ImageLabel")
    logo.Size = UDim2.new(0, 30, 0, 30)
    logo.Position = UDim2.new(0, 16, 0, 17)
    logo.BackgroundTransparency = 1
    logo.Image = "rbxassetid://123613996022560"
    logo.ScaleType = Enum.ScaleType.Fit
    logo.Parent = topBar

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -200, 1, 0)
    title.Position = UDim2.new(0, 58, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "John Doe Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.TextColor3 = Color3.fromRGB(255, 110, 110)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topBar

    local version = Instance.new("TextLabel")
    version.Size = UDim2.new(0, 80, 0, 18)
    version.Position = UDim2.new(1, -140, 0, 24)
    version.BackgroundTransparency = 1
    version.Text = "BETA 3.0"
    version.Font = Enum.Font.GothamBold
    version.TextSize = 10
    version.TextColor3 = Color3.fromRGB(255, 190, 190)
    version.Parent = topBar

    local hideBtn = Instance.new("TextButton")
    hideBtn.Size = UDim2.new(0, 90, 0, 28)
    hideBtn.Position = UDim2.new(1, -102, 0.5, -14)
    hideBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    hideBtn.Text = "Hide"
    hideBtn.Font = Enum.Font.GothamBold
    hideBtn.TextSize = 12
    hideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    hideBtn.BorderSizePixel = 0
    hideBtn.Parent = topBar

    local hideCorner = Instance.new("UICorner")
    hideCorner.CornerRadius = UDim.new(0, 8)
    hideCorner.Parent = hideBtn

    hideBtn.MouseButton1Click:Connect(function()
        gui.Enabled = not gui.Enabled
    end)

    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(1, -20, 0, 36)
    tabBar.Position = UDim2.new(0, 10, 0, 72)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = main

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.FillDirection = Enum.FillDirection.Horizontal
    tabLayout.Padding = UDim.new(0, 8)
    tabLayout.Parent = tabBar

    local tabs = { "Main", "Sea", "Item", "Settings" }
    for i, name in ipairs(tabs) do
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(0, 120, 1, 0)
        tabBtn.BackgroundColor3 = i == 1 and Color3.fromRGB(255, 90, 90) or Color3.fromRGB(52, 18, 18)
        tabBtn.Text = name
        tabBtn.Font = Enum.Font.GothamBold
        tabBtn.TextSize = 11
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.BorderSizePixel = 0
        tabBtn.Parent = tabBar

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabBtn
    end

    local searchBox = Instance.new("TextBox")
    searchBox.Size = UDim2.new(0, 150, 0, 26)
    searchBox.Position = UDim2.new(1, -165, 0, 80)
    searchBox.BackgroundColor3 = Color3.fromRGB(48, 18, 18)
    searchBox.PlaceholderText = "Search"
    searchBox.Text = ""
    searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    searchBox.PlaceholderColor3 = Color3.fromRGB(180, 170, 170)
    searchBox.Font = Enum.Font.Gotham
    searchBox.TextSize = 12
    searchBox.BorderSizePixel = 0
    searchBox.Parent = main

    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 8)
    searchCorner.Parent = searchBox

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -122)
    content.Position = UDim2.new(0, 10, 0, 112)
    content.BackgroundColor3 = Color3.fromRGB(26, 14, 14)
    content.BorderSizePixel = 0
    content.Parent = main

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 14)
    contentCorner.Parent = content

    local leftPanel = Instance.new("Frame")
    leftPanel.Size = UDim2.new(0.62, -10, 1, -20)
    leftPanel.Position = UDim2.new(0, 10, 0, 10)
    leftPanel.BackgroundColor3 = Color3.fromRGB(34, 17, 17)
    leftPanel.BorderSizePixel = 0
    leftPanel.Parent = content

    local leftCorner = Instance.new("UICorner")
    leftCorner.CornerRadius = UDim.new(0, 12)
    leftCorner.Parent = leftPanel

    local leftStroke = Instance.new("UIStroke")
    leftStroke.Color = Color3.fromRGB(255, 90, 90)
    leftStroke.Thickness = 1
    leftStroke.Parent = leftPanel

    local leftTitle = Instance.new("TextLabel")
    leftTitle.Size = UDim2.new(1, -20, 0, 22)
    leftTitle.Position = UDim2.new(0, 12, 0, 8)
    leftTitle.BackgroundTransparency = 1
    leftTitle.Text = "Status"
    leftTitle.Font = Enum.Font.GothamBold
    leftTitle.TextSize = 13
    leftTitle.TextColor3 = Color3.fromRGB(255, 118, 118)
    leftTitle.TextXAlignment = Enum.TextXAlignment.Left
    leftTitle.Parent = leftPanel

    local function makeRow(text, color, yPos)
        local row = Instance.new("TextButton")
        row.Size = UDim2.new(1, -20, 0, 28)
        row.Position = UDim2.new(0, 10, 0, yPos)
        row.BackgroundColor3 = color
        row.Text = text
        row.Font = Enum.Font.GothamSemibold
        row.TextSize = 12
        row.TextColor3 = Color3.fromRGB(255, 255, 255)
        row.BorderSizePixel = 0
        row.Parent = leftPanel

        local rowCorner = Instance.new("UICorner")
        rowCorner.CornerRadius = UDim.new(0, 8)
        rowCorner.Parent = row

        return row
    end

    makeRow("[ON] Auto Farm", Color3.fromRGB(82, 24, 24), 36)
    makeRow("[OFF] Auto Quest", Color3.fromRGB(54, 22, 22), 70)
    makeRow("[OFF] No Clip", Color3.fromRGB(44, 18, 18), 104)

    local rightPanel = Instance.new("Frame")
    rightPanel.Size = UDim2.new(0.38, -10, 1, -20)
    rightPanel.Position = UDim2.new(0.62, 0, 0, 10)
    rightPanel.BackgroundColor3 = Color3.fromRGB(34, 17, 17)
    rightPanel.BorderSizePixel = 0
    rightPanel.Parent = content

    local rightCorner = Instance.new("UICorner")
    rightCorner.CornerRadius = UDim.new(0, 12)
    rightCorner.Parent = rightPanel

    local rightStroke = Instance.new("UIStroke")
    rightStroke.Color = Color3.fromRGB(255, 90, 90)
    rightStroke.Thickness = 1
    rightStroke.Parent = rightPanel

    local rightTitle = Instance.new("TextLabel")
    rightTitle.Size = UDim2.new(1, -20, 0, 22)
    rightTitle.Position = UDim2.new(0, 12, 0, 8)
    rightTitle.BackgroundTransparency = 1
    rightTitle.Text = "Quick" 
    rightTitle.Font = Enum.Font.GothamBold
    rightTitle.TextSize = 13
    rightTitle.TextColor3 = Color3.fromRGB(255, 120, 120)
    rightTitle.TextXAlignment = Enum.TextXAlignment.Left
    rightTitle.Parent = rightPanel

    local btns = {
        { "Farm", 26, Color3.fromRGB(170, 30, 30) },
        { "Mob", 64, Color3.fromRGB(100, 18, 18) },
        { "Teleport", 102, Color3.fromRGB(70, 24, 24) },
        { "Reset", 140, Color3.fromRGB(52, 18, 18) }
    }

    for _, item in ipairs(btns) do
        local name, yPos, color = item[1], item[2], item[3]
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 28)
        btn.Position = UDim2.new(0, 10, 0, yPos)
        btn.BackgroundColor3 = color
        btn.Text = name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BorderSizePixel = 0
        btn.Parent = rightPanel

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
    end
end


ensureImmediateMenu()

task.spawn(function()
    local remotes = ReplicatedStorage:WaitForChild("Remotes", 15)
    local commF = remotes and remotes:WaitForChild("CommF_", 15)
    if not commF then return end

    local deadline = os.clock() + 15
    while Player.Parent and not Player.Team and os.clock() < deadline do
        pcall(function()
            commF:InvokeServer("SetTeam", "Marines")
        end)
        task.wait(1)
    end
end)

local Character = Player.Character
local Humanoid = Character and Character:FindFirstChild("Humanoid")
local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
local Root = HumanoidRootPart

Player.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
    Root = HumanoidRootPart
end)

task.spawn(function()
    if not Character then
        Character = Player.CharacterAdded:Wait()
        Humanoid = Character:WaitForChild("Humanoid")
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        Root = HumanoidRootPart
    end
end)

-- ==========================================
-- 3. EXPLOIT CHECK & ALIASES
-- ==========================================
local executor = (getexecutorname and getexecutorname()) or (identifyexecutor and identifyexecutor())
if executor then
    print("[joindoe hub] Executor detected: " .. tostring(executor))
end

local ply = Players
local replicated = ReplicatedStorage
local RunSer = RunService
local vim1 = VirtualInputManager
local vim2 = VirtualUser
local TW = TweenService
local plr = Player
Root = HumanoidRootPart

-- ==========================================
-- 4. LOAD UI LIBRARY
-- ==========================================
local JohnDoeLogo = "rbxassetid://123613996022560"
local BananaLogo = "rbxassetid://88031262069243"

getgenv()._JohnDoeLib = nil

local function buildFallbackLibrary()
    local function makeWidget()
        local widget = { Callback = nil, Value = nil }
        function widget:OnChanged(fn)
            if type(fn) == "function" then self.Callback = fn end
            return self
        end
        function widget:SetValue(v) self.Value = v; return self end
        function widget:GetValue() return self.Value end
        return widget
    end

    local function createLabel(parent, text, size, pos, textColor, textSize)
        local label = Instance.new("TextLabel")
        label.BackgroundTransparency = 1
        label.Text = tostring(text)
        label.Size = size
        label.Position = pos
        label.Font = Enum.Font.GothamSemibold
        label.TextSize = textSize or 13
        label.TextColor3 = textColor or Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        return label
    end

    local function makeCorner(obj, radius)
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, radius or 12)
        corner.Parent = obj
        return corner
    end

    local function makeStroke(obj, color, thickness)
        local stroke = Instance.new("UIStroke")
        stroke.Color = color or Color3.fromRGB(255, 80, 80)
        stroke.Thickness = thickness or 1
        stroke.Transparency = 0.15
        stroke.Parent = obj
        return stroke
    end

    local function createButton(parent, text, size, pos, callback)
        local button = Instance.new("TextButton")
        button.Size = size
        button.Position = pos
        button.BackgroundColor3 = Color3.fromRGB(46, 18, 18)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.GothamSemibold
        button.TextSize = 13
        button.Text = tostring(text)
        button.AutoButtonColor = false
        button.BorderSizePixel = 0
        button.Parent = parent
        makeCorner(button, 10)
        makeStroke(button, Color3.fromRGB(255, 72, 72), 1)

        local defaultColor = button.BackgroundColor3
        local hoverColor = Color3.fromRGB(73, 23, 23)
        local pressColor = Color3.fromRGB(255, 66, 66)

        button.MouseEnter:Connect(function()
            if button.Active then
                button.BackgroundColor3 = hoverColor
            end
        end)
        button.MouseLeave:Connect(function()
            if button.Active then
                button.BackgroundColor3 = defaultColor
            end
        end)
        button.MouseButton1Down:Connect(function()
            button.BackgroundColor3 = pressColor
        end)
        button.MouseButton1Up:Connect(function()
            button.BackgroundColor3 = hoverColor
        end)

        if callback then button.MouseButton1Click:Connect(callback) end
        return button
    end

    local function createGroup(parent, name)
        local group = {}
        local frame = Instance.new("Frame")
        frame.Name = name or "Group"
        frame.Size = UDim2.new(1, 0, 0, 0)
        frame.AutomaticSize = Enum.AutomaticSize.Y
        frame.BackgroundColor3 = Color3.fromRGB(28, 15, 15)
        frame.BorderSizePixel = 0
        frame.Parent = parent
        makeCorner(frame, 14)
        makeStroke(frame, Color3.fromRGB(255, 72, 72), 1)

        local title = createLabel(frame, name or "", UDim2.new(1, -20, 0, 24), UDim2.new(0, 12, 0, 9), Color3.fromRGB(255, 96, 96), 13)
        if not name or name == "" or name == " " then title.Visible = false end

        local list = Instance.new("UIListLayout")
        list.Padding = UDim.new(0, 8)
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Parent = frame

        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 10)
        padding.PaddingRight = UDim.new(0, 10)
        padding.Parent = frame

        function group:AddToggle(id, setting)
            local widget = makeWidget()
            local toggle = createButton(frame, tostring(id or "Toggle"), UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), function()
                local enabled = not (widget.Value == true)
                widget.Value = enabled
                if widget.Callback then widget.Callback(enabled) end
                toggle.Text = (enabled and "[ON] " or "[OFF] ") .. tostring(id or "Toggle")
                toggle.BackgroundColor3 = enabled and Color3.fromRGB(76, 28, 28) or Color3.fromRGB(46, 18, 18)
            end)
            widget.Value = setting and setting.Default == true
            toggle.Text = (widget.Value and "[ON] " or "[OFF] ") .. tostring(id or "Toggle")
            toggle.BackgroundColor3 = widget.Value and Color3.fromRGB(76, 28, 28) or Color3.fromRGB(46, 18, 18)
            return widget
        end

        function group:AddButton(setting, cb)
            local widget = makeWidget()
            local label = type(setting) == "string" and setting or (setting and (setting.Title or setting.Text) or "Button")
            local btn = createButton(frame, tostring(label), UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), function()
                if widget.Callback then widget.Callback()
                elseif type(cb) == "function" then cb() end
            end)
            if type(setting) == "table" and type(setting.Callback) == "function" then
                widget:OnChanged(setting.Callback)
            elseif type(cb) == "function" then
                widget:OnChanged(cb)
            end
            return widget
        end

        function group:AddDropdown(id, setting)
            local widget = makeWidget()
            widget.Value = setting and setting.Default or "Select"
            local label = createLabel(frame, tostring(id or "Dropdown") .. " : " .. tostring(widget.Value), UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0), Color3.fromRGB(245, 245, 245), 12)
            widget.Label = label
            return widget
        end

        function group:AddSlider(id, setting)
            local widget = makeWidget()
            widget.Value = setting and setting.Default or 0
            local label = createLabel(frame, tostring((setting and setting.Title) or id or "Slider") .. " : " .. tostring(widget.Value), UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0), Color3.fromRGB(245, 245, 245), 12)
            widget.Label = label
            return widget
        end

        function group:AddInput(id, setting)
            local widget = makeWidget()
            local input = Instance.new("TextBox")
            input.Size = UDim2.new(1, 0, 0, 30)
            input.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            input.TextColor3 = Color3.fromRGB(255, 255, 255)
            input.PlaceholderText = tostring(id or "Input")
            input.Font = Enum.Font.Gotham
            input.TextSize = 14
            input.BorderSizePixel = 0
            input.Parent = frame
            makeCorner(input, 10)
            makeStroke(input, Color3.fromRGB(255, 80, 80), 1)
            widget.Value = setting and setting.Default or ""
            input.Text = tostring(widget.Value)
            input.FocusLost:Connect(function(enterPressed)
                if enterPressed then
                    widget.Value = input.Text
                    if widget.Callback then widget.Callback(input.Text) end
                end
            end)
            return widget
        end

        function group:AddParagraph(setting)
            local txt = setting and (setting.Title or setting.Description or setting.Text or "") or ""
            local label = createLabel(frame, tostring(txt), UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0), Color3.fromRGB(220, 220, 220), 12)
            label.TextWrapped = true
            label.TextSize = 12
            label.TextYAlignment = Enum.TextYAlignment.Top
            return { Label = label, SetDesc = function(_, d) label.Text = tostring(d) end }
        end

        function group:AddLabel(text)
            local label = createLabel(frame, tostring(text), UDim2.new(1, 0, 0, 24), UDim2.new(0, 0, 0, 0), Color3.fromRGB(255, 255, 255), 12)
            return { Label = label, SetText = function(_, t) label.Text = tostring(t) end }
        end

        return group
    end

    local lib = {}
    lib.Notify = function(_, info)
        if not info or not PlayerGui then return end
        local notify = Instance.new("TextLabel")
        notify.Size = UDim2.new(0, 260, 0, 52)
        notify.Position = UDim2.new(0.5, -130, 0.05, 0)
        notify.BackgroundColor3 = Color3.fromRGB(32, 12, 12)
        notify.TextColor3 = Color3.fromRGB(255, 255, 255)
        notify.Text = tostring(info.Title or "john doe") .. "\n" .. tostring(info.Description or "")
        notify.Font = Enum.Font.GothamBold
        notify.TextSize = 13
        notify.TextWrapped = true
        notify.BorderSizePixel = 0
        notify.Parent = PlayerGui
        makeCorner(notify, 12)
        makeStroke(notify, Color3.fromRGB(255, 72, 72), 1)
        task.delay(info.Duration or 3, function() if notify and notify.Parent then notify:Destroy() end end)
    end

    lib.CreateWindow = function(_, opts)
        if not PlayerGui then
            warn("[john doe hub] Không thể tạo UI vì PlayerGui chưa sẵn sàng.")
            return nil
        end

        local gui = Instance.new("ScreenGui")
        gui.Name = "JohnDoeRedUI"
        gui.ResetOnSpawn = false
        gui.IgnoreGuiInset = true
        gui.DisplayOrder = 999
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = PlayerGui

        local openBtn = Instance.new("TextButton")
        openBtn.Name = "OpenMenuButton"
        openBtn.Size = UDim2.new(0, 140, 0, 36)
        openBtn.Position = UDim2.new(0, 18, 0.5, -18)
        openBtn.BackgroundColor3 = Color3.fromRGB(170, 20, 20)
        openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        openBtn.Text = tostring(opts and opts.Title or "John Doe")
        openBtn.Font = Enum.Font.GothamBold
        openBtn.TextSize = 12
        openBtn.AutoButtonColor = false
        openBtn.BorderSizePixel = 0
        openBtn.Parent = gui
        makeCorner(openBtn, 12)
        makeStroke(openBtn, Color3.fromRGB(255, 96, 96), 1)

        local bg = Instance.new("Frame")
        bg.Name = "Main"
        bg.Size = UDim2.new(0, 500, 0, 300)
        bg.Position = UDim2.new(0.5, -250, 0.5, -150)
        bg.BackgroundColor3 = Color3.fromRGB(17, 9, 9)
        bg.BorderSizePixel = 0
        bg.Visible = true
        bg.Parent = gui
        makeCorner(bg, 18)
        makeStroke(bg, Color3.fromRGB(255, 70, 70), 1)

        local header = Instance.new("Frame")
        header.Name = "Header"
        header.Size = UDim2.new(1, 0, 0, 46)
        header.BackgroundColor3 = Color3.fromRGB(38, 12, 12)
        header.BorderSizePixel = 0
        header.Parent = bg
        makeCorner(header, 18)

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -110, 1, 0)
        title.Position = UDim2.new(0, 15, 0, 0)
        title.BackgroundTransparency = 1
        title.Font = Enum.Font.GothamBold
        title.TextSize = 18
        title.TextColor3 = Color3.fromRGB(255, 75, 75)
        title.Text = tostring(opts and opts.Title or "john doe RED")
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = header

        local tabBar = Instance.new("ScrollingFrame")
        tabBar.Size = UDim2.new(1, -20, 0, 34)
        tabBar.Position = UDim2.new(0, 10, 0, 54)
        tabBar.BackgroundTransparency = 1
        tabBar.ScrollBarThickness = 0
        tabBar.Parent = bg

        local tabLayout = Instance.new("UIListLayout")
        tabLayout.FillDirection = Enum.FillDirection.Horizontal
        tabLayout.Padding = UDim.new(0, 8)
        tabLayout.Parent = tabBar

        local pageHolder = Instance.new("Frame")
        pageHolder.Size = UDim2.new(1, -18, 1, -90)
        pageHolder.Position = UDim2.new(0, 9, 0, 90)
        pageHolder.BackgroundTransparency = 1
        pageHolder.Parent = bg

        local tabs = {}
        local activePage = nil

        local function addGroup(parent, label)
            local group = Instance.new("Frame")
            group.Size = UDim2.new(1, 0, 0, 90)
            group.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
            group.BorderSizePixel = 0
            group.Parent = parent
            makeCorner(group, 12)
            makeStroke(group, Color3.fromRGB(255, 92, 92), 1)

            local titleLabel = Instance.new("TextLabel")
            titleLabel.Size = UDim2.new(1, -20, 0, 24)
            titleLabel.Position = UDim2.new(0, 10, 0, 8)
            titleLabel.BackgroundTransparency = 1
            titleLabel.Font = Enum.Font.GothamBold
            titleLabel.TextSize = 12
            titleLabel.TextColor3 = Color3.fromRGB(255, 120, 120)
            titleLabel.Text = tostring(label or "Group")
            titleLabel.TextXAlignment = Enum.TextXAlignment.Left
            titleLabel.Parent = group

            local list = Instance.new("UIListLayout")
            list.Padding = UDim.new(0, 7)
            list.Parent = group

            local pad = Instance.new("UIPadding")
            pad.PaddingLeft = UDim.new(0, 12)
            pad.PaddingRight = UDim.new(0, 12)
            pad.PaddingTop = UDim.new(0, 34)
            pad.PaddingBottom = UDim.new(0, 10)
            pad.Parent = group

            local obj = {}
            function obj:AddToggle(id, setting)
                local enabled = (setting and setting.Default == true) or false
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.BackgroundColor3 = enabled and Color3.fromRGB(70, 24, 24) or Color3.fromRGB(44, 18, 18)
                btn.BorderSizePixel = 0
                btn.Font = Enum.Font.GothamSemibold
                btn.TextSize = 12
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = (enabled and "[ON] " or "[OFF] ") .. tostring(id or "Toggle")
                btn.Parent = group
                makeCorner(btn, 8)
                local cb = setting and setting.Callback
                btn.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    btn.Text = (enabled and "[ON] " or "[OFF] ") .. tostring(id or "Toggle")
                    btn.BackgroundColor3 = enabled and Color3.fromRGB(70, 24, 24) or Color3.fromRGB(44, 18, 18)
                    if cb then pcall(cb, enabled) end
                end)
                return { OnChanged = function(_, fn) cb = fn end, SetValue = function(_, v) enabled = not not v; btn.Text = (enabled and "[ON] " or "[OFF] ") .. tostring(id or "Toggle"); btn.BackgroundColor3 = enabled and Color3.fromRGB(70, 24, 24) or Color3.fromRGB(44, 18, 18) end, GetValue = function() return enabled end }
            end
            function obj:AddButton(setting, cb)
                local label = type(setting) == "string" and setting or (setting and (setting.Text or setting.Title or setting.Name) or "Button")
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.BackgroundColor3 = Color3.fromRGB(46, 18, 18)
                btn.BorderSizePixel = 0
                btn.Font = Enum.Font.GothamSemibold
                btn.TextSize = 12
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = tostring(label)
                btn.Parent = group
                makeCorner(btn, 8)
                if type(cb) == "function" then btn.MouseButton1Click:Connect(cb) end
                if type(setting) == "table" and type(setting.Callback) == "function" then btn.MouseButton1Click:Connect(setting.Callback) end
                return { OnChanged = function(_, fn) if type(fn) == "function" then btn.MouseButton1Click:Connect(fn) end end }
            end
            function obj:AddLabel(text)
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 18)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.Gotham
                label.TextSize = 12
                label.TextColor3 = Color3.fromRGB(230, 230, 230)
                label.Text = tostring(text or "")
                label.Parent = group
                return { SetText = function(_, v) label.Text = tostring(v) end }
            end
            function obj:AddDropdown(id, setting)
                local value = setting and setting.Default or "Select"
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.BackgroundColor3 = Color3.fromRGB(36, 16, 16)
                btn.BorderSizePixel = 0
                btn.Font = Enum.Font.GothamSemibold
                btn.TextSize = 12
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = tostring(id or "Dropdown") .. ": " .. tostring(value)
                btn.Parent = group
                makeCorner(btn, 8)
                return { SetValue = function(_, v) value = v; btn.Text = tostring(id or "Dropdown") .. ": " .. tostring(value) end, GetValue = function() return value end }
            end
            function obj:AddSlider(id, setting)
                local value = setting and setting.Default or 0
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 18)
                label.BackgroundTransparency = 1
                label.Font = Enum.Font.Gotham
                label.TextSize = 12
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.Text = tostring(id or "Slider") .. ": " .. tostring(value)
                label.Parent = group
                return { SetValue = function(_, v) value = v; label.Text = tostring(id or "Slider") .. ": " .. tostring(value) end, GetValue = function() return value end }
            end
            function obj:AddInput(id, setting)
                local box = Instance.new("TextBox")
                box.Size = UDim2.new(1, 0, 0, 28)
                box.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                box.BorderSizePixel = 0
                box.Font = Enum.Font.Gotham
                box.TextSize = 12
                box.TextColor3 = Color3.fromRGB(255, 255, 255)
                box.PlaceholderText = tostring(id or "Input")
                box.Text = tostring(setting and setting.Default or "")
                box.Parent = group
                makeCorner(box, 8)
                return { SetValue = function(_, v) box.Text = tostring(v) end, GetValue = function() return box.Text end }
            end
            return obj
        end

        local function createTabData(tabData)
            local name = type(tabData) == "table" and (tabData[1] or tabData.Name or tabData[2]) or tostring(tabData)
            local page = Instance.new("Frame")
            page.Name = tostring(name)
            page.Size = UDim2.new(1, 0, 1, 0)
            page.BackgroundTransparency = 1
            page.Visible = false
            page.Parent = pageHolder

            local list = Instance.new("UIListLayout")
            list.Padding = UDim.new(0, 10)
            list.Parent = page

            local pad = Instance.new("UIPadding")
            pad.PaddingTop = UDim.new(0, 10)
            pad.PaddingLeft = UDim.new(0, 10)
            pad.PaddingRight = UDim.new(0, 10)
            pad.PaddingBottom = UDim.new(0, 10)
            pad.Parent = page

            local tabObj = {}
            function tabObj:AddLeftGroupbox(label) return addGroup(page, label) end
            function tabObj:AddRightGroupbox(label) return addGroup(page, label) end
            function tabObj:AddSection(label) return addGroup(page, label) end

            local tabButton = Instance.new("TextButton")
            tabButton.Size = UDim2.new(0, 110, 1, 0)
            tabButton.BackgroundColor3 = Color3.fromRGB(52, 18, 18)
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.Font = Enum.Font.GothamBold
            tabButton.TextSize = 11
            tabButton.Text = tostring(name)
            tabButton.BorderSizePixel = 0
            tabButton.Parent = tabBar
            makeCorner(tabButton, 8)
            tabButton.MouseButton1Click:Connect(function()
                for _, other in ipairs(tabBar:GetChildren()) do
                    if other:IsA("TextButton") then other.BackgroundColor3 = Color3.fromRGB(52, 18, 18) end
                end
                tabButton.BackgroundColor3 = Color3.fromRGB(255, 66, 66)
                for _, otherPage in ipairs(pageHolder:GetChildren()) do
                    if otherPage:IsA("Frame") then otherPage.Visible = (otherPage == page) end
                end
                activePage = page
            end)
            table.insert(tabs, { Button = tabButton, Page = page, Name = tostring(name) })

            if not activePage then
                activePage = page
                page.Visible = true
                tabButton.BackgroundColor3 = Color3.fromRGB(255, 66, 66)
            end
            return tabObj
        end

        openBtn.MouseButton1Click:Connect(function() bg.Visible = not bg.Visible end)

        local window = {}
        function window:MakeTab(tabData) return createTabData(tabData) end
        function window:AddTab(tabData) return createTabData(tabData) end
        return window
    end

    return lib
end

local function safeMakeCorner(obj, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 12)
    corner.Parent = obj
    return corner
end

local function safeMakeStroke(obj, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 80, 80)
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.15
    stroke.Parent = obj
    return stroke
end

Library = buildFallbackLibrary()

if not Library or not Library.CreateWindow then
    warn("[john doe hub] Không thể khởi tạo UI vì library nội bộ không hợp lệ.")
    local fallbackGui = Instance.new("ScreenGui")
    fallbackGui.Name = "JohnDoeEmergencyUI"
    fallbackGui.ResetOnSpawn = false
    fallbackGui.IgnoreGuiInset = true
    fallbackGui.DisplayOrder = 999
    fallbackGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    fallbackGui.Parent = PlayerGui

    local fallbackMain = Instance.new("Frame")
    fallbackMain.Name = "Main"
    fallbackMain.Size = UDim2.new(0, 260, 0, 120)
    fallbackMain.Position = UDim2.new(0.5, -130, 0.5, -60)
    fallbackMain.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
    fallbackMain.BorderSizePixel = 0
    fallbackMain.Parent = fallbackGui
    safeMakeCorner(fallbackMain, 14)
    safeMakeStroke(fallbackMain, Color3.fromRGB(255, 80, 80), 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, -20)
    label.Position = UDim2.new(0, 10, 0, 10)
    label.BackgroundTransparency = 1
    label.Text = "John Doe Hub\nUI failed to load\nPlease re-execute script."
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextWrapped = true
    label.Parent = fallbackMain
    Window = {
        MakeTab = function() return { AddLeftGroupbox = function() return {} end, AddSection = function() return {} end } end,
        AddTab = function() return { AddLeftGroupbox = function() return {} end, AddSection = function() return {} end } end,
    }
else
    if getgenv().UIColor then
        getgenv().UIColor["Logo Image"] = JohnDoeLogo
        getgenv().UIColor["Main Color"] = Color3.fromRGB(255, 40, 40)
    end

    local okCreate, createdWindow = pcall(function()
        return Library:CreateWindow({
            Title = "John Doe Hub - Red Edition",
            Desc = "- Blox Fruit",
            Image = JohnDoeLogo
        })
    end)

    if not okCreate or not createdWindow then
        warn("[john doe hub] CreateWindow trả về nil. Dùng UI tối giản nội bộ.")
        Window = {
            MakeTab = function() return { AddLeftGroupbox = function() return {} end, AddSection = function() return {} end } end,
            AddTab = function() return { AddLeftGroupbox = function() return {} end, AddSection = function() return {} end } end,
        }
    else
        Window = createdWindow
    end
end

if not Window then
    warn("[john doe hub] Không thể khởi tạo UI dù đã dùng fallback. Script dừng ở đây.")
    return
end

-- ==========================================
-- PROXY WRAPPER CHO CÁC PHẦN TỬ UI
-- ==========================================
local function makeProxy(obj, callbackHolder)
    local proxy = {}
    setmetatable(proxy, {
        __index = function(_, k)
            if k == "OnChanged" then
                return function(_, fn)
                    callbackHolder.extra = fn
                    return proxy
                end
            end
            if k == "SetStage" and obj and obj.SetStage then
                return function(_, v) pcall(obj.SetStage, v) end
            end
            if k == "SetValue" then
                return function(_, v)
                    if obj and obj.SetValue then
                        local ok = pcall(obj.SetValue, v)
                        if not ok then pcall(function() obj:SetValue(v) end) end
                    end
                end
            end
            if k == "GetValue" then
                return function(_)
                    if obj and obj.GetValue then
                        local ok, val = pcall(obj.GetValue)
                        if ok then return val end
                        local ok2, val2 = pcall(function() return obj:GetValue() end)
                        return val2
                    end
                end
            end
            if k == "SetText" or k == "SetDesc" then
                return function(_, t)
                    if obj and obj.SetText then pcall(obj.SetText, obj, t)
                    elseif obj and obj.SetDesc then pcall(obj.SetDesc, obj, t) end
                end
            end
            if k == "GetNewList" then
                return function(_, list)
                    if obj and obj.GetNewList then pcall(obj.GetNewList, obj, list) end
                end
            end
            if k == "ClearText" then
                return function(_, v)
                    if obj and obj.ClearText then pcall(obj.ClearText, obj, v) end
                end
            end
            local v = type(obj) == "table" and obj[k]
            if type(v) == "function" then
                return function(_, ...) return pcall(v, obj, ...) end
            end
            return v
        end
    })
    return proxy
end

local function wrapTab(rawTab)
    if not rawTab then return {} end
    local _currentSection = nil
    local _nextIsRight = false

    local function ensureSection()
        if not _currentSection then
            if rawTab.AddLeftGroupbox then
                _currentSection = rawTab:AddLeftGroupbox("")
            elseif rawTab.AddSection then
                _currentSection = rawTab:AddSection("")
            else
                _currentSection = rawTab
            end
        end
    end

    local wrapped = {}

    function wrapped:AddSection(name)
        local secName = (not name or name == " " or name == "") and "" or name
        if rawTab.AddLeftGroupbox and rawTab.AddRightGroupbox then
            if _nextIsRight then
                _currentSection = rawTab:AddRightGroupbox(secName)
                _nextIsRight = false
            else
                _currentSection = rawTab:AddLeftGroupbox(secName)
                _nextIsRight = true
            end
        elseif rawTab.AddSection then
            _currentSection = rawTab:AddSection(secName)
        else
            _currentSection = rawTab
        end
        return _currentSection
    end

    function wrapped:AddToggle(id, setting)
        ensureSection()
        setting = setting or {}
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        local obj = _currentSection:AddToggle(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddButton(setting, cb)
        ensureSection()
        local proxy = _currentSection:AddButton(setting, cb)
        if proxy then
            local holder = {}
            return makeProxy(proxy, holder)
        end
    end

    function wrapped:AddDropdown(id, setting)
        ensureSection()
        setting = setting or {}
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        local obj = _currentSection:AddDropdown(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddSlider(id, setting)
        ensureSection()
        setting = setting or {}
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        local obj = _currentSection:AddSlider(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddInput(id, setting)
        ensureSection()
        setting = setting or {}
        local holder = { extra = nil }
        local origCb = setting.Callback or setting["Callback"]
        setting.Callback = function(v)
            if origCb then pcall(origCb, v) end
            if holder.extra then pcall(holder.extra, v) end
        end
        setting["Callback"] = setting.Callback
        local obj = _currentSection:AddInput(id, setting)
        return makeProxy(obj, holder)
    end

    function wrapped:AddParagraph(setting)
        ensureSection()
        setting = setting or {}
        local title = setting.Title or setting["Title"] or ""
        local desc  = setting.Description or setting["Description"] or setting.Desc or ""
        local txt   = desc ~= "" and (title .. "\n" .. desc) or title
        local obj = _currentSection:AddLabel and _currentSection:AddLabel(txt) or (_currentSection.AddParagraph and _currentSection:AddParagraph(setting))
        local holder = {}
        return makeProxy(obj, holder)
    end

    function wrapped:AddLabel(text)
        ensureSection()
        local obj = _currentSection:AddLabel(text)
        local holder = {}
        return makeProxy(obj, holder)
    end

    return wrapped
end

-- ==========================================
-- 5. KHAI BÁO TABS VỚI GIAO DIỆN MỚI
-- ==========================================
local createTabFn = function(tabData)
    if Window.MakeTab then
        return Window:MakeTab(tabData)
    elseif Window.AddTab then
        local name = type(tabData) == "table" and tabData[1] or tostring(tabData)
        return Window:AddTab(name)
    end
end

local Tabs = {
    ["Info"]     = wrapTab(createTabFn({"Thông Tin", "info"})),
    ["Main"]     = wrapTab(createTabFn({"Cày Cấp", "home"})),
    ["Sea"]      = wrapTab(createTabFn({"Sự Kiện", "globe"})),
    ["Item"]     = wrapTab(createTabFn({"Lấy & Nâng Cấp Vật Phẩm", "sword"})),
    ["Setting"]  = wrapTab(createTabFn({"Cài Đặt", "settings"})),
    ["Status"]   = wrapTab(createTabFn({"Webhook", "bell"})),
    ["Stats"]    = wrapTab(createTabFn({"Chỉ Số", "bar-chart-2"})),
    ["Player"]   = wrapTab(createTabFn({"Người Chơi", "user"})),
    ["Teleport"] = wrapTab(createTabFn({"Dịch Chuyển", "map-pin"})),
    ["Visual"]   = wrapTab(createTabFn({"Giả Mạo", "eye"})),
    ["Fruit"]    = wrapTab(createTabFn({"Trái Ác Quỷ", "apple"})),
    ["Raid"]     = wrapTab(createTabFn({"Đột Kích", "zap"})),
    ["Race"]     = wrapTab(createTabFn({"Nâng Cấp Chủng Tộc", "shield"})),
    ["Shop"]     = wrapTab(createTabFn({"Cửa Hàng", "shopping-cart"})),
    ["Misc"]     = wrapTab(createTabFn({"Khác", "grid"})),
}

-- Đổi logo & theme màu đỏ sang John Doe
task.spawn(function()
    local watchedLogos = setmetatable({}, { __mode = "k" })

    local function patchImage(desc)
        if watchedLogos[desc] then return end
        watchedLogos[desc] = true
        desc.Image = JohnDoeLogo
        desc:GetPropertyChangedSignal("Image"):Connect(function()
            if desc.Parent and desc.Image ~= JohnDoeLogo then
                desc.Image = JohnDoeLogo
            end
        end)
    end

    local function scanDescendants(container)
        if not container then return end
        for _, desc in ipairs(container:GetDescendants()) do
            pcall(function()
                if (desc:IsA("ImageLabel") or desc:IsA("ImageButton")) then
                    if desc.Image == BananaLogo or desc.Name == "icon" or desc.Name == "Ruafimg" then
                        patchImage(desc)
                    end
                end
                if desc:IsA("TextLabel") and desc.Text:lower():find("banana") then
                    desc.Text = "john doe"
                    desc.TextColor3 = Color3.fromRGB(255, 42, 42)
                end
            end)
        end
    end

    local connectedGuis = {}
    local function watchGui(gui)
        if not gui or connectedGuis[gui] then return end
        connectedGuis[gui] = true
        scanDescendants(gui)
        gui.DescendantAdded:Connect(function(desc)
            task.wait()
            pcall(function()
                if (desc:IsA("ImageLabel") or desc:IsA("ImageButton")) then
                    if desc.Image == BananaLogo or desc.Name == "icon" or desc.Name == "Ruafimg" then
                        patchImage(desc)
                    end
                end
                if desc:IsA("TextLabel") and desc.Text:lower():find("banana") then
                    desc.Text = "john doe"
                    desc.TextColor3 = Color3.fromRGB(255, 42, 42)
                end
            end)
        end)
    end

    local guiNames = {"Banana_Hub", "Ziner hub GUI", "HDanh Hub", "joindoe hub", "BananaToggleGui", "JohnDoeRedUI"}
    local coreGui = game:GetService("CoreGui")

    for attempt = 1, 10 do
        for _, name in ipairs(guiNames) do
            pcall(function() local g = coreGui:FindFirstChild(name); if g then watchGui(g) end end)
            pcall(function() local g = PlayerGui:FindFirstChild(name); if g then watchGui(g) end end)
            pcall(function() if gethui then local g = gethui():FindFirstChild(name); if g then watchGui(g) end end end)
        end
        task.wait(0.5)
    end
end)

task.wait(1)

Library:Notify({
    Title = "john doe RED",
    Description = "Giao diện màu đỏ đã được khởi tạo thành công!",
    Duration = 4
})

-- Anti AFK
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait()
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

-- ==========================================
-- SEA FLAGS
-- ==========================================
local placeId = game.PlaceId
Sea1 = (placeId == 2753915549)
Sea2 = (placeId == 4442272183)
Sea3 = (placeId == 7449423635)

if not (Sea1 or Sea2 or Sea3) then
    local currentLevel = 1
    pcall(function() currentLevel = game.Players.LocalPlayer.Data.Level.Value end)
    if currentLevel < 700 then Sea1 = true elseif currentLevel < 1500 then Sea2 = true else Sea3 = true end
end

SelectMonster = SelectMonster or ""

local function getPlayerRoot()
    local player = game.Players.LocalPlayer
    local char = player and player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    return player, char, root
end

local function safeRemoteInvoke(remotePath, method, ...)
    local remotes = ReplicatedStorage and ReplicatedStorage:FindFirstChild("Remotes")
    if not remotes then return false end
    local remote = remotes:FindFirstChild(remotePath)
    if not remote then return false end
    local ok, result = pcall(function()
        return remote:InvokeServer(method, ...)
    end)
    return ok, result
end

function CheckLevel()
    local player, char, root = getPlayerRoot()
    if not player or not char or not root then return end

    local v7 = player.Data and player.Data.Level and player.Data.Level.Value or 1
    local selected = tostring(SelectMonster or "")

    if Sea1 then
        if (v7 >= 1 and v7 <= 9) or selected == "Bandit" then
            Ms = "Bandit"; NameQuest = "BanditQuest1"; QuestLv = 1; NameMon = "Bandit"
            CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
            CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
        elseif (v7 >= 10 and v7 <= 14) or selected == "Monkey" then
            Ms = "Monkey"; NameQuest = "JungleQuest"; QuestLv = 1; NameMon = "Monkey"
            CFrameQ = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(- 1448.1446533203, 50.851993560791, 63.60718536377)
        elseif (v7 >= 15 and v7 <= 29) or selected == "Gorilla" then
            Ms = "Gorilla"; NameQuest = "JungleQuest"; QuestLv = 2; NameMon = "Gorilla"
            CFrameQ = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102)
            CFrameMon = CFrame.new(- 1142.6488037109, 40.462348937988, - 515.39227294922)
        elseif (v7 >= 30 and v7 <= 39) or selected == "Pirate" then
            Ms = "Pirate"; NameQuest = "BuggyQuest1"; QuestLv = 1; NameMon = "Pirate"
            CFrameQ = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(- 1201.0881347656, 40.628940582275, 3857.5966796875)
        elseif (v7 >= 40 and v7 <= 59) or selected == "Brute" then
            Ms = "Brute"; NameQuest = "BuggyQuest1"; QuestLv = 2; NameMon = "Brute"
            CFrameQ = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188)
            CFrameMon = CFrame.new(- 1387.5324707031, 24.592035293579, 4100.9575195313)
        elseif (v7 >= 60 and v7 <= 74) or selected == "Desert Bandit" then
            Ms = "Desert Bandit"; NameQuest = "DesertQuest"; QuestLv = 1; NameMon = "Desert Bandit"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
        elseif (v7 >= 75 and v7 <= 89) or selected == "Desert Officer" then
            Ms = "Desert Officer"; NameQuest = "DesertQuest"; QuestLv = 2; NameMon = "Desert Officer"
            CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
            CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
        elseif (v7 >= 90 and v7 <= 99) or selected == "Snow Bandit" then
            Ms = "Snow Bandit"; NameQuest = "SnowQuest"; QuestLv = 1; NameMon = "Snow Bandit"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
            CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, - 1328.2418212891)
        elseif (v7 >= 100 and v7 <= 119) or selected == "Snowman" then
            Ms = "Snowman"; NameQuest = "SnowQuest"; QuestLv = 2; NameMon = "Snowman"
            CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156)
            CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, - 1488.0262451172)
        elseif (v7 >= 120 and v7 <= 149) or selected == "Chief Petty Officer" then
            Ms = "Chief Petty Officer"; NameQuest = "MarineQuest2"; QuestLv = 1; NameMon = "Chief Petty Officer"
            CFrameQ = CFrame.new(- 5035.49609375, 28.677835464478, 4324.1840820313)
            CFrameMon = CFrame.new(- 4931.1552734375, 65.793113708496, 4121.8393554688)
        elseif (v7 >= 150 and v7 <= 174) or selected == "Sky Bandit" then
            Ms = "Sky Bandit"; NameQuest = "SkyQuest"; QuestLv = 1; NameMon = "Sky Bandit"
            CFrameQ = CFrame.new(- 4842.1372070313, 717.69543457031, - 2623.0483398438)
            CFrameMon = CFrame.new(- 4955.6411132813, 365.46365356445, - 2908.1865234375)
        elseif (v7 >= 175 and v7 <= 189) or selected == "Dark Master" then
            Ms = "Dark Master"; NameQuest = "SkyQuest"; QuestLv = 2; NameMon = "Dark Master"
            CFrameQ = CFrame.new(- 4842.1372070313, 717.69543457031, - 2623.0483398438)
            CFrameMon = CFrame.new(- 5148.1650390625, 439.04571533203, - 2332.9611816406)
        elseif (v7 >= 190 and v7 <= 209) or selected == "Prisoner" then
            Ms = "Prisoner"; NameQuest = "PrisonerQuest"; QuestLv = 1; NameMon = "Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594)
            CFrameMon = CFrame.new(4937.31885, 0.332031399, 649.574524)
        elseif (v7 >= 210 and v7 <= 249) or selected == "Dangerous Prisoner" then
            Ms = "Dangerous Prisoner"; NameQuest = "PrisonerQuest"; QuestLv = 2; NameMon = "Dangerous Prisoner"
            CFrameQ = CFrame.new(5310.60547, 0.350014925, 474.946594)
            CFrameMon = CFrame.new(5099.6626, 0.351562679, 1055.7583)
        elseif (v7 >= 250 and v7 <= 274) or selected == "Toga Warrior" then
            Ms = "Toga Warrior"; NameQuest = "ColosseumQuest"; QuestLv = 1; NameMon = "Toga Warrior"
            CFrameQ = CFrame.new(- 1577.7890625, 7.4151420593262, - 2984.4838867188)
            CFrameMon = CFrame.new(- 1872.5166015625, 49.080215454102, - 2913.810546875)
        elseif (v7 >= 275 and v7 <= 299) or selected == "Gladiator" then
            Ms = "Gladiator"; NameQuest = "ColosseumQuest"; QuestLv = 2; NameMon = "Gladiator"
            CFrameQ = CFrame.new(- 1577.7890625, 7.4151420593262, - 2984.4838867188)
            CFrameMon = CFrame.new(- 1521.3740234375, 81.203170776367, - 3066.3139648438)
        elseif (v7 >= 300 and v7 <= 324) or selected == "Military Soldier" then
            Ms = "Military Soldier"; NameQuest = "MagmaQuest"; QuestLv = 1; NameMon = "Military Soldier"
            CFrameQ = CFrame.new(- 5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(- 5369.0004882813, 61.24352645874, 8556.4921875)
        elseif (v7 >= 325 and v7 <= 374) or selected == "Military Spy" then
            Ms = "Military Spy"; NameQuest = "MagmaQuest"; QuestLv = 2; NameMon = "Military Spy"
            CFrameQ = CFrame.new(- 5316.1157226563, 12.262831687927, 8517.00390625)
            CFrameMon = CFrame.new(- 5787.00293, 75.8262634, 8651.69922)
        elseif (v7 >= 375 and v7 <= 399) or selected == "Fishman Warrior" then
            Ms = "Fishman Warrior"; NameQuest = "FishmanQuest"; QuestLv = 1; NameMon = "Fishman Warrior"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 3000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif (v7 >= 400 and v7 <= 449) or selected == "Fishman Commando" then
            Ms = "Fishman Commando"; NameQuest = "FishmanQuest"; QuestLv = 2; NameMon = "Fishman Commando"
            CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
            CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 3000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
            end
        elseif (v7 >= 450 and v7 <= 474) or selected == "God's Guard" then
            Ms = "God's Guard"; NameQuest = "SkyExp1Quest"; QuestLv = 1; NameMon = "God's Guard"
            CFrameQ = CFrame.new(- 4721.8603515625, 845.30297851563, - 1953.8489990234)
            CFrameMon = CFrame.new(- 4628.0498046875, 866.92877197266, - 1931.2352294922)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 3000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688))
            end
        elseif (v7 >= 475 and v7 <= 524) or selected == "Shanda" then
            Ms = "Shanda"; NameQuest = "SkyExp1Quest"; QuestLv = 2; NameMon = "Shanda"
            CFrameQ = CFrame.new(- 7863.1596679688, 5545.5190429688, - 378.42266845703)
            CFrameMon = CFrame.new(- 7685.1474609375, 5601.0751953125, - 441.38876342773)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 3000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047))
            end
        elseif (v7 >= 525 and v7 <= 549) or selected == "Royal Squad" then
            Ms = "Royal Squad"; NameQuest = "SkyExp2Quest"; QuestLv = 1; NameMon = "Royal Squad"
            CFrameQ = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
            CFrameMon = CFrame.new(- 7654.2514648438, 5637.1079101563, - 1407.7550048828)
        elseif (v7 >= 550 and v7 <= 624) or selected == "Royal Soldier" then
            Ms = "Royal Soldier"; NameQuest = "SkyExp2Quest"; QuestLv = 2; NameMon = "Royal Soldier"
            CFrameQ = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125)
            CFrameMon = CFrame.new(- 7760.4106445313, 5679.9077148438, - 1884.8112792969)
        elseif (v7 >= 625 and v7 <= 649) or selected == "Galley Pirate" then
            Ms = "Galley Pirate"; NameQuest = "FountainQuest"; QuestLv = 1; NameMon = "Galley Pirate"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
        elseif v7 >= 650 or selected == "Galley Captain" then
            Ms = "Galley Captain"; NameQuest = "FountainQuest"; QuestLv = 2; NameMon = "Galley Captain"
            CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
            CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
        end
    end

    if Sea2 then
        if (v7 >= 700 and v7 <= 724) or selected == "Raider" then
            Ms = "Raider"; NameQuest = "Area1Quest"; QuestLv = 1; NameMon = "Raider"
            CFrameQ = CFrame.new(- 427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
        elseif (v7 >= 725 and v7 <= 774) or selected == "Mercenary" then
            Ms = "Mercenary"; NameQuest = "Area1Quest"; QuestLv = 2; NameMon = "Mercenary"
            CFrameQ = CFrame.new(- 427.72567749023, 72.99634552002, 1835.9426269531)
            CFrameMon = CFrame.new(- 864.85009765625, 122.47104644775, 1453.1505126953)
        elseif (v7 >= 775 and v7 <= 799) or selected == "Swan Pirate" then
            Ms = "Swan Pirate"; NameQuest = "Area2Quest"; QuestLv = 1; NameMon = "Swan Pirate"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
        elseif (v7 >= 800 and v7 <= 874) or selected == "Factory Staff" then
            Ms = "Factory Staff"; NameQuest = "Area2Quest"; QuestLv = 2; NameMon = "Factory Staff"
            CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
            CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
        elseif (v7 >= 875 and v7 <= 899) or selected == "Marine Lieutenant" then
            Ms = "Marine Lieutenant"; NameQuest = "MarineQuest3"; QuestLv = 1; NameMon = "Marine Lieutenant"
            CFrameQ = CFrame.new(- 2440.9934082031, 73.04190826416, - 3217.7082519531)
            CFrameMon = CFrame.new(- 2489.2622070313, 84.613594055176, - 3151.8830566406)
        elseif (v7 >= 900 and v7 <= 949) or selected == "Marine Captain" then
            Ms = "Marine Captain"; NameQuest = "MarineQuest3"; QuestLv = 2; NameMon = "Marine Captain"
            CFrameQ = CFrame.new(- 2440.9934082031, 73.04190826416, - 3217.7082519531)
            CFrameMon = CFrame.new(- 2335.2026367188, 79.786659240723, - 3245.8674316406)
        elseif (v7 >= 950 and v7 <= 974) or selected == "Zombie" then
            Ms = "Zombie"; NameQuest = "ZombieQuest"; QuestLv = 1; NameMon = "Zombie"
            CFrameQ = CFrame.new(- 5494.3413085938, 48.505931854248, - 794.59094238281)
            CFrameMon = CFrame.new(- 5536.4970703125, 101.08577728271, - 835.59075927734)
        elseif (v7 >= 975 and v7 <= 999) or selected == "Vampire" then
            Ms = "Vampire"; NameQuest = "ZombieQuest"; QuestLv = 2; NameMon = "Vampire"
            CFrameQ = CFrame.new(- 5494.3413085938, 48.505931854248, - 794.59094238281)
            CFrameMon = CFrame.new(- 5806.1098632813, 16.722528457642, - 1164.4384765625)
        elseif (v7 >= 1000 and v7 <= 1049) or selected == "Snow Trooper" then
            Ms = "Snow Trooper"; NameQuest = "SnowMountainQuest"; QuestLv = 1; NameMon = "Snow Trooper"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, - 5370.5546875)
            CFrameMon = CFrame.new(535.21051025391, 432.74209594727, - 5484.9165039063)
        elseif (v7 >= 1050 and v7 <= 1099) or selected == "Winter Warrior" then
            Ms = "Winter Warrior"; NameQuest = "SnowMountainQuest"; QuestLv = 2; NameMon = "Winter Warrior"
            CFrameQ = CFrame.new(607.05963134766, 401.44781494141, - 5370.5546875)
            CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, - 5174.130859375)
        elseif (v7 >= 1100 and v7 <= 1124) or selected == "Lab Subordinate" then
            Ms = "Lab Subordinate"; NameQuest = "IceSideQuest"; QuestLv = 1; NameMon = "Lab Subordinate"
            CFrameQ = CFrame.new(- 6061.841796875, 15.926671981812, - 4902.0385742188)
            CFrameMon = CFrame.new(- 5720.5576171875, 63.309471130371, - 4784.6103515625)
        elseif (v7 >= 1125 and v7 <= 1174) or selected == "Horned Warrior" then
            Ms = "Horned Warrior"; NameQuest = "IceSideQuest"; QuestLv = 2; NameMon = "Horned Warrior"
            CFrameQ = CFrame.new(- 6061.841796875, 15.926671981812, - 4902.0385742188)
            CFrameMon = CFrame.new(- 6292.751953125, 91.181983947754, - 5502.6499023438)
        elseif (v7 >= 1175 and v7 <= 1199) or selected == "Magma Ninja" then
            Ms = "Magma Ninja"; NameQuest = "FireSideQuest"; QuestLv = 1; NameMon = "Magma Ninja"
            CFrameQ = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
            CFrameMon = CFrame.new(- 5461.8388671875, 130.36347961426, - 5836.4702148438)
        elseif (v7 >= 1200 and v7 <= 1249) or selected == "Lava Pirate" then
            Ms = "Lava Pirate"; NameQuest = "FireSideQuest"; QuestLv = 2; NameMon = "Lava Pirate"
            CFrameQ = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813)
            CFrameMon = CFrame.new(- 5251.1889648438, 55.164535522461, - 4774.4096679688)
        elseif (v7 >= 1250 and v7 <= 1274) or selected == "Ship Deckhand" then
            Ms = "Ship Deckhand"; NameQuest = "ShipQuest1"; QuestLv = 1; NameMon = "Ship Deckhand"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 20000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif (v7 >= 1275 and v7 <= 1299) or selected == "Ship Engineer" then
            Ms = "Ship Engineer"; NameQuest = "ShipQuest1"; QuestLv = 2; NameMon = "Ship Engineer"
            CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
            CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 20000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif (v7 >= 1300 and v7 <= 1324) or selected == "Ship Steward" then
            Ms = "Ship Steward"; NameQuest = "ShipQuest2"; QuestLv = 1; NameMon = "Ship Steward"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 20000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif (v7 >= 1325 and v7 <= 1349) or selected == "Ship Officer" then
            Ms = "Ship Officer"; NameQuest = "ShipQuest2"; QuestLv = 2; NameMon = "Ship Officer"
            CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
            CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 20000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
            end
        elseif (v7 >= 1350 and v7 <= 1374) or selected == "Arctic Warrior" then
            Ms = "Arctic Warrior"; NameQuest = "FrostQuest"; QuestLv = 1; NameMon = "Arctic Warrior"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, - 6484.6005859375)
            CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, - 6472.7568359375)
            if _G.AutoLevel and root and (CFrameMon.Position - root.Position).Magnitude > 20000 then
                safeRemoteInvoke("CommF_", "requestEntrance", Vector3.new(- 6508.5581054688, 89.034996032715, - 132.83953857422))
            end
        elseif (v7 >= 1375 and v7 <= 1424) or selected == "Snow Lurker" then
            Ms = "Snow Lurker"; NameQuest = "FrostQuest"; QuestLv = 2; NameMon = "Snow Lurker"
            CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, - 6484.6005859375)
            CFrameMon = CFrame.new(5628.482421875, 57.574996948242, - 6618.3481445313)
        elseif (v7 >= 1425 and v7 <= 1449) or selected == "Sea Soldier" then
            Ms = "Sea Soldier"; NameQuest = "ForgottenQuest"; QuestLv = 1; NameMon = "Sea Soldier"
            CFrameQ = CFrame.new(- 3054.5827636719, 236.87213134766, - 10147.790039063)
            CFrameMon = CFrame.new(- 3185.0153808594, 58.789089202881, - 9663.6064453125)
        elseif v7 >= 1450 or selected == "Water Fighter" then
            Ms = "Water Fighter"; NameQuest = "ForgottenQuest"; QuestLv = 2; NameMon = "Water Fighter"
            CFrameQ = CFrame.new(- 3054.5827636719, 236.87213134766, - 10147.790039063)
            CFrameMon = CFrame.new(- 3262.9301757813, 298.69036865234, - 10552.529296875)
        end
    end

    if Sea3 then
        if (v7 >= 1500 and v7 <= 1524) or selected == "Pirate Millionaire" then
            Ms = "Pirate Millionaire"; NameQuest = "PiratePortQuest"; QuestLv = 1; NameMon = "Pirate Millionaire"
            CFrameQ = CFrame.new(- 450.1046447753906, 107.68145751953125, 5950.72607421875)
            CFrameMon = CFrame.new(- 193.99227905273438, 56.12502670288086, 5755.7880859375)
        elseif (v7 >= 1525 and v7 <= 1574) or selected == "Pistol Billionaire" then
            Ms = "Pistol Billionaire"; NameQuest = "PiratePortQuest"; QuestLv = 2; NameMon = "Pistol Billionaire"
            CFrameQ = CFrame.new(- 450.1046447753906, 107.68145751953125, 5950.72607421875)
            CFrameMon = CFrame.new(- 188.14462280273438, 84.49613189697266, 6337.0419921875)
        elseif (v7 >= 1575 and v7 <= 1599) or selected == "Dragon Crew Warrior" then
            Ms = "Dragon Crew Warrior"; NameQuest = "DragonCrewQuest"; QuestLv = 1; NameMon = "Dragon Crew Warrior"
            CFrameQ = CFrame.new(6735.11083984375, 126.99046325683594, - 711.0979614257812)
            CFrameMon = CFrame.new(6615.2333984375, 50.847679138183594, - 978.93408203125)
        elseif (v7 >= 1600 and v7 <= 1624) or selected == "Dragon Crew Archer" then
            Ms = "Dragon Crew Archer"; NameQuest = "DragonCrewQuest"; QuestLv = 2; NameMon = "Dragon Crew Archer"
            CFrameQ = CFrame.new(6735.11083984375, 126.99046325683594, - 711.0979614257812)
            CFrameMon = CFrame.new(6818.58935546875, 483.718994140625, 512.726806640625)
        elseif (v7 >= 1625 and v7 <= 1649) or selected == "Hydra Enforcer" then
            Ms = "Hydra Enforcer"; NameQuest = "VenomCrewQuest"; QuestLv = 1; NameMon = "Hydra Enforcer"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4547.115234375, 1001.60205078125, 334.1954650878906)
        elseif (v7 >= 1650 and v7 <= 1699) or selected == "Venomous Assailant" then
            Ms = "Venomous Assailant"; NameQuest = "VenomCrewQuest"; QuestLv = 2; NameMon = "Venomous Assailant"
            CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
            CFrameMon = CFrame.new(4637.88525390625, 1077.85595703125, 882.4183959960938)
        elseif (v7 >= 1700 and v7 <= 1724) or selected == "Marine Commodore" then
            Ms = "Marine Commodore"; NameQuest = "MarineTreeIsland"; QuestLv = 1; NameMon = "Marine Commodore"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, - 6740.0551757813)
            CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, - 7109.5043945313)
        elseif (v7 >= 1725 and v7 <= 1774) or selected == "Marine Rear Admiral" then
            Ms = "Marine Rear Admiral"; NameQuest = "MarineTreeIsland"; QuestLv = 2; NameMon = "Marine Rear Admiral"
            CFrameQ = CFrame.new(2179.98828125, 28.731239318848, - 6740.0551757813)
            CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, - 7048.6342773438)
        elseif (v7 >= 1775 and v7 <= 1799) or selected == "Fishman Raider" then
            Ms = "Fishman Raider"; NameQuest = "DeepForestIsland3"; QuestLv = 1; NameMon = "Fishman Raider"
            CFrameQ = CFrame.new(- 10582.759765625, 331.78845214844, - 8757.666015625)
            CFrameMon = CFrame.new(- 10553.268554688, 521.38439941406, - 8176.9458007813)
        elseif (v7 >= 1800 and v7 <= 1824) or selected == "Fishman Captain" then
            Ms = "Fishman Captain"; NameQuest = "DeepForestIsland3"; QuestLv = 2; NameMon = "Fishman Captain"
            CFrameQ = CFrame.new(- 10583.099609375, 331.78845214844, - 8759.4638671875)
            CFrameMon = CFrame.new(- 10789.401367188, 427.18637084961, - 9131.4423828125)
        elseif (v7 >= 1825 and v7 <= 1849) or selected == "Forest Pirate" then
            Ms = "Forest Pirate"; NameQuest = "DeepForestIsland"; QuestLv = 1; NameMon = "Forest Pirate"
            CFrameQ = CFrame.new(- 13232.662109375, 332.40396118164, - 7626.4819335938)
            CFrameMon = CFrame.new(- 13489.397460938, 400.30349731445, - 7770.251953125)
        elseif (v7 >= 1850 and v7 <= 1899) or selected == "Mythological Pirate" then
            Ms = "Mythological Pirate"; NameQuest = "DeepForestIsland"; QuestLv = 2; NameMon = "Mythological Pirate"
            CFrameQ = CFrame.new(- 13232.662109375, 332.40396118164, - 7626.4819335938)
            CFrameMon = CFrame.new(- 13508.616210938, 582.46228027344, - 6985.3037109375)
        elseif (v7 >= 1900 and v7 <= 1924) or selected == "Jungle Pirate" then
            Ms = "Jungle Pirate"; NameQuest = "DeepForestIsland2"; QuestLv = 1; NameMon = "Jungle Pirate"
            CFrameQ = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
            CFrameMon = CFrame.new(- 12267.103515625, 459.75262451172, - 10277.200195313)
        elseif (v7 >= 1925 and v7 <= 1974) or selected == "Musketeer Pirate" then
            Ms = "Musketeer Pirate"; NameQuest = "DeepForestIsland2"; QuestLv = 2; NameMon = "Musketeer Pirate"
            CFrameQ = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375)
            CFrameMon = CFrame.new(- 13291.5078125, 520.47338867188, - 9904.638671875)
        elseif (v7 >= 1975 and v7 <= 1999) or selected == "Reborn Skeleton" then
            Ms = "Reborn Skeleton"; NameQuest = "HauntedQuest1"; QuestLv = 1; NameMon = "Reborn Skeleton"
            CFrameQ = CFrame.new(- 9480.80762, 142.130661, 5566.37305)
            CFrameMon = CFrame.new(- 8761.77148, 183.431747, 6168.33301)
        elseif (v7 >= 2000 and v7 <= 2024) or selected == "Living Zombie" then
            Ms = "Living Zombie"; NameQuest = "HauntedQuest1"; QuestLv = 2; NameMon = "Living Zombie"
            CFrameQ = CFrame.new(- 9480.80762, 142.130661, 5566.37305)
            CFrameMon = CFrame.new(- 10103.7529, 238.565979, 6179.75977)
        elseif (v7 >= 2025 and v7 <= 2049) or selected == "Demonic Soul" then
            Ms = "Demonic Soul"; NameQuest = "HauntedQuest2"; QuestLv = 1; NameMon = "Demonic Soul"
            CFrameQ = CFrame.new(- 9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(- 9712.03125, 204.69589233398, 6193.322265625)
        elseif (v7 >= 2050 and v7 <= 2074) or selected == "Posessed Mummy" then
            Ms = "Posessed Mummy"; NameQuest = "HauntedQuest2"; QuestLv = 2; NameMon = "Posessed Mummy"
            CFrameQ = CFrame.new(- 9516.9931640625, 178.00651550293, 6078.4653320313)
            CFrameMon = CFrame.new(- 9545.7763671875, 69.619895935059, 6339.5615234375)
        elseif (v7 >= 2075 and v7 <= 2099) or selected == "Peanut Scout" then
            Ms = "Peanut Scout"; NameQuest = "NutsIslandQuest"; QuestLv = 1; NameMon = "Peanut Scout"
            CFrameQ = CFrame.new(- 2105.53198, 37.2495995, - 10195.5088)
            CFrameMon = CFrame.new(- 2150.587890625, 122.49767303467, - 10358.994140625)
        elseif (v7 >= 2100 and v7 <= 2124) or selected == "Peanut President" then
            Ms = "Peanut President"; NameQuest = "NutsIslandQuest"; QuestLv = 2; NameMon = "Peanut President"
            CFrameQ = CFrame.new(- 2105.53198, 37.2495995, - 10195.5088)
            CFrameMon = CFrame.new(- 2150.587890625, 122.49767303467, - 10358.994140625)
        elseif (v7 >= 2125 and v7 <= 2149) or selected == "Ice Cream Chef" then
            Ms = "Ice Cream Chef"; NameQuest = "IceCreamIslandQuest"; QuestLv = 1; NameMon = "Ice Cream Chef"
            CFrameQ = CFrame.new(- 819.376709, 64.9259796, - 10967.2832)
            CFrameMon = CFrame.new(- 789.941528, 209.382889, - 11009.9805)
        elseif (v7 >= 2150 and v7 <= 2199) or selected == "Ice Cream Commander" then
            Ms = "Ice Cream Commander"; NameQuest = "IceCreamIslandQuest"; QuestLv = 2; NameMon = "Ice Cream Commander"
            CFrameQ = CFrame.new(- 819.376709, 64.9259796, - 10967.2832)
            CFrameMon = CFrame.new(- 789.941528, 209.382889, - 11009.9805)
        elseif (v7 >= 2200 and v7 <= 2224) or selected == "Cookie Crafter" then
            Ms = "Cookie Crafter"; NameQuest = "CakeQuest1"; QuestLv = 1; NameMon = "Cookie Crafter"
            CFrameQ = CFrame.new(- 2022.29858, 36.9275894, - 12030.9766)
            CFrameMon = CFrame.new(- 2321.71216, 36.699482, - 12216.7871)
        elseif (v7 >= 2225 and v7 <= 2249) or selected == "Cake Guard" then
            Ms = "Cake Guard"; NameQuest = "CakeQuest1"; QuestLv = 2; NameMon = "Cake Guard"
            CFrameQ = CFrame.new(- 2022.29858, 36.9275894, - 12030.9766)
            CFrameMon = CFrame.new(- 1418.11011, 36.6718941, - 12255.7324)
        elseif (v7 >= 2250 and v7 <= 2274) or selected == "Baking Staff" then
            Ms = "Baking Staff"; NameQuest = "CakeQuest2"; QuestLv = 1; NameMon = "Baking Staff"
            CFrameQ = CFrame.new(- 1928.31763, 37.7296638, - 12840.626)
            CFrameMon = CFrame.new(- 1980.43848, 36.6716766, - 12983.8418)
        elseif (v7 >= 2275 and v7 <= 2299) or selected == "Head Baker" then
            Ms = "Head Baker"; NameQuest = "CakeQuest2"; QuestLv = 2; NameMon = "Head Baker"
            CFrameQ = CFrame.new(- 1928.31763, 37.7296638, - 12840.626)
            CFrameMon = CFrame.new(- 2251.5791, 52.2714615, - 13033.3965)
        elseif (v7 >= 2300 and v7 <= 2324) or selected == "Cocoa Warrior" then
            Ms = "Cocoa Warrior"; NameQuest = "ChocQuest1"; QuestLv = 1; NameMon = "Cocoa Warrior"
            CFrameQ = CFrame.new(231.75, 23.9003029, - 12200.292)
            CFrameMon = CFrame.new(167.978516, 26.2254658, - 12238.874)
        elseif (v7 >= 2325 and v7 <= 2349) or selected == "Chocolate Bar Battler" then
            Ms = "Chocolate Bar Battler"; NameQuest = "ChocQuest1"; QuestLv = 2; NameMon = "Chocolate Bar Battler"
            CFrameQ = CFrame.new(231.75, 23.9003029, - 12200.292)
            CFrameMon = CFrame.new(701.312073, 25.5824986, - 12708.2148)
        elseif (v7 >= 2350 and v7 <= 2374) or selected == "Sweet Thief" then
            Ms = "Sweet Thief"; NameQuest = "ChocQuest2"; QuestLv = 1; NameMon = "Sweet Thief"
            CFrameQ = CFrame.new(151.198242, 23.8907146, - 12774.6172)
            CFrameMon = CFrame.new(- 140.258301, 25.5824986, - 12652.3115)
        elseif (v7 >= 2375 and v7 <= 2400) or selected == "Candy Rebel" then
            Ms = "Candy Rebel"; NameQuest = "ChocQuest2"; QuestLv = 2; NameMon = "Candy Rebel"
            CFrameQ = CFrame.new(151.198242, 23.8907146, - 12774.6172)
            CFrameMon = CFrame.new(47.9231453, 25.5824986, - 13029.2402)
        elseif (v7 >= 2400 and v7 <= 2424) or selected == "Candy Pirate" then
            Ms = "Candy Pirate"; NameQuest = "CandyQuest1"; QuestLv = 1; NameMon = "Candy Pirate"
            CFrameQ = CFrame.new(- 1149.328, 13.5759039, - 14445.6143)
            CFrameMon = CFrame.new(- 1437.56348, 17.1481285, - 14385.6934)
        elseif (v7 >= 2425 and v7 <= 2449) or selected == "Snow Demon" then
            Ms = "Snow Demon"; NameQuest = "CandyQuest1"; QuestLv = 2; NameMon = "Snow Demon"
            CFrameQ = CFrame.new(- 1149.328, 13.5759039, - 14445.6143)
            CFrameMon = CFrame.new(- 916.222656, 17.1481285, - 14638.8125)
        elseif (v7 >= 2450 and v7 <= 2474) or selected == "Isle Outlaw" then
            Ms = "Isle Outlaw"; NameQuest = "TikiQuest1"; QuestLv = 1; NameMon = "Isle Outlaw"
            CFrameQ = CFrame.new(- 16549.890625, 55.68635559082031, - 179.91360473632812)
            CFrameMon = CFrame.new(- 16162.8193359375, 11.6863374710083, - 96.45481872558594)
        elseif (v7 >= 2475 and v7 <= 2499) or selected == "Island Boy" then
            Ms = "Island Boy"; NameQuest = "TikiQuest1"; QuestLv = 2; NameMon = "Island Boy"
            CFrameQ = CFrame.new(- 16549.890625, 55.68635559082031, - 179.91360473632812)
            CFrameMon = CFrame.new(- 16357.3125, 20.632822036743164, 1005.64892578125)
        elseif (v7 >= 2500 and v7 <= 2524) or selected == "Sun-kissed Warrior" then
            Ms = "Sun-kissed Warrior"; NameQuest = "TikiQuest2"; QuestLv = 1; NameMon = "Sun-kissed Warrior"
            CFrameQ = CFrame.new(- 16541.021484375, 54.77081298828125, 1051.461181640625)
            CFrameMon = CFrame.new(- 16357.3125, 20.632822036743164, 1005.64892578125)
        elseif (v7 >= 2525 and v7 <= 2549) or selected == "Isle Champion" then
            Ms = "Isle Champion"; NameQuest = "TikiQuest2"; QuestLv = 2; NameMon = "Isle Champion"
            CFrameQ = CFrame.new(- 16541.021484375, 54.77081298828125, 1051.461181640625)
            CFrameMon = CFrame.new(- 16848.94140625, 21.68633460998535, 1041.4490966796875)
        elseif (v7 >= 2550 and v7 <= 2574) or selected == "Serpent Hunter" then
            Ms = "Serpent Hunter"; NameQuest = "TikiQuest3"; QuestLv = 1; NameMon = "Serpent Hunter"
            CFrameQ = CFrame.new(- 16665.19140625, 104.59640502929688, 1579.6943359375)
            CFrameMon = CFrame.new(- 16621.4140625, 121.40631103515625, 1290.6881103515625)
        elseif v7 >= 2575 or selected == "Skull Slayer" then
            Ms = "Skull Slayer"; NameQuest = "TikiQuest3"; QuestLv = 2; NameMon = "Skull Slayer"
            CFrameQ = CFrame.new(- 16665.19140625, 104.59640502929688, 1579.6943359375)
            CFrameMon = CFrame.new(- 16811.5703125, 84.625244140625, 1542.235107421875)
        end
    end
end

-- ==========================================
-- BẮT ĐẦU CÁC CHỨC NĂNG VÀ CONTENT UI
-- ==========================================
Tabs.Info:AddSection("Thông Tin")
Tabs.Info:AddButton({
    ["Title"] = "HDanh Community",
    ["Description"] = "Discord",
    ["Callback"] = function()
        setclipboard(tostring("https://dsc.gg/nopermc"))
    end
})
Tabs.Info:AddButton({
    ["Title"] = "HDanh Hub",
    ["Description"] = "Youtube",
    ["Callback"] = function()
        setclipboard(tostring("https://youtube.com/@nopermc"))
    end
})
Tabs.Info:AddButton({
    ["Title"] = "HDanh Hub",
    ["Description"] = "Tiktok",
    ["Callback"] = function()
        setclipboard(tostring("www.tiktok.com/@uytins1vn._"))
    end
})
Tabs.Info:AddParagraph({
    ["Title"] = "Phát triển Monster",
    ["Description"] = "Kỹ Năng: Del có"
})

if executor then
    Tabs.Info:AddParagraph({
        ["Title"] = "Client Đang Dùng",
        ["Description"] = tostring(executor)
    })
end

Tabs.Info:AddParagraph({
    ["Title"] = "Cấp Nhất",
    ["Description"] = "Tôi sẽ Cấp nhật nhiều tính năng hơn trong tương lai"
})

_G.FastAttackStrix_Mode = "Super Fast Attack"
spawn(function()
    while wait() do
        if _G.FastAttackStrix_Mode == "Super Fast Attack" then
            _G.Fast_Delay = 1e-9
        end
    end
end)

Tabs.Main:AddSection("Cày Cấp")
local v253 = Tabs.Main:AddDropdown("DropdownSelectWeapon", {
    ["Title"] = "Vũ Khí",
    ["Values"] = {"Melee", "Sword", "Blox Fruit"},
    ["Multi"] = false,
    ["Default"] = 1
})
v253:SetValue("Melee")
ChooseWeapon = "Melee"
v253:OnChanged(function(p254)
    ChooseWeapon = p254
end)

task.spawn(function()
    while wait() do
        pcall(function()
            local sources = {game.Players.LocalPlayer.Backpack}
            if game.Players.LocalPlayer.Character then
                table.insert(sources, game.Players.LocalPlayer.Character)
            end
            for _, src in pairs(sources) do
                for _, t in pairs(src:GetChildren()) do
                    if t:IsA("Tool") then
                        if ChooseWeapon == "Blox Fruit" and t.ToolTip == "Blox Fruit" then
                            SelectWeapon = t.Name
                        elseif ChooseWeapon == "Sword" and t.ToolTip == "Sword" then
                            SelectWeapon = t.Name
                        elseif ChooseWeapon == "Melee" and t.ToolTip == "Melee" then
                            SelectWeapon = t.Name
                        end
                    end
                end
            end
        end)
    end
end)

Tabs.Main:AddToggle("ToggleLevel", {
    ["Title"] = "Cày Cấp",
    ["Default"] = false
}):OnChanged(function(p267)
    _G.AutoLevel = p267
    if p267 == true then
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "✅ Auto Farm Level";
            Text = "Đã bật! Bot sẽ tự động farm level";
            Duration = 3;
        })
    else
        wait()
        Tween(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
        wait()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "❌ Auto Farm Level";
            Text = "Đã tắt!";
            Duration = 2;
        })
    end
end)

spawn(function()
    while task.wait() do
        if _G.AutoLevel then
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local char = player and player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if not player or not char or not hrp then return end

                CheckLevel()
                if not Ms or not NameMon or not NameQuest or not QuestLv or not CFrameQ or not CFrameMon then return end

                local questVisible = false
                local QuestTitle = ""
                pcall(function()
                    questVisible = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
                    if questVisible then
                        QuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
                    end
                end)

                if questVisible and QuestTitle ~= "" and not string.find(QuestTitle, NameMon) then
                    bringmob = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                    return
                end

                if not questVisible then
                    bringmob = false
                    Tween2(CFrameQ)
                    repeat task.wait(0.1) until (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 or not _G.AutoLevel
                    wait(0.2)
                    if (CFrameQ.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
                        wait(0.3)
                    end
                    return
                end

                if questVisible and string.find(QuestTitle, NameMon) then
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        for _, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == Ms then
                                if not _fxEnabled then _fxEnabled = true; StartFXLoop() end
                                repeat
                                    task.wait(_G.Fast_Delay)
                                    AttackNoCoolDown()
                                    bringmob = true
                                    AutoHaki()
                                    EquipTool(SelectWeapon)
                                    local _mobCF = v.HumanoidRootPart.CFrame * Pos
                                    if (_mobCF.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 5 then
                                        BKP(_mobCF)
                                    end
                                    v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    v.HumanoidRootPart.Transparency = 1
                                    v.Humanoid.JumpPower = 0
                                    v.Humanoid.WalkSpeed = 0
                                    v.HumanoidRootPart.CanCollide = false
                                    pcall(function() v.Head.CanCollide = false end)
                                    FarmPos = v.HumanoidRootPart.CFrame
                                    MonFarm = v.Name
                                    local qv = false
                                    pcall(function() qv = game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible end)
                                until not _G.AutoLevel or not v.Parent or v.Humanoid.Health <= 0 or not qv
                                bringmob = false
                                if not _G.OneHitKill and not _G.AutoBone and not _G.AutoBoneNoQuest and not _G.AutoNear then StopFXLoop() end
                            end
                        end
                    else
                        bringmob = false
                        Tween2(CFrameMon)
                    end
                end
            end)
        end
    end
end)

Tabs.Main:AddSection("Chiến Đấu")
Tabs.Main:AddToggle("ToggleOneHit", {
    ["Title"] = "Đánh Nhanh",
    ["Default"] = false
}):OnChanged(function(v)
    _G.OneHitKill = v
    getgenv().AutoClick = v
end)

getgenv().AutoClick = false
getgenv().ClicksPerSecond = 20
local _vu = game:GetService("VirtualUser")
task.spawn(function()
    while task.wait(1 / getgenv().ClicksPerSecond) do
        if getgenv().AutoClick then
            pcall(function()
                local cam = workspace.CurrentCamera
                local vp = cam.ViewportSize
                local center = Vector2.new(vp.X / 2, vp.Y / 2)
                _vu:Button1Down(center, cam.CFrame)
                task.wait(0.02)
                _vu:Button1Up(center, cam.CFrame)
            end)
        end
    end
end)

print(">>> JOHN DOE HUB RED UI LOADED SUCCESSFULLY <<<")