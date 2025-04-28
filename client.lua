-- client.lua
local lastHealth = 0

local bones = {
    ["HEAD"] = 31086,
    ["SKULL"] = 31086,
    ["SKULL_1"] = 31086,
    ["SKULL_2"] = 31086,
    ["SKULL_3"] = 31086,
    ["SKULL_4"] = 31086,
    ["SKULL_5"] = 31086,
    ["SKULL_6"] = 31086,
    ["SKULL_7"] = 31086,
    ["SKULL_8"] = 31086,
    ["SKULL_9"] = 31086,
    ["SKULL_10"] = 31086,
    ["UPPER_BODY"] = 24816,
    ["LOWER_BODY"] = 11816,
    ["LEFT_ARM"] = 61163,
    ["RIGHT_ARM"] = 18905,
    ["LEFT_LEG"] = 36864,
    ["RIGHT_LEG"] = 52301,
}

local damageMultipliers = {
    [bones.HEAD] = 0.5,
    [Skull] = 0.5,
    [bones.UPPER_BODY] = 1.0,
    [bones.LOWER_BODY] = 0.8,
    [bones.LEFT_ARM] = 0.6,
    [bones.RIGHT_ARM] = 0.6,
    [bones.LEFT_LEG] = 0.5,
    [bones.RIGHT_LEG] = 0.5,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local playerPed = PlayerPedId()

        if not IsEntityDead(playerPed) then
            local currentHealth = GetEntityHealth(playerPed)

            if currentHealth < lastHealth then
                local boneHit = GetPedLastDamageBone(playerPed)

                if boneHit then
                    local multiplier = damageMultipliers[boneHit] or 1.0
                    local damageTaken = (lastHealth - currentHealth)
                    local newDamage = math.floor(damageTaken * multiplier)
                    local newHealth = lastHealth - newDamage

                    if newHealth < 0 then
                        newHealth = 0
                    end

                    SetEntityHealth(playerPed, newHealth)
                end
            end

            lastHealth = GetEntityHealth(playerPed)
        else
            lastHealth = GetEntityHealth(playerPed)
        end
    end
end)
