ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('vard:wipe:IsPlayerStaff', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if xPlayer ~= nil then
        local playerGroup = xPlayer.getGroup()

        if playerGroup == 'owner' then 
            cb(true)
        else 
            cb(false)
            TriggerClientEvent('esx:showNotification', source, {
                title = 'Permission refusée !',
                description = 'Vous ne possédez pas les autorisations nécessaires pour ouvrir ce menu.',
                position = 'top',
                duration = 5000,
                type = 'error',
            })
        end 
    else
        cb(false)
    end
end)

RegisterNetEvent('vard:wipe:openWipeMenu')
AddEventHandler('vard:wipe:openWipeMenu', function()
    local source = source

    MySQL.Async.fetchAll('SELECT * FROM users', {}, function(results)
        local playerlist = {}

        for _, data in ipairs(results) do
            table.insert(playerlist, {
               identifier = data.identifier,
                firstname = data.firstname,
                lastname = data.lastname,
                group = data.group,
            })
        end

        TriggerClientEvent('vard:wipe:client:openWipeMenu', source, playerlist)
    end)
end)

RegisterNetEvent('vard:wipe:wipePlayer')
AddEventHandler('vard:wipe:wipePlayer', function(identifier)
    MySQL.Async.execute('DELETE FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, function(affectedRows)
        if affectedRows > 0 then
            print('[^3VardWipe^7] [^2Success^7]')
            -- Vérifiez que 'identifier' contient l'identifiant du joueur correct
            print('Player Wipe : ' .. identifier)
            
            -- Récupérer la source du joueur
            local player = ESX.GetPlayerFromIdentifier(identifier)
            if player then
                -- Déconnecter le joueur
                DropPlayer(player.source, "[Ox_wipe] - Vous avez été wiped...")
                TriggerClientEvent("esx:showNotification", player.source, "~g~Wipe effectué")
            end
        else
            print('[^3VardWipe^7] [^1Erreur^7] Aucun utilisateur trouvé avec cet identifiant.')
        end
    end)
end)

