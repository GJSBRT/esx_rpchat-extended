--[[

https://github.com/GJSBRT/esx_rpchat-extended
GSBRT#0001

esx_rpchat edited by 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 and GSBRT#0001, logs to discord included

]]--

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local mode = "kick"
local lastMessage = 0

RegisterCommand('twt', function(source, args, rawCommand)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local naampie = GetRealPlayerName(source)
    local ids = ExtractIdentifiers(source)
    local discord =  "<@" ..ids.discord:gsub("discord:", "")..">"
	if(IsPlayerAceAllowed(source, "rpchat:chatbypass"))  -- Checks for bypass permission
		then 
			CancelEvent() -- Stops event 
		else
      
        local finalmessage = msg:lower()
        finalmessage = finalmessage:gsub(" ", "")
        finalmessage = finalmessage:gsub("%-", "")
        finalmessage = finalmessage:gsub("%.", "")
        finalmessage = finalmessage:gsub("$", "s")
        finalmessage = finalmessage:gsub("€", "e")
        finalmessage = finalmessage:gsub(",", "")
        finalmessage = finalmessage:gsub(";", "")
        finalmessage = finalmessage:gsub(":", "")
        finalmessage = finalmessage:gsub("*", "")
        finalmessage = finalmessage:gsub("_", "")
        finalmessage = finalmessage:gsub("|", "")
        finalmessage = finalmessage:gsub("/", "")
        finalmessage = finalmessage:gsub("<", "")
        finalmessage = finalmessage:gsub(">", "")
        finalmessage = finalmessage:gsub("ß", "ss")
        finalmessage = finalmessage:gsub("&", "")
        finalmessage = finalmessage:gsub("+", "")
        finalmessage = finalmessage:gsub("¦", "")
        finalmessage = finalmessage:gsub("§", "s")
        finalmessage = finalmessage:gsub("°", "")
        finalmessage = finalmessage:gsub("#", "")
        finalmessage = finalmessage:gsub("@", "a")
        finalmessage = finalmessage:gsub("\"", "")
        finalmessage = finalmessage:gsub("%(", "")
        finalmessage = finalmessage:gsub("%)", "")
        finalmessage = finalmessage:gsub("=", "")
        finalmessage = finalmessage:gsub("?", "")
        finalmessage = finalmessage:gsub("!", "")
        finalmessage = finalmessage:gsub("´", "")
        finalmessage = finalmessage:gsub("`", "")
        finalmessage = finalmessage:gsub("'", "")
        finalmessage = finalmessage:gsub("%^", "")
        finalmessage = finalmessage:gsub("~", "")
        finalmessage = finalmessage:gsub("%[", "")
        finalmessage = finalmessage:gsub("]", "")
        finalmessage = finalmessage:gsub("{", "")
        finalmessage = finalmessage:gsub("}", "")
        finalmessage = finalmessage:gsub("£", "e")
        finalmessage = finalmessage:gsub("¨", "")
        finalmessage = finalmessage:gsub("ç", "c")
        finalmessage = finalmessage:gsub("¬", "")
        finalmessage = finalmessage:gsub("\\", "")
        finalmessage = finalmessage:gsub("1", "i")
        finalmessage = finalmessage:gsub("3", "e")
        finalmessage = finalmessage:gsub("4", "a")
        finalmessage = finalmessage:gsub("5", "s")
        finalmessage = finalmessage:gsub("0", "o")

        local lastchar = ""
        local output = ""
        for char in finalmessage:gmatch(".") do
            if(char ~= lastchar) then
                output = output .. char
            end
            lastchar = char
        end

		local send = true
		for i in pairs(Config.Blacklist) do -- Checks Config.Blacklist
			if(output:find(Config.Blacklist[i])) then
				-- Bad word detected
				if(mode == "delete") then
					-- Deletes message
				elseif(mode == "kick") then
					PerformHttpRequest(Config.BlacklistLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Blacklisted word kick", description = " "..playerName.."** probeerde **"..msg.."** te zeggen in ooc en is daarvoor gekickt\nIngame naam: **"..naampie.."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")}, color=0}}}),  { ['Content-Type'] = 'application/json' })
					DropPlayer(source, Config.KickMessage) -- Kicks player
				end
				send = false -- sets send to false so message doesnt get sent
				break
			end
		end
		if(send) then -- if true then message gets sent
            if GetGameTimer() - lastMessage < 3500 then
                TriggerClientEvent('chat:addMessage', source, {
                    template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 8px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
                })
                return
            end
          lastMessage = GetGameTimer()
            PerformHttpRequest(Config.ChatLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Twitter", description = " "..naampie..": "..msg.."**\nSteamnaam: **"..GetPlayerName(source).."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")},  color=1876210}}}),  { ['Content-Type'] = 'application/json' })
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 10px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
                args = { naampie, msg }
            })
	    	end
        end
end)

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

RegisterCommand('staff', function(source, args, rawCommand)
	local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(6)
    local naampie = GetRealPlayerName(source)
    local ids = ExtractIdentifiers(source)
    local discord =  "<@" ..ids.discord:gsub("discord:", "")..">"
	if(IsPlayerAceAllowed(source, "rpchat:chatbypass"))  -- Checks for bypass permission
		then 
			CancelEvent() -- Stops event 
		else
      
        local finalmessage = msg:lower()
        finalmessage = finalmessage:gsub(" ", "")
        finalmessage = finalmessage:gsub("%-", "")
        finalmessage = finalmessage:gsub("%.", "")
        finalmessage = finalmessage:gsub("$", "s")
        finalmessage = finalmessage:gsub("€", "e")
        finalmessage = finalmessage:gsub(",", "")
        finalmessage = finalmessage:gsub(";", "")
        finalmessage = finalmessage:gsub(":", "")
        finalmessage = finalmessage:gsub("*", "")
        finalmessage = finalmessage:gsub("_", "")
        finalmessage = finalmessage:gsub("|", "")
        finalmessage = finalmessage:gsub("/", "")
        finalmessage = finalmessage:gsub("<", "")
        finalmessage = finalmessage:gsub(">", "")
        finalmessage = finalmessage:gsub("ß", "ss")
        finalmessage = finalmessage:gsub("&", "")
        finalmessage = finalmessage:gsub("+", "")
        finalmessage = finalmessage:gsub("¦", "")
        finalmessage = finalmessage:gsub("§", "s")
        finalmessage = finalmessage:gsub("°", "")
        finalmessage = finalmessage:gsub("#", "")
        finalmessage = finalmessage:gsub("@", "a")
        finalmessage = finalmessage:gsub("\"", "")
        finalmessage = finalmessage:gsub("%(", "")
        finalmessage = finalmessage:gsub("%)", "")
        finalmessage = finalmessage:gsub("=", "")
        finalmessage = finalmessage:gsub("?", "")
        finalmessage = finalmessage:gsub("!", "")
        finalmessage = finalmessage:gsub("´", "")
        finalmessage = finalmessage:gsub("`", "")
        finalmessage = finalmessage:gsub("'", "")
        finalmessage = finalmessage:gsub("%^", "")
        finalmessage = finalmessage:gsub("~", "")
        finalmessage = finalmessage:gsub("%[", "")
        finalmessage = finalmessage:gsub("]", "")
        finalmessage = finalmessage:gsub("{", "")
        finalmessage = finalmessage:gsub("}", "")
        finalmessage = finalmessage:gsub("£", "e")
        finalmessage = finalmessage:gsub("¨", "")
        finalmessage = finalmessage:gsub("ç", "c")
        finalmessage = finalmessage:gsub("¬", "")
        finalmessage = finalmessage:gsub("\\", "")
        finalmessage = finalmessage:gsub("1", "i")
        finalmessage = finalmessage:gsub("3", "e")
        finalmessage = finalmessage:gsub("4", "a")
        finalmessage = finalmessage:gsub("5", "s")
        finalmessage = finalmessage:gsub("0", "o")

        local lastchar = ""
        local output = ""
        for char in finalmessage:gmatch(".") do
            if(char ~= lastchar) then
                output = output .. char
            end
            lastchar = char
        end

		local send = true
		for i in pairs(blacklist) do -- Checks blacklist
			if(output:find(blacklist[i])) then
				-- Bad word detected
				if(mode == "delete") then
					-- Deletes message
				elseif(mode == "kick") then
					PerformHttpRequest(Config.BlacklistLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Blacklisted word kick", description = " "..playerName.."** probeerde **"..msg.."** te zeggen in ooc en is daarvoor gekickt\nIngame naam: **"..naampie.."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")}, color=0}}}),  { ['Content-Type'] = 'application/json' })
					DropPlayer(source, Config.KickMessage) -- Kicks player
				end
				send = false -- sets send to false so message doesnt get sent
				break
			end
		end
		if(send) then -- if true then message gets sent
            if(IsPlayerAceAllowed(source, "command"))
            then 
            PerformHttpRequest(Config.ChatLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Staff", description = " "..GetPlayerName(source)..": "..msg.."**\nID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")},  color=16625167}}}),  { ['Content-Type'] = 'application/json' })
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(253, 174, 15, 0.6); border-radius: 10px;"><i class="fas fa-crown"></i> ^*Kronenburg Roleplay Staff^r {0}:<br> {1}</div>',
                args = { playerName, msg }
            })
        else
        end
		end
	end
end)

----------------------------------------------------------------------------
----------------------------------------------------------------------------
----------------------------------------------------------------------------

RegisterServerEvent('politiebericht')
AddEventHandler('politiebericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord =  "<@" ..ids.discord:gsub("discord:", "")..">"
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 8px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
  lastMessage = GetGameTimer()
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(17, 58, 140, 0.7); border-radius: 10px;"><i class="fab fa-twitter"></i> Politie Kronenburg:<br> ' .. table.concat(args, " ") .. '</div>',
            })
        PerformHttpRequest(Config.OverheidsLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Politie tweet", description = " **"..GetPlayerName(source).."**: ".. table.concat(args, " ") .."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nRang: **"..xPlayer.job.grade_label.."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")},  color=1129100}}}),  { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('anwbbericht')
AddEventHandler('anwbbericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord =  "<@" ..ids.discord:gsub("discord:", "")..">"
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 8px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
  lastMessage = GetGameTimer()
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(135, 90, 7, 0.7); border-radius: 10px;"><i class="fab fa-twitter"></i> ANWB Kronenburg:<br> ' .. table.concat(args, " ") .. '</div>',
            })
        PerformHttpRequest(Config.OverheidsLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "ANWB tweet", description = " **"..GetPlayerName(source).."**: ".. table.concat(args, " ") .."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nRang: **"..xPlayer.job.grade_label.."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")},  color=8870407}}}),  { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('ambubericht')
AddEventHandler('ambubericht', function(args)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ids = ExtractIdentifiers(source)
    local discord =  "<@" ..ids.discord:gsub("discord:", "")..">"
    if GetGameTimer() - lastMessage < 3500 then
        TriggerClientEvent('chat:addMessage', source, {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 8px;"><b>^*Chat^r:</b> Je verstuurd teveel berichten, probeer het over enkele seconden opnieuw!</div>',
        })
        return
    end
  lastMessage = GetGameTimer()
            TriggerClientEvent('chat:addMessage', -1, {
                template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(229, 190, 1, 0.7); border-radius: 10px;"><i class="fab fa-twitter"></i> Ambulance Kronenburg:<br> ' .. table.concat(args, " ") .. '</div>',
            })
        PerformHttpRequest(Config.OverheidsLog, function(err, text, headers) end, 'POST', json.encode({embeds={{title = "Ambulance tweet", description = " **"..GetPlayerName(source).."**: ".. table.concat(args, " ") .."**\nSpeler ID: **"..source.."**\nSteamHex: **"..GetPlayerIdentifier(source).."**\nRang: **"..xPlayer.job.grade_label.."**\nDiscord: **"..discord.."", footer = { text = " © 𝘿𝙧𝙪𝙜𝙖𝙣𝙤𝙫#6843 📅 "..os.date("%d/%m/%Y - %X")},  color=15056385}}}),  { ['Content-Type'] = 'application/json' })
end)


RegisterCommand('id', function(source, args, rawCommand)
    local id = source

    TriggerClientEvent('chat:addMessage', source, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.8); border-radius: 8px;"><b>^*System^r:</b> Je speler ID is: ^*^_{0}^r</div>',
        args = { id }
    })

end, false)

function GetRealPlayerName(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		if true then
			if false then
				return xPlayer.get('firstName')
			else
				return xPlayer.getName()
			end
		else
			return xPlayer.getName()
		end
	else
		return GetPlayerName(source)
	end
end

function havePermission(_source)
	local xPlayer = ESX.GetPlayerFromId(_source)
	local playerGroup = xPlayer.getGroup()
	local isAdmin = false	
	if IsPlayerAceAllowed(_source, "staff") then isAdmin = true end
	
	return isAdmin
end


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

function ExtractIdentifiers(src)
    local identifiers = {
        discord = ""

    }

    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        if string.find(id, "discord") then
            identifiers.discord = id
        end
    end

    return identifiers
end



