local f = CreateFrame("Frame", "ReverseStatusBarBug_Parent", UIParent)

function f:OnEvent(event, ...)
    if event == "UNIT_SPELLCAST_START" then
        local unit = ...
        if unit ~= "player" then
            return
        end

        local duration = UnitCastingDuration(unit)
        f.bar:SetTimerDuration(duration)
    end
end

f:RegisterEvent("UNIT_SPELLCAST_START")
f:SetScript("OnEvent", f.OnEvent)
f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
f:SetWidth(128)
f:SetHeight(256)

local bar = CreateFrame("StatusBar", "ReverseStatusBarBug_Bar", f)
bar:SetAllPoints(f)
bar:SetMinMaxValues(0, 1)
bar:SetValue(0)
bar:SetOrientation("VERTICAL")
bar:SetStatusBarTexture("Interface\\AddOns\\ReverseStatusBarBug\\bar")
-- uncomment this to see the bar texture filled in an unexpected way
-- bar:SetReverseFill(true)

f.bar = bar
