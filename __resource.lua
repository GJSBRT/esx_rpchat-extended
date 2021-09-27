--[[

  ESX RP Chat

--]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX RP Chat Extended'

version '1.0.0'

author 'GSBRT#0001 and Druganov#6843'

client_script {'client/main.lua',
              'config.lua'}

server_scripts {

  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
  'config.lua'

}
