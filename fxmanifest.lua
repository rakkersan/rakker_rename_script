fx_version 'cerulean'
game 'gta5'
lua54 'yes'

auther 'rakkersan.'
description 'FiveM Rename Script'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

server_scripts {
    'server/*.lua'
}

client_scripts {
    'client/*.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/assets/*.css',
    'html/assets/*.js'
}