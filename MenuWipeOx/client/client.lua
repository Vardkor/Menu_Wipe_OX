RegisterCommand('menuwipe', function()
    ESX.TriggerServerCallback('vard:wipe:IsPlayerStaff', function(cb)
        if cb then 
            TriggerServerEvent('vard:wipe:openWipeMenu')
        end
    end)
end)

RegisterNetEvent('vard:wipe:client:openWipeMenu', function(playerlist)

    local options = {}

    for _, data in ipairs(playerlist) do 
        table.insert(options, {
            title = ("%s %s"):format(data.firstname, data.lastname),
            description = data.identifier,
            onSelect = function()
                lib.registerContext({
                    menu = 'menu_wipe',
                    id = 'menu_wipe_'..data.identifier,
                    title = ("%s %s"):format(data.firstname, data.lastname),
                    options = {
                        {
                            title = "Wipe le Joueur",
                            description = "Permet de supprimer le joueur de la database",
                            icon = 'ban',
                            onSelect = function()
                                TriggerServerEvent('vard:wipe:wipePlayer', data.identifier)
                            end
                        }
                    }
                })
                lib.showContext('menu_wipe_'..data.identifier)
            end
        })
    end

    lib.registerContext({
        id = 'menu_wipe',
        title = 'Menu Wipe',
        options = options
    })

    lib.showContext('menu_wipe')
end)