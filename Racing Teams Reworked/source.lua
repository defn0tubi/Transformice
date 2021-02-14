tfm.exec.disableAutoScore()
tfm.exec.disableAfkDeath()
tfm.exec.disableDebugCommand()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
system.disableChatCommandDisplay()

local admin
do local _,name = pcall(nil) admin = string.match(name, "(.-)%.") end

local roles = {}
roles.admin = {}
roles.mod = {}

local maps = {
	['wj'] = {},
	['burlas'] = {7741281,7686258,7686256,7686255,7686253,7686251,7686250,7686248,7686247,7686246,7686245,7686242,7686241,7686234,7686233,7686231,7686230,7686229,7682367,7682365,7682362,7682361,7682358,7682356,7682354,7682351,7680982,7680981,7680978,7679563,7679561,7679560,7679558,7679556,7679087,7679084,7679079,7679078,7679074,7679070,7678148,7677803,7677802,7677801,7677799,7677798,7677797,7677796,7677795,7677794,7677793,7677791,7677790,7677787,7677785,7677782,7676869,7676867,7676862,7676856,7676859,7675766,7675499,7675498,7675496,7675491,7675489,7664114,7664113,7664112,7664111,7664110,7664107,7664106,7664103,7664105,7664102,7661197,7661195,7661194,7661191,7661039,7661038,7661037,7661035,7661031,7661029,7661028,7661026,7661024,7661022,7661019,7661018,7661017,7661015,7661013,7661012,7661011,7661009,7661008,7661005,7660877,7660876,7660875,7660874,7660873,7660871,7660869,7660868,7660866,7660865,7660864,7660863,7660725,7660648,7660647,7660644,7660641,7660640,7660638,7660637,7660636,7660635,7660633,7660632,7660631,7660628,7660627,7660626,7660624,7660623,7660622,7660621,7660619,7660617,7660616,7660428,7660613,7660612,7660436,7660434,7660433,7660430,7660425,7660424,7660421,7660420,7660419,7660417,7660416,7660321,7660320,7660319,7660316,7660314,7660312,7660311,7660308,7660307,7660305,7660301,7660300,7660297,7660295,7660290,7660289,7660287,7660283,7660285,7660282,7660278,7660276,7660270,7660272,7660268,7660167,7660164,7660160,7660398,7660155,7660400,7660401,7660149,7660148,7660146,7660144,7660138,7660132,7659998,7659995,7659994,7659993,7659992,7659991,7659987,7659983,7659980,7659978,7659917,7659921,7659923,7659927,7659933,7659934,7659935,7659937,7659938,7659939,7659941,7659945,7659949,7659951,7659955,7659957,7659958,7659964,7659914,7659681,7659678,7659677,7659742,7659744,7659757,7659747,7659748,7659749,7659751,7659752,7659760,7659762,7659765,7659766,7659768,7659772,7659773,7659774,7659775,7630519,7630522,7630524,7630528,7630532,7630537,7630542,7630545,7630560,7630564,7630565,7630567,7630571,7630588,7630591,7630593,7630595,7630596,7630607,7630612,7630634,7630646,7630648,7630650,7630657,7630662,7630664,7630668,7630669,7630670,7630673,7630675,7630677,7635526,7635528,7635533,7635534,7635535,7635536,7635537,7635538,7635539,7635540,7635541,7635542,7635544,7635545,7635546,7635547,7635549,7635550,7635551,7635552,7635553,7635555,7635556,7635560,7664101,7635563,7635566,7635567,7635568,7635570},
	['vanilla'] = {'#87'},
	['bootcamp'] = {'#13', '#3'},
	['defilante'] = {'#18'},
	['racing'] = {'#17'},
	['custom1'] = {},
	['custom2'] = {},
	['custom3'] = {},
	['custom4'] = {},
	['custom5'] = {},
	['custom6'] = {}
}

local room = {
	mode,
	toWin = 20,
	winner,
	playerData = {},
	mapQueue = {},
	rainbowNames = {},
	chosenMapList = {},
	addAfter = 10, -- add map back to maplist after 10 rounds
	mapsToAdd = {},
	currentMap,
	pause = { paused = false, time = 0, reason = "" },
	time = 0,
	isFirst = false,
	gameRunning = false,
	teamColorToChange,
	settings = {
		autoJoin = false,
		turboMode = false,
		noSouris = false,
		respawn = false
	},
	sessionTime = 0,
	mice = { total = 0, alive = 0},
	teamIndex = 1
}

local teams = {
	[1] = { players = {}, color = "bf19a9", points = 0 },
	[2] = { players = {}, color = "F4EA0E", points = 0 },
	[3] = { players = {}, color = "FFE0AF", points = 0 },
	[4] = { players = {}, color = "AFFFFD", points = 0 },
	[5] = { players = {}, color = "CD3D09", points = 0 },
	[6] = { players = {}, color = "39D358", points = 0 },
	[7] = { players = {}, color = "F33A76", points = 0 },
	[8] = { players = {}, color = "2A51EC", points = 0 }
}

local hub = [[<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" X="397" L="3000" o="0" H="3000" c="4" Y="195" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="0" X="400" H="29" Y="386" T="12" /><S P="0,0,0.3,0.2,-90,0,0,0" L="800" o="0" X="16" H="29" Y="-3" T="12" /><S P="0,0,0.3,0.2,-180,0,0,0" L="800" o="0" X="399" H="29" Y="0" T="12" /><S P="0,0,0.3,0.2,-270,0,0,0" L="800" o="0" X="786" H="29" Y="1" T="12" /></S><D><DS Y="362" X="70" /></D><O /></Z></C>]]

local rainbowColors = {"EB0C0C","EB790C","EBE70C","0DEB0C","0CC2EB","214AED","B221ED"}

--[[ \\ ]]
table.find = function(tbl, val)
	for k,v in next, tbl do
	   if v == val then
		  return true
	   end
	end
	return false
end


table.index = function(tbl, val)
	for k, v in next, tbl do
		if v == val then
			return k
		end
	end
	return false
end


string.title = function(str)
    return (str:gsub("^%l", string.upper))
end


formatMap = function(map)
	return map:gsub("@", "")
end


resetGame = function()
	room.teamIndex = 1
	room.gameRunning = false
	room.winner = nil
	room.chosenMapList = {}
	room.mapQueue = {}
	for i = 1, room.mode do
		teams[i].points = 0
		teams[i].players = {}
	end
	room.sessionTime = 0
	room.playerData = {}
	room.pause = { paused = false, time = 0, reason = "" }
	room.settings = {
		autoJoin = false,
		turboMode = false,
		noSouris = false,
		respawn = false
	}
	for k in next, tfm.get.room.playerList do
		eventNewPlayer(k)
	end
	helperDisplay(false)

	ui.addTextArea(-420, "<a href='event:2teams'><p align='center'><font size='16' color='#E6E6E6'>2 Teams</font></p></a>", admin, 340, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-421, "<a href='event:4teams'><p align='center'><font size='16' color='#E6E6E6'>4 Teams</font></p></a>", admin, 340, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-422, "<a href='event:8teams'><p align='center'><font size='16' color='#E6E6E6'>8 Teams</font></p></a>", admin, 340, 160, 100, 0, 0x000001, 0x000001, 0.55, true)
end


replayGame = function()
	room.winner = nil
	for i = 1, room.mode do
		teams[i].points = 0
	end
	room.sessionTime = 0
	room.pause = { paused = false, time = 0, reason = "" }
end


newMap = function(extra)
	local start = os.time()
	if not pause then
		nextMap = room.chosenMapList[math.random(#room.chosenMapList)]

		if #room.mapQueue > 0 then -- pick map from queue
			if extra and extra.code then return end
			nextMap = room.mapQueue[1]
			table.remove(room.mapQueue, 1)
		end
	end

	if extra then
		if extra.code then nextMap = extra.code end
		print("\n<VI>[NewMap] <N>-> <VI>Forced Switch <N>(!"..extra.command..") by <BL>"..extra.player.."\n<N>Map found in <VP>"..((os.time() - start)).."</VP> ms -> <PS>@"..nextMap)
	else
		print("\n<VI>[NewMap] <N>-> <VI>Normal Switch\n<N>Map found in <VP>"..((os.time() - start)).."</VP> ms -> <PS>@"..nextMap)
	end

	tfm.exec.newGame(nextMap)
end


createTeams = function()
	for player in next, tfm.get.room.playerList do
		if not room.playerData[player].inGame then
			teams[room.teamIndex].players[#teams[room.teamIndex].players + 1] = player
			room.playerData[player].team = room.teamIndex
			room.teamIndex = room.teamIndex == room.mode and 1 or room.teamIndex + 1
			room.playerData[player].inGame = true
		end
	end

end


teamDisplay = function(show)
	if show then
		for i = 1, room.mode do
			if #teams[i].players >= 1 then
				ui.updateTextArea(i,"<p align='center'><font size='14' color='#E6E6E6'><u>Team "..i.."</u></font>\n<font color='#E6E6E6'>━━━━━━━━━━━━━━━━━━</font>\n<font color='#"..teams[i].color.."'>"..table.concat(teams[i].players, "\n").."</font></p>", nil)
			else
				ui.updateTextArea(i,"<p align='center'><font size='14' color='#E6E6E6'><u>Team "..i.."</u></font>\n<font color='#E6E6E6'>━━━━━━━━━━━━━━━━━━</font>\n<font color='#E6E6E6'>No players :(</font></p>", nil)
			end
		end
	else
		for i = 1, room.mode do
			ui.removeTextArea(i)
		end
	end
end


setNameColors = function()
	for i = 1, room.mode do
		for k, v in next, teams[i].players do
			tfm.exec.setNameColor(v, "0x"..teams[i].color)
		end
	end
	
end


modesDisplay = function(show)
	if show then
		local id, x, y = -1110, 1, 1
		for mode in next, maps do
			id = id - 1
			local m = string.title(mode)
			ui.addTextArea(id, "<a href='event:"..mode.."'><p align='center'><font size='16' color='#E6E6E6'>"..m.."</font></p></a>", admin, 110+120*x, 240-40*y, 100, 0, 0x000001, 0x000001, 0.55, true)
			y = x < 3 and y + 0 or y + 1
			x = x < 3 and x + 1 or 1
		end
	else
		local mapsLength = 0
		for _ in next, maps do
			mapsLength = mapsLength + 1
		end
		for i = -1111, -1111-mapsLength, -1 do
			ui.removeTextArea(i)
		end
	end
end


settingsDisplay = function(show)
	if show then
		local id, x, y = -2222, 1, 1
		for i = -1111, -1122, -1 do
			ui.removeTextArea(i)
		end
		for k, v in next, room.settings do
			local val = v and "<VP>ON</VP>" or "<R>OFF</R>"
			ui.addTextArea(id, "<a href='event:settings_"..k.."'><p align='center'><font size='16' color='#E6E6E6'>"..k..": "..val.."</font></p></a>", admin, 60+170*x, 200-40*y, 150, 0, 0x000001, 0x000001, 0.55, true)
			id = id - 1
			x = y < 3 and x + 0 or x + 1
			y = y < 3 and y + 1 or 1
		end
	else
		local settingsLength = 0
		for _ in next, room.settings do
			settingsLength = settingsLength + 1
		end
		for i = -2222, -2222-settingsLength, -1 do
			ui.removeTextArea(i)
		end
	end
end


scoreDisplay = function()
	local str = "<font size='16'>"
	local x = 370
	if room.mode == 4 then x = 330 elseif room.mode == 8 then x = 280 end
	for i = 1, room.mode do
		if i == room.mode then
			str = str .. "<font color='#"..teams[i].color.."'><b>"..teams[i].points.."</b> <N>/</N> <VI><b>"..room.toWin.."</b></VI></font>"
		else
			str = str .. "<font color='#"..teams[i].color.."'><b>"..teams[i].points.."</b> <N>x</N> </font>"
		end
	end

	for k, v in next, room.playerData do
		if v.ui.scoreToggled then
			ui.addTextArea(-912841, str, k, x, 25, 0, 0, 0x000001, 0x000001, 0.1, true)
		end
	end
end


setNameColors = function()
	for i = 1, room.mode do
		for i = 1, #teams[i].players do
			tfm.exec.setNameColor(teams[i].players[i], "0x"..teams[i].color)
		end
	end
end


secondsToClock = function(x)
	local ms = tonumber(x)
	local min = math.floor(ms/60)
	local sec = ms%60
	if sec < 10 then
		sec = "0"..tostring(sec)
	end
	return min..":"..sec
end


putToSmallestTeam = function(player)
	local min = 1
	for i = 2, room.mode do
		if #teams[i].players < #teams[min].players then
			min = i
		end
	end
	room.playerData[player].team = min
	teams[min].players[#teams[min].players + 1] = player
	room.playerData[player].inGame = true
end


helperDisplay = function(show, player)
	if show then
		ui.addTextArea(-478172, "<font size='16' color='#E6E6E6'><a href='event:h_skip'>S</a></font>", player, -46, 5, 0, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-478173, "<font size='16' color='#E6E6E6'><a href='event:h_repeat'>R</a></font>", player, -21, 5, 0, 0, 0x000001, 0x000001, 0.55, true)
	else
		for i = -478172, -478173, -1 do
			ui.removeTextArea(i, player)
		end
	end
end


pauseDisplay = function(show, text)
	if show then
		ui.addTextArea(-77761247, "", nil, -12000, -12000, 32000, 32000, 0x545557, 0x000000, 0.4, true)
		ui.addTextArea(-77761248, "<p align='center'><font face='Verdana' color='#eff1f2'><font size='48'>The game is paused</font>\n<font size='16' face='Verdana' color='#eff1f2'>____________________________________________________________</font></p>", nil, 100, 100, 0, 0, 0, 0, 1, true)
		ui.addTextArea(-77761249, "<p align='center'><font face='Verdana' color='#eff1f2' size='24'>"..text.."</font></p>", nil, 100, 190, 600, 200, 0, 0, 1, true)
	else
		for i = -77761247, -77761249, -1 do
			ui.removeTextArea(i)
		end
	end
end
--[[ // ]]


--[[ Commands ]]
local commands = {}

commands.mod = {
	permissions = {'admin'},

	event = function(playerData, cmd_args)
		if not cmd_args[2] then return end

		if cmd_args[2] == 'add' then
			if cmd_args[3] and tfm.get.room.playerList[cmd_args[3]] and not table.find(roles.mod, cmd_args[3]) then
				roles.mod[#roles.mod + 1] = cmd_args[3]
				print("\n<VI>[Mod] <BL>"..cmd_args[3].." <N>has been added to mods")
				helperDisplay(true, cmd_args[3])
			end
		elseif cmd_args[2] == 'remove' then
			if cmd_args[3] and table.find(roles.mod, cmd_args[3]) then
				table.remove(roles.mod, table.index(roles.mod, cmd_args[3]))
				print("\n<VI>[Mod] <BL>"..cmd_args[3].." <N>has been removed from mods")
				helperDisplay(false, cmd_args[3])
			end
		end
	end
}

commands.team = {
	permissions = {'admin', 'mod'},

	event = function(playerData, cmd_args)
		if not cmd_args[3] or not cmd_args[2] then return end
		local n = tonumber(cmd_args[2])

		if cmd_args[3] and n and teams[n] and n <= room.mode and n >= 1 then
			for i = 1, #teams do
				for j = 3, #cmd_args do
					local player = cmd_args[j]
					if table.find(teams[i].players, player) then
						local pos = table.index(teams[i].players, player)
						table.remove(teams[i].players, pos)
						room.playerData[player].inGame = false
					end
				end
			end

			for i = 3, #cmd_args do
				for player in next, tfm.get.room.playerList do
					if cmd_args[i] == player then
						teams[n].players[#teams[n].players + 1] = cmd_args[i]
						room.playerData[player].inGame = true
					end
				end
			end

		elseif cmd_args[2] and n and teams[n] and #teams[n].players > 0 then
			for i = 1, #teams[n].players do
				room.playerData[teams[n].players[1]] = false
				table.remove(teams[n].players, 1)
			end
		end

		room.teamIndex = n == 8 and 1 or n + 1
		teamDisplay(true)
	end
}

commands.reset = {
	permissions = {'admin', 'mod'},

	event = function()
		resetGame()
	end
}

commands.replay = {
	permissions = {'admin', 'mod'},

	event = function()
		replayGame()
	end
}

commands.queue = {
	permissions = {'admin', 'mod'},

	event = function(playerData, cmd_args)
		if cmd_args[2] then
			local map = formatMap(cmd_args[2])
			if map then
				room.mapQueue[#room.mapQueue + 1] = map
				print("Map "..map.." was added")
			else
				print('Error formatting map code')
			end
		end
	end
}

commands.skip = {
	permissions = {'admin', 'mod'},

	event = function(playerData)
		newMap({ forced = true, player = playerData.name, command = "skip"})
	end
}

commands.rep = {
	permissions = {'admin', 'mod'},

	event = function(playerData)
		newMap({ forced = true, player = playerData.name, code = room.currentMap, command = "rep"})
	end
}

commands.to = {
	permissions = {'admin', 'mod'},

	event = function(playerData, cmd_args)
		if not cmd_args[2] or not tonumber(cmd_args[2]) then return end
		room.toWin = tonumber(cmd_args[2])
		scoreDisplay()
	end
}

commands.pset = {
	permissions = {'admin', 'mod'},

	event = function(playerData, cmd_args)
		if not cmd_args[2] or not cmd_args[3] then return end
		local team = tonumber(cmd_args[2])
		local toSet = tonumber(cmd_args[3])
		if not team or not toSet then return end
		if team >= 1 and team <= room.mode then
			teams[team].points = toSet
		end
		scoreDisplay()
	end
}

commands.pause = {
	permissions = {'admin', 'mod'},

	event = function(playerData, cmd_args)
		room.pause.paused = not room.pause.paused
		if room.pause.paused then
			room.gameRunning = false
			room.pause.paused = true
			room.pause.reason = cmd_args[2] and table.concat(cmd_args, ' ', 2) or "We'll be right back"
			pauseDisplay(true, room.pause.reason)
		else
			room.gameRunning = true
			room.pause.paused = false
			tfm.exec.setGameTime(math.ceil(room.time+room.pause.time/2))
			pauseDisplay(false)
			room.pause.time = 0
		end
	end

}

commands.settings = {
	permissions = {'admin'},

	event = function(playerData, cmd_args)
		playerData.ui.settings = not playerData.ui.settings
		settingsDisplay(playerData.ui.settings)
	end
}

commands.tsc = {
	event = function(playerData, cmd_args)
		playerData.ui.scoreToggled = not playerData.ui.scoreToggled
		scoreDisplay()
	end
}


commands.cheese = {
	permissions = {'admin', 'mod'},

	event = function(playerData)
		local cmd
		if tfm.get.room.playerList[playerData.name].hasCheese then cmd = tfm.exec.removeCheese else cmd = tfm.exec.giveCheese end
		cmd(playerData.name)
	end
}

commands.win = {
	permissions = {'admin', 'mod'},

	event = function(playerData, cmd_args)
		local target = cmd_args[2] and cmd_args[2] or playerData.name
		tfm.exec.giveCheese(target)
		tfm.exec.playerVictory(target)
	end
}
--[[ // Commands // ]]

--[[ \\ ]]
eventNewPlayer = function(player)
	room.mice.total = room.mice.total + 1

	if not room.playerData[player] then
		room.playerData[player] = {
			name = player,
			inGame = false,
			points = 0,
			team = 0,

			attr = {
				hasTfm = false,
				hasConj = false,
				banned = false
			},

			ui = {
				scoreToggled = true,
				settings = false
			},

			images = {}
		}
	end

	if room.settings.autoJoin then
		if room.gameRunning and room.playerData[player].team == 0 then
			putToSmallestTeam(player)
		end

		scoreDisplay()
	end

	if room.pause.paused then
		pauseDisplay(true, room.pause.reason)
	end
end


eventPlayerLeft = function(player)
	room.mice.total = room.mice.total - 1
	room.mice.alive = room.mice.alive - 1
end


eventPlayerRespawn = function(player)
	room.mice.alive = room.mice.alive + 1
end


eventPlayerDied = function(player)
	room.mice.alive = room.mice.alive - 1
	if room.mice.alive <= 0 then
		newMap()
	end
	if room.settings.respawn then
		tfm.exec.respawnPlayer(player)
	end
end


eventPlayerWon = function(player)
	local data = room.playerData[player]
	room.mice.alive = room.mice.alive - 1
	if not room.isFirst and not room.pause.paused and room.gameRunning then
		tfm.exec.setPlayerScore(player, 1, true)
		room.isFirst = true
		data.points = data.points + 1
		teams[data.team].points = teams[data.team].points + 1
		room.time = 4
		if teams[data.team].points >= room.toWin then
			room.winner = data.team
			room.gameRunning = false
			
			tfm.exec.newGame(hub)
			helperDisplay(false, nil)
			local MVP
			local highest = -1
			for k,v in next, teams[room.winner].players do
				if highest < room.playerData[v].points then
					highest = room.playerData[v].points
					MVP = v
				end
			end
			for k, v in next, room.playerData do
				local team = v.team and v.team or "Did not participate"
				local color = teams[v.team].color and teams[v.team].color or "eff1f2"
				ui.addTextArea(9, "<p align='center'><font size='20' face='Consolas'><font color='#eff1f2'>Team <font color='#"..teams[room.winner].color.."'>"..room.winner.."</font> won\n<font size='10'><N>Session time: "..secondsToClock(math.ceil(room.sessionTime/2)).."</N></font>\n\n<font size='16'><p align='left'><O>MVP</O>: "..MVP.." | <O>"..highest.."</O> points\n<VP>Last point</VP>: "..player.."\n\n\n\nYour points: <T>"..v.points.."</T> (Team <font color='#"..color.."'>"..team.."</font>)</p></font></font></font>", k, 230, 80, 400, 200, 0x000000, 0x000000, 0.55, true)
			end
		end
		scoreDisplay()
		if room.settings.turboMode then
			newMap()
		else
			tfm.exec.setGameTime(3)
		end
	end
end


eventChatCommand = function(player, command)
	local cmd_args = {}
	local cout = 0
	for arg in command:gmatch("[^%s]+") do
		cout = cout + 1
		cmd_args[cout] = arg
	end

	if commands[cmd_args[1]] then
		local continue = false
		if not commands[cmd_args[1]].permissions then
			continue = true
		else
			for _, role in next, commands[cmd_args[1]].permissions do
				if table.find(roles[role], player) then
					continue = true
					break
				end
			end
		end
		if continue then
			commands[cmd_args[1]].event(room.playerData[player], cmd_args)
		else
			print("\n<BL>["..player.."]</BL> <R>Insufficient permissions for <N>!"..cmd_args[1].."</N> command</R>")
		end
	end

end


eventNewGame = function()
	room.time = 120
	room.isFirst = false
	setNameColors()
	if not tfm.get.room.xmlMapInfo then
		error("<VI>[eventNewGame] <N>-> Could not find current map code, switching to hub")
		room.currentMap = hub
	else
		room.currentMap = tfm.get.room.xmlMapInfo.mapCode
	end
	if table.index(room.chosenMapList, room.currentMap) then
		table.remove(room.chosenMapList, table.index(room.chosenMapList, room.currentMap))
		room.mapsToAdd[#room.mapsToAdd + 1] = { code = room.currentMap, round = 0 }
		print("\n<VI>[NoRepeat] <N>-> <VI>Map Removed <N>{\n\t<PS>@"..room.currentMap.." <N>was removed from the maplist\n}")
	end

	local changedMaps = {}
	for k, v in next, room.mapsToAdd do
		v.round = v.round + 1
		if v.round >= room.addAfter then
			changedMaps[#changedMaps + 1] = v
		end
	end
	for k, v in next, changedMaps do -- add maps back to maplist 
		table.remove(room.mapsToAdd, k)
		room.chosenMapList[#room.chosenMapList + 1] = v.code
		print("\n<VI>[NoRepeat] <N>-> <VI>Map Added <N>{\n\t<PS>@"..room.currentMap.." <N>was added to the maplist\n}")
	end

	room.mice.alive = 0
	for k,v in next, tfm.get.room.playerList do
		if not v.isDead then
			room.mice.alive = room.mice.alive + 1
		end
	end
end


eventTextAreaCallback = function(ID, player, callback)
	if callback:sub(2) == "teams" then
		room.mode = tonumber(callback:sub(1, 1))
		local mode = room.mode
		local size = mode == 8 and {202, 139} or {202, 278}
		local coords = {
			[2] = { {5, 30}, {592, 30} },
			[4] = { {-250, 30}, {5, 30}, {592, 30}, {850, 30} },
			[8] = { {-250, 30}, {5, 30}, {592, 30}, {850, 30}, {-250, 232}, {5, 232}, {592, 232}, {850, 232} }
		}
		for i = 1, mode do
			local x = coords[mode][i][1]
			local y = coords[mode][i][2]
			ui.addTextArea(i, "", nil, x, y, size[1], size[2], 0x000001, "0x"..teams[i].color, 0.55, true)
		end

		ui.addTextArea(-43, "<a href='event:fill'><p align='center'><font size='16' color='#E6E6E6'>Fill</font></p></a>", admin, 350, 320, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", admin, 350, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-46, "<a href='event:clear'><p align='center'><font size='16' color='#E6E6E6'>Clear</font></p></a>", admin, 350, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-47, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", admin, 230, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: None</font></p>", nil, 230, 40, 340, 0, 0x000001, 0x000001, 0.55, true)

		ui.removeTextArea(-420)
		ui.removeTextArea(-421)
		ui.removeTextArea(-422)

		teamDisplay(true)

	elseif callback == "fill" then
		createTeams()
		teamDisplay(true)

	elseif callback == "clear" then
		room.teamIndex = 1
		for i = 1, room.mode do
			for x = 1, #teams[i].players do
				room.playerData[teams[i].players[1]].inGame = false
				room.playerData[teams[i].players[1]].team = 0
				table.remove(teams[i].players, 1)
			end
		end

		teamDisplay(true)

	elseif callback == "map" then
		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-45, "<a href='event:closemap'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", admin)
		ui.updateTextArea(-47, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", admin)
		settingsDisplay(false)
		modesDisplay(true)

	elseif callback == "closemap" then
		modesDisplay(false)
		ui.removeTextArea(-1123)
		ui.updateTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", admin)

	elseif maps[callback] and #maps[callback] > 0 then
		room.chosenMapList = maps[callback]
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: "..string.title(callback).."</font></p>", nil)

	elseif callback:sub(1, 8) == "settings" then
		if callback:sub(9) == "_on" then
			settingsDisplay(true)
			ui.updateTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", admin)
			ui.updateTextArea(-47, "<a href='event:settings_off'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", admin)

		elseif callback:sub(9) == "_off" then
			settingsDisplay(false)
			ui.updateTextArea(-47, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", admin)

		else
			local setting = callback:sub(10)
			room.settings[setting] = not room.settings[setting]
			if setting == "autoJoin" and room.settings.autoJoin then
				for k, v in next, room.playerData do
					if v.team == 0 then
						putToSmallestTeam(k)
					end
				end
			end
			teamDisplay(true)
			settingsDisplay(true)
		end


	elseif callback == "play" then
		room.gameRunning = true
		for i = -43, -47, -1 do
			ui.removeTextArea(i)
		end
		ui.removeTextArea(-1123)
		teamDisplay(false)
		modesDisplay(false)
		settingsDisplay(false)
		scoreDisplay()
		setNameColors()
		newMap()
		helperDisplay(true, player)

	elseif callback == "h_skip" then
		newMap({ forced = true, player = player, command = "skip"})

	elseif callback == "h_repeat" then
		newMap({ forced = true, player = player, code = room.currentMap, command = "repeat"})
	end
end


eventLoop = function(time, remaining)
	if not room.pause.paused and room.gameRunning then
		room.sessionTime = room.sessionTime + 1
		room.time = room.time - 0.5

		if remaining < 500 then
			newMap()
		end
	else
		room.pause.time = room.pause.time + 0.5
	end
end
--[[ // ]]

loadRoom = function()
	roles.admin[#roles.admin + 1] = admin
	for name, v in next, tfm.get.room.playerList do
		eventNewPlayer(name)

		room.mice.total = room.mice.total + 1
		if not v.isDead then
			room.mice.alive = room.mice.alive + 1
		end
	end
end


loadRoom()

ui.addTextArea(-420, "<a href='event:2teams'><p align='center'><font size='16' color='#E6E6E6'>2 Teams</font></p></a>", admin, 340, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
ui.addTextArea(-421, "<a href='event:4teams'><p align='center'><font size='16' color='#E6E6E6'>4 Teams</font></p></a>", admin, 340, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
ui.addTextArea(-422, "<a href='event:8teams'><p align='center'><font size='16' color='#E6E6E6'>8 Teams</font></p></a>", admin, 340, 160, 100, 0, 0x000001, 0x000001, 0.55, true)
