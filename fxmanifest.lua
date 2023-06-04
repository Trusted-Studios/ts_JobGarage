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
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",

    --> lib
    'lib/client/*.lua', 

    --> bridge
    'bridge/frameworks/*.lua',
    'bridge/bridge.lua',

    --> Script 
    'client/main.lua',
    'client/components/*.lua',
}