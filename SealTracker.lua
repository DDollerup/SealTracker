function print(msg)
    if DEFAULT_CHAT_FRAME then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ff00[SealTracker by Dollerp]:|r " .. tostring(msg))
    end
end


-- Create a frame to handle events
local sealTrackerFrame = CreateFrame("Frame", "sealTrackerFrame", UIParent)
sealTrackerFrame:RegisterEvent("UNIT_AURA")
sealTrackerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

local _width = 58
local _height = 50 + (_width - 10)

-- Set size and default start location
sealTrackerFrame:SetWidth(_width)
sealTrackerFrame:SetHeight(_height)
sealTrackerFrame:SetPoint("CENTER", UIParent, "CENTER", 145, 15) -- Moved 50 pixels to the right

-- Add background with padding and transparency
sealTrackerFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 14,
    edgeSize = 14,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
sealTrackerFrame:SetBackdropColor(0, 0, 0, 0.7) -- Black with 70% transparency

-- Enable dragging with CTRL + Left-Click
sealTrackerFrame.isMoving = false
sealTrackerFrame.isMouseEnabled = true
sealTrackerFrame:SetMovable(true)
sealTrackerFrame:EnableMouse(true)
sealTrackerFrame:RegisterForDrag("LeftButton")

sealTrackerFrame:SetScript("OnMouseDown", function()
    if arg1 == "LeftButton" and IsControlKeyDown() then
        this:StartMoving()
        this.isMoving = true
    end
end)

sealTrackerFrame:SetScript("OnMouseUp", function()
    if this.isMoving then
        this:StopMovingOrSizing()
        this.isMoving = false
    end
end)

sealTrackerFrame:SetScript("OnEnter", function()
    if not IsControlKeyDown() then
        this:EnableMouse(false)
        this.isMouseEnabled = false
    else
        this:EnableMouse(true)
        this.isMouseEnabled = true
    end
end)

sealTrackerFrame:SetScript("OnLeave", function()
    this:EnableMouse(true) -- Re-enable mouse after leaving to avoid getting "stuck"
end)

-- Add Seal buff icon
sealTrackerFrame.icon = sealTrackerFrame:CreateTexture(nil, "ARTWORK")
sealTrackerFrame.icon:SetWidth(_width - 10)
sealTrackerFrame.icon:SetHeight(_width - 10)
sealTrackerFrame.icon:SetPoint("TOP", sealTrackerFrame, "TOP", 0, -5) -- Position it at the top
sealTrackerFrame.icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_01") -- Default icon

-- Create a font string to display the timer below the icon
sealTrackerFrame.text = sealTrackerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
sealTrackerFrame.text:SetPoint("TOP", sealTrackerFrame.icon, "BOTTOM", 0, -5)
sealTrackerFrame.text:SetText("N/A")

-- Known textures for the seals
local seals = {
    ["Interface\\Icons\\Spell_Holy_HealingAura"] = "Interface\\Icons\\Spell_Holy_HealingAura", -- Seal of Light
    ["Interface\\Icons\\Spell_Holy_HolySmite"] = "Interface\\Icons\\Spell_Holy_HolySmite", -- Seal of the Crusader
    ["Interface\\Icons\\Spell_Holy_RighteousnessAura"] = "Interface\\Icons\\Spell_Holy_RighteousnessAura", -- Seal of Wisdom
    ["Interface\\Icons\\Ability_ThunderBolt"] = "Interface\\Icons\\Ability_ThunderBolt", -- Seal of the Righteous
    ["Interface\\Icons\\Spell_Holy_SealOfWrath"] = "Interface\\Icons\\Spell_Holy_SealOfWrath", -- Seal of Justice
    ["Interface\\Icons\\Ability_Warrior_InnerRage"] = "Interface\\Icons\\Ability_Warrior_InnerRage" -- Seal of Command
}

-- Variables to track Seal buff
local activeSealTexture = nil

-- Function to update Seal buff information
local function UpdateSealInfo()
    local found = false
    for i = 1, 64 do
        local texture = UnitBuff("player", i)

        if texture and seals[texture] then
            if activeSealTexture ~= texture then
                activeSealTexture = texture
                sealTrackerFrame.icon:SetTexture(seals[texture])
                sealTrackerFrame.text:SetText("Active")
            end
            found = true
            break
        end
    end
    if not found then
        activeSealTexture = nil
        sealTrackerFrame.text:SetText("Inactive")
        sealTrackerFrame.icon:SetTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot") -- Default icon
    end
end

sealTrackerFrame:SetScript("OnUpdate", function()
    if not this.isMoving and not this.isMouseEnabled then
        this:EnableMouse(true)
        this.isMouseEnabled = true
    end
end)

-- Event handler
sealTrackerFrame:SetScript("OnEvent", function()
    if event == "UNIT_AURA" and arg1 == "player" then
        UpdateSealInfo()
    elseif event == "PLAYER_ENTERING_WORLD" then
        UpdateSealInfo()
    end
end)

print("Loaded")
