fx_version 'cerulean'
lua54 'yes'
game 'gta5'
-- use_fxv2_oal 'yes'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/2way.lua',
	'server/server.lua',
	'server/function.lua',
}

client_scripts {
	'client/2way.lua',
	'client/client.lua',
}

shared_scripts {
    'config.lua',
}

export 'SetInitialXPLevels'
export 'AddPlayerXP'
export 'RemovePlayerXP'
export 'GetCurrentPlayerXP'
export 'GetLevelFromXP'
export 'GetCurrentPlayerLevel'
export 'GetXPCeilingForLevel'
export 'GetXPFloorForLevel'