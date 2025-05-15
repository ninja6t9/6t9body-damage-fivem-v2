local lastHealth = 0

local bones = {
    ["skull"] = 31086,--skull
        ["head"] = 12844,--head
        ["SKULL_1"] = 39317,--neck
        ["SKULL_2"] = 65068,--Jaw
        ["SKULL_3"] = 25260,--left eye
        ["SKULL_4"] = 27474,--right eye
        ["SKULL_5"] = 6442,--left ear
        ["SKULL_6"] = 10706,--right ear
        ["SKULL_7"] = 35731,--Nose
        ["SKULL_8"] = 17188,--Upper Teeth
        ["SKULL_9"] = 44268,---Lower Teeth
        ["SKULL_10"] = 37193,--Forehead

    ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
        ["UPPER_BODY"] = 24816,
    ["LOWER_BODY"] = 11816,

    ["LEFT_ARM"] = 61163,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,

    ["RIGHT_ARM"] = 18905,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,

    ["LEFT_LEG"] = 36864,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,

    ["RIGHT_LEG"] = 52301,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,
        ["LOWER_BODY"] = 11816,

}

local damageMultipliers = {
    [bones.skull] = 0.5,
        [bones.head] = 0.5,
        [bones.SKULL_1] = 0.5,
        [bones.SKULL_2] = 0.5,
        [bones.SKULL_3] = 0.5,
        [bones.SKULL_4] = 0.5,
        [bones.SKULL_5] = 0.5,
        [bones.SKULL_6] = 0.5,
        [bones.SKULL_7] = 0.5,
        [bones.SKULL_8] = 0.5,
        [bones.SKULL_9] = 0.5,
        [bones.SKULL_10] = 0.5,
    [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
        [bones.UPPER_BODY] = 1.0,
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
