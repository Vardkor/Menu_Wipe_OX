fx_version 'cerulean'
games {'gta5'}
lua54 'yes'

author 'Vardkor'
description 'Menu Wipe Ox'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'config.lua'
}

server_script{
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

client_script{
    'client/*.lua'
}
