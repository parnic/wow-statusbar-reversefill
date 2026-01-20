local f = CreateFrame("Frame", "ReverseStatusBarBug_Parent", UIParent)

function f:OnEvent(event, ...)
    if event == "UNIT_SPELLCAST_START" then
        local unit = ...
        if unit ~= "player" then
            return
        end

        local duration = UnitCastingDuration(unit)
        -- Enum.StatusBarTimerDirection.RemainingTime correctly anchors the texture to the top and gives us the
        -- "reveal" behavior we want out of the texture. Enum.StatusBarTimerDirection.ElapsedTime will not
        -- behave as desired if SetReverseFill or SetFillStyle are changed from their defaults.
        -- this SetTimerDuration with RemainingTime workaround only works for 12.x, however, and not Classic, for now.
        f.bar:SetTimerDuration(duration, Enum.StatusBarInterpolation.Immediate, Enum.StatusBarTimerDirection.ElapsedTime)
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
-- either of these methods cause the texture to "slide in" rather than "reveal" as the bottom of the texture is always the
-- coordinate anchor point rather than being relative to the direction of the fill.
bar:SetReverseFill(true)
-- bar:SetFillStyle(Enum.StatusBarFillStyle.Center)

f.bar = bar
