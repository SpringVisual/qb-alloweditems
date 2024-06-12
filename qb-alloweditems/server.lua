QBCore = exports['qb-core']:GetCoreObject()

-- weapons that allowed to jobs
local allowedJobs = {
    police = true,
    ambulance = true,
}

-- weapons that allowed to gangs
local allowedGangs = {
    vagos = true,
    ballas = true,
    lostmc = true,
    cartel = true,
    families = true,
    triads = true,
    crime = true,
}

-- weapons that allowed to everyone
local universalWeapons = {
    weapon_wrench = true,
    weapon_hammer = true,
    weapon_bat = true,
    weapon_switchblade = true,
    weapon_knife = true,
    weapon_dagger = true,
    weapon_knuckle = true,
    weapon_katanas = true,
    weapon_machete = true,
    weapon_hatchet = true,
    weapon_golfclub = true,
}

local function isAllowedToUseWeapons(job)
    return allowedJobs[job] or false
end

local function isAllowedGang(gang)
    return allowedGangs[gang] or false
end

local function isUniversalWeapon(weaponHash)
    for weaponName, _ in pairs(universalWeapons) do
        if GetHashKey(weaponName) == weaponHash then
            return true
        end
    end
    return false
end

RegisterNetEvent('weapon_allowed:checkWeapon')
AddEventHandler('weapon_allowed:checkWeapon', function(weapon)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player then
        local playerJob = Player.PlayerData.job.name
        local playerGang = Player.PlayerData.gang.name

        if isUniversalWeapon(weapon) then
            return 
        elseif isAllowedToUseWeapons(playerJob) then
            return 
        elseif playerGang and isAllowedGang(playerGang) then
            return
        else
            TriggerClientEvent('QBCore:Notify', src, "You are not allowed to use weapon!", "error")
            TriggerClientEvent('weapon_allowed:removeWeapons', src)
        end
    else
    end
end)