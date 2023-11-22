fx_version 'bodacious'
games { 'gta5' }

author 'NanoByte Network'
description ''
version '1.0.0'


client_scripts {
    "@vrp/lib/utils.lua",
    'client.lua',
    
}

dependency 'screenshot-basic'

server_scripts {
    "@vrp/lib/utils.lua",
    'server_config.lua',
    'server.lua',
	
}

shared_script 'config.lua'