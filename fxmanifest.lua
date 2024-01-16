fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'
author 'notee.tebex.io'
description 'Example Menu of NEMenu'
version '0.0.0'

shared_script {
    '@ne_libs/imports.lua',
    'config.lua'
}

client_scripts {
    '@ne_libs/menu.lua',
    'example.lua'
}

server_scripts {
    '@ne_libs/versionchecker.lua'
}

dependencies {
    'ne_libs'
}

escrow_ignore {
	'example.lua'
}