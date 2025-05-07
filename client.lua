local lastHealth = 0

local bones = {
    ["HEAD"] = 31086,
        ["SKULL"] = 12844,
        ["SKULL_1"] = 39317,--neck
        ["SKULL_2"] = 65068,
        ["SKULL_3"] = ,
        ["SKULL_4"] = ,
        ["SKULL_5"] = ,
        ["SKULL_6"] = ,
        ["SKULL_7"] = ,
        ["SKULL_8"] = ,
        ["SKULL_9"] = ,
        ["SKULL_10"] = ,

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


    ["RIGHT_ARM"] = 18905,

    ["LEFT_LEG"] = 36864,

    ["RIGHT_LEG"] = 52301,

}

local damageMultipliers = {
    [bones.HEAD] = 0.5,
        [bones.Skull] = 0.5,
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
