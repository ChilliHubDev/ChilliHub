-- dawg u catched me
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PASS_ID = 1100690060

-- Localized strings
local LANG = {
    en = {
        title_choose = "Pick a language",
        premium_title = "Chilli Premium",
        premium_desc = "You can get Chilli Premium for 150 Robux. Limited offer!",
        features_header = "This offers:",
        features = {
            "+ Anti Hit",
            "+ 10M+ Notifier",
            "+",
            "+ Instant Steal"
        },
        buy = "Buy",
        no = "No",
        confirm_title = "Are you sure?",
        confirm_yes = "Yes",
        confirm_undo = "Undo"
    },
    es = {
        title_choose = "Elige un idioma",
        premium_title = "Chilli Premium",
        premium_desc = "Puedes obtener Chilli Premium por 150 Robux. ¡Oferta limitada!",
        features_header = "Esto ofrece:",
        features = {
            "+ Anti Hit",
            "+ Notificador 10M+",
            "+",
            "+ Robo instantáneo"
        },
        buy = "Comprar",
        no = "No",
        confirm_title = "¿Estás seguro?",
        confirm_yes = "Sí",
        confirm_undo = "Deshacer"
    },
    pt = {
        title_choose = "Escolha um idioma",
        premium_title = "Chilli Premium",
        premium_desc = "Você pode obter Chilli Premium por 150 Robux. Oferta limitada!",
        features_header = "Isso oferece:",
        features = {
            "+ Anti Hit",
            "+ Notificador 10M+",
            "+",
            "+ Roubo Instantâneo"
        },
        buy = "Comprar",
        no = "Não",
        confirm_title = "Tem certeza?",
        confirm_yes = "Sim",
        confirm_undo = "Desfazer"
    }
}

-- Utility: create instances quickly
local function new(class, props)
    local obj = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            obj[k] = v
        end
    end
    return obj
end

-- Root GUI
local screenGui = new("ScreenGui", {Name = "ChilliPremiumGui", ResetOnSpawn = false, Parent = player:WaitForChild("PlayerGui")})

-- Centering frame factory
local function centerFrame(size)
    return new("Frame", {
        Size = size or UDim2.new(0,400,0,220),
        Position = UDim2.new(0.5,0,0.5,0),
        AnchorPoint = Vector2.new(0.5,0.5),
        BackgroundColor3 = Color3.fromRGB(30,30,30),
        BorderSizePixel = 0,
        Parent = screenGui
    })
end

local currentLangKey = "en"

-- LANGUAGE CHOOSER
local chooser = centerFrame(UDim2.new(0,360,0,140))
chooser.Name = "Chooser"

local titleLabel = new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 30),
    Position = UDim2.new(0,10,0,10),
    BackgroundTransparency = 1,
    TextScaled = true,
    Font = Enum.Font.SourceSansBold,
    TextColor3 = Color3.fromRGB(255,255,255),
    Text = "Pick a language",
    Parent = chooser
})

local btnContainer = new("Frame", {
    Size = UDim2.new(1, -20, 0, 60),
    Position = UDim2.new(0,10,0,50),
    BackgroundTransparency = 1,
    Parent = chooser
})
local layout = new("UIListLayout", {Parent = btnContainer, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0,12)})

local function makeFlagButton(emoji, key)
    local b = new("TextButton", {
        Size = UDim2.new(0,90,0,50),
        BackgroundColor3 = Color3.fromRGB(60,60,60),
        BorderSizePixel = 0,
        TextScaled = true,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.new(1,1,1),
        Text = emoji,
        Parent = btnContainer
    })
    b.MouseButton1Click:Connect(function()
        currentLangKey = key
        chooser:Destroy()
        showOfferGui()
    end)
    return b
end

makeFlagButton("🇪🇸", "es")
makeFlagButton("🇬🇧", "en")
makeFlagButton("🇵🇹", "pt")

-- OFFER GUI (created on demand)
function showOfferGui()
    local L = LANG[currentLangKey]
    local offer = centerFrame(UDim2.new(0,420,0,300))
    offer.Name = "Offer"

    local title = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0,10,0,10),
        BackgroundTransparency = 1,
        TextScaled = true,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255,255,255),
        Text = L.premium_title,
        Parent = offer
    })

    local desc = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 50),
        Position = UDim2.new(0,10,0,55),
        BackgroundTransparency = 1,
        TextWrapped = true,
        Text = L.premium_desc,
        TextColor3 = Color3.fromRGB(220,220,220),
        Font = Enum.Font.SourceSans,
        TextSize = 16,
        Parent = offer
    })

    local featHeader = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0,10,0,110),
        BackgroundTransparency = 1,
        Text = L.features_header,
        TextColor3 = Color3.fromRGB(200,200,200),
        Font = Enum.Font.SourceSansBold,
        TextSize = 16,
        Parent = offer
    })

    -- Features list
    local feats = new("Frame", {
        Size = UDim2.new(1, -20, 0, 80),
        Position = UDim2.new(0,10,0,135),
        BackgroundTransparency = 1,
        Parent = offer
    })
    local flayout = new("UIListLayout", {Parent = feats, FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0,4)})

    for _,v in ipairs(L.features) do
        new("TextLabel", {
            Size = UDim2.new(1,0,0,18),
            BackgroundTransparency = 1,
            Text = v,
            TextColor3 = Color3.fromRGB(200,200,200),
            Font = Enum.Font.SourceSans,
            TextSize = 16,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = feats
        })
    end

    -- Buttons: Buy and No
    local btnFrame = new("Frame", {
        Size = UDim2.new(1, -20, 0, 40),
        Position = UDim2.new(0,10,1,-50),
        BackgroundTransparency = 1,
        Parent = offer
    })
    local btnLayout = new("UIListLayout", {Parent = btnFrame, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0,20)})

    local buyBtn = new("TextButton", {
        Size = UDim2.new(0,140,1,0),
        BackgroundColor3 = Color3.fromRGB(0,150,80),
        Text = L.buy,
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.SourceSansBold,
        TextSize = 20,
        Parent = btnFrame
    })

    local noBtn = new("TextButton", {
        Size = UDim2.new(0,140,1,0),
        BackgroundColor3 = Color3.fromRGB(150,30,30),
        Text = L.no,
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.SourceSansBold,
        TextSize = 20,
        Parent = btnFrame
    })

    buyBtn.MouseButton1Click:Connect(function()
        -- Prompt GamePass purchase (LocalScript only)
        pcall(function()
            MarketplaceService:PromptGamePassPurchase(player, PASS_ID)
        end)
    end)

    noBtn.MouseButton1Click:Connect(function()
        offer:Destroy()
        showConfirmGui(L, showOfferGui)
    end)
end

-- Confirmation GUI shown when user clicks "No"
function showConfirmGui(L, undoCallback)
    local confirm = centerFrame(UDim2.new(0,360,0,140))
    confirm.Name = "Confirm"

    local q = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 50),
        Position = UDim2.new(0,10,0,10),
        BackgroundTransparency = 1,
        Text = L.confirm_title,
        TextScaled = true,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255,255,255),
        Parent = confirm
    })

    local btnFrame = new("Frame", {
        Size = UDim2.new(1, -20, 0, 50),
        Position = UDim2.new(0,10,1,-60),
        BackgroundTransparency = 1,
        Parent = confirm
    })
    local layout = new("UIListLayout", {Parent = btnFrame, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0,12)})

    local undoBtn = new("TextButton", {
        Size = UDim2.new(0,120,1,0),
        BackgroundColor3 = Color3.fromRGB(60,60,60),
        Text = "↩ "..L.confirm_undo,
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.SourceSansBold,
        Parent = btnFrame
    })

    local yesBtn = new("TextButton", {
        Size = UDim2.new(0,120,1,0),
        BackgroundColor3 = Color3.fromRGB(150,30,30),
        Text = L.confirm_yes,
        TextColor3 = Color3.new(1,1,1),
        Font = Enum.Font.SourceSansBold,
        Parent = btnFrame
    })

    undoBtn.MouseButton1Click:Connect(function()
        confirm:Destroy()
        if type(undoCallback) == "function" then
            undoCallback()
        end
    end)

    yesBtn.MouseButton1Click:Connect(function()
        confirm:Destroy()
    end)
end

-- Start by showing language chooser (already created above)
-- (If you want to show chooser again later, call showOfferGui or recreate chooser)

-- Optional: expose simple API
_G.ShowChilliPremium = function()
    -- destroy any existing root children then recreate chooser
    for _, c in pairs(screenGui:GetChildren()) do c:Destroy() end
    -- recreate chooser
    local newChooser = centerFrame(UDim2.new(0,360,0,140))
    newChooser.Name = "Chooser"
    local titleLabel = new("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0,10,0,10),
        BackgroundTransparency = 1,
        TextScaled = true,
        Font = Enum.Font.SourceSansBold,
        TextColor3 = Color3.fromRGB(255,255,255),
        Text = LANG[currentLangKey].title_choose,
        Parent = newChooser
    })
    local btnContainer = new("Frame", {Size = UDim2.new(1, -20, 0, 60), Position = UDim2.new(0,10,0,50), BackgroundTransparency = 1, Parent = newChooser})
    new("UIListLayout", {Parent = btnContainer, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Center, Padding = UDim.new(0,12)})
    local function makeFlag(emoji, key)
        local b = new("TextButton", {
            Size = UDim2.new(0,90,0,50),
            BackgroundColor3 = Color3.fromRGB(60,60,60),
            BorderSizePixel = 0,
            TextScaled = true,
            Font = Enum.Font.SourceSansBold,
            TextColor3 = Color3.new(1,1,1),
            Text = emoji,
            Parent = btnContainer
        })
        b.MouseButton1Click:Connect(function()
            currentLangKey = key
            newChooser:Destroy()
            showOfferGui()
        end)
    end
    makeFlag("🇪🇸","es"); makeFlag("🇬🇧","en"); makeFlag("🇵🇹","pt")
end

-- initial state: chooser already created earlier in script
titleLabel.Text = LANG[currentLangKey].title_choose
