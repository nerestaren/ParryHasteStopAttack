SLASH_ParryHasteStopAttack1 = '/ph'
SLASH_ParryHasteStopAttack2 = '/phsa'
SLASH_ParryHasteStopAttack3 = '/parryhaste'
SLASH_ParryHasteStopAttack4 = '/parryhastestopattack'

local colorEnable = "|cff00ff00"
local colorDisable = "|cffffa500"
local colorToggle = "|cff00ffff"
local colorMacro = "|cffffff00"
local colorError = "|cffff0000"
local colorReset = "|r"

SlashCmdList["ParryHasteStopAttack"] = function (msg)
    if InCombatLockdown() then return print(colorError .. "Cannot modify macros in combat!" .. colorReset) end

    local action = 0
    if (msg == "on" or msg == "enable") then
        action = 1
        print("ParryHasteStopAttack: " .. colorEnable .. "Enable" .. colorReset .. " (uncomment) /stopattack.")
    elseif (msg == "off" or msg == "disable") then
        action = -1
        print("ParryHasteStopAttack: " .. colorDisable .. "Disable" .. colorReset .. " (comment) /stopattack.")
    elseif (msg == "toggle" or msg == "") then
        action = 2
        print("ParryHasteStopAttack: " .. colorToggle .. "Toggle" .. colorReset .. " /stopattack.")
    else
        return print(colorError .. "Invalid argument!" .. colorReset .. " Use 'on', 'off', or 'toggle'.")
    end

    for i = 1, 54 do
        local name, iconTexture, body = GetMacroInfo(i)
        if body then
            local lines = {}
            local modified = false
            for line in string.gmatch(body, "[^\n]+") do
                if string.sub(line, -5) == "#phsa" then
                    -- Has the #phsa tag, we process it
                    if string.sub(line, 1, 1) == "#" then
                        -- Commented out
                        if action == 1 or action == 2 then
                            -- We want it uncommented or toggled
                            line = string.sub(line, 2)
                            print(string.format(" - Macro: " .. colorMacro .. "%s" .. colorReset .. ". Action: " .. colorEnable .. "enable" .. colorReset .. ".", name))
                            modified = true
                        end
                    else
                        -- Not commented out
                        if action == -1 or action == 2 then
                            -- We want it commented out or toggled
                            line = "#" .. line
                            print(string.format(" - Macro: " .. colorMacro .. "%s" .. colorReset .. ". Action: " .. colorDisable .. "disable" .. colorReset .. ".", name))
                            modified = true
                        end
                    end
                end
                table.insert(lines, line)
            end

            if modified then
                local newBody = table.concat(lines, "\n")
                EditMacro(i, nil, nil, newBody)
            end
        end
    end
end;