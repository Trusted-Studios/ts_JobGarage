fx_version 'cerulean'
games { 'gta5' }

author 'German. Warthog'

lua54 'yes'

shared_scripts {
    'config.lua',
    'lib/shared/*.lua'
}

client_scripts {
    --> RageUI 
    "RageUI/src/RMenu.lua",
    "RageUI/src/menu/RageUI.lua",
    "RageUI/src/menu/Menu.lua",
    "RageUI/src/menu/MenuController.lua",
    "RageUI/src/components/*.lua",
    "RageUI/src/menu/elements/*.lua",
    "RageUI/src/menu/items/*.lua",
    "RageUI/src/menu/panels/*.lua",
    "RageUI/src/menu/panels/*.lua",
    "RageUI/src/menu/windows/*.lua",

    --> lib
    'lib/client/*.lua', 

    --> bridge
    'bridge/frameworks/*.lua',
    'bridge/bridge.lua',

    --> Script 
    'client/main.lua',
    'client/components/*.lua',
}