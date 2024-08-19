fx_version "cerulean"
game "gta5"
lua54 "true"

name "lion_mechanic"
author "Mrlion"
description "Mechanic script made by Mrlion using oxlib"
version "1.1.1"

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    'server/*.lua'
}

files {
    "locales/*.json"
}
