local currentWeapon = nil

RegisterNetEvent('weapon_allowed:removeWeapons')
AddEventHandler('weapon_allowed:removeWeapons', function()
    local playerPed = PlayerPedId()
    RemoveAllPedWeapons(playerPed, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)

        if weaponHash ~= currentWeapon then
            currentWeapon = weaponHash

            if currentWeapon ~= GetHashKey("WEAPON_UNARMED") then
                TriggerServerEvent('weapon_allowed:checkWeapon', currentWeapon)
            end
        end
    end
end)

