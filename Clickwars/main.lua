-- System
local main = {
	last_updated = "15/01/2021",
	ver = "v1.0.0",

	game = {
		BordersShown = false,
		cpsLimit = 12,
		gracePeriod = nil,
		xMax = 150,
		yMax = 150,
	}
}

-- Libs

--[[Zigwin's Coordinates https://atelier801.com/topic?f=6&t=892672&p=1]]
function xyBonus(a,b,c,d)local e=math.abs(a)*1000000+math.abs(b)*100+(a>0 and 0 or 10)+(b>0 and 0 or 1)tfm.exec.addBonus(0,a,b,e,c or 0,main.game.BordersShown,d)return e end;function xyToCoord(f)local g=f%1000000;local h=f%100;local i=f%10;local a=(f-g)/1000000*((h-i)/10==1 and-1 or 1)local b=(g-h)/100*(i==1 and-1 or 1)return a,b end;function xyBonusFill(j,k,l,m)for a=j or 0,l or 800,25 do for b=k or 0,m or 400,25 do xyBonus(a,b)end end end


-- Room settings
tfm.exec.disableAutoScore()
tfm.exec.disableAfkDeath()
tfm.exec.disableDebugCommand()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableMinimalistMode()
tfm.exec.disableMortCommand()


-- Admin
local admin
do local _,name = pcall(nil) admin = string.match(name, "(.-)%.") end


-- Tables
local maps = {
	{
		[[<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="32" H="28" Y="193" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="768" H="28" Y="193" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="768" H="28" Y="386" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="418" H="28" Y="276" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="32" H="28" Y="388" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="232" H="28" Y="83" T="6" /><S P="0,0,0.3,0.2,0,0,0,0" L="65" X="602" H="28" Y="83" T="6" /></S><D /><O /></Z></C>]],
		{
			{420, 250}, {30, 172}, {29, 364}, {230, 56}, {601, 59}, {769, 170}, {770, 361} -- spawn points
		}
	},

	{
		[[<C><P L="4800" MEDATA=";;;;-0;0:::1-"/><Z><S><S T="6" X="32" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1212" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="2352" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3582" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3982" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="768" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1948" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3088" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4318" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4718" Y="193" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="768" Y="386" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1948" Y="386" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3088" Y="386" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4318" Y="386" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4718" Y="386" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="418" Y="276" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1598" Y="276" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="2738" Y="276" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4528" Y="276" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="32" Y="388" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1212" Y="388" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="2352" Y="388" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3582" Y="388" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3982" Y="388" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="232" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1412" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="2552" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="3782" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="602" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="1782" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="2922" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4152" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="6" X="4552" Y="83" L="65" H="28" P="0,0,0.3,0.2,0,0,0,0"/><S T="17" X="1000" Y="284" L="150" H="25" P="0,0,0.3,0.2,0,0,0,0"/><S T="17" X="3350" Y="284" L="150" H="25" P="0,0,0.3,0.2,0,0,0,0"/></S><D/><O/><L/></Z></C>]],
		{
			{1000, 250}, {3350, 250}
		}
	}

}
local playerData = {}
local suspendLogs = {}
local logEvents = {}


-- Misc
function table.random(t)
	return t[math.random(#t)]
end


-- Main
function eventNewPlayer(player)
	system.bindMouse(player, true)

	if not playerData[player] then
		playerData[player] = {
			castedSpirits = {0, 0, 0, false}, -- Timer, Spirits, SuspendedTimes, Suspended
			isFrozen = false,
			isDead = true,
			score = 0
		}
	end

end


function eventPlayerLeft(player)
	playerData[player].isDead = true
	playerData[player].score = 0
end


function eventPlayerDied(player)
	local alive = {}
	playerData[player].isDead = true

	for k,v in next, playerData do
		if not v.isDead then
			alive[#alive + 1] = k
		end
	end

	if #alive == 1 then
		playerData[alive[1]].score = playerData[alive[1]].score + 5
		tfm.exec.setPlayerScore(alive[1], playerData[alive[1]].score, false)
		tfm.exec.setGameTime(5)
		ui.setMapName("<CH>Clickwars - </CH><FC>"..alive[1].." </FC><VP>+5</VP>")
	end
end


function eventPlayerRespawn(player)
	playerData[player].isDead = false
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)
table.foreach(tfm.get.room.playerList, eventPlayerRespawn)


function eventLoop(current, remaining)
	local now = os.time()

	for i = 1, #logEvents do
		if logEvents[i].cd < now then
			ui.removeTextArea(logEvents[i].id, nil)
			table.remove(suspendLogs, i)
		end
	end
	updateLog()


	for k, v in next, playerData do
		v.castedSpirits[1] = v.castedSpirits[1] + 1
		if v.castedSpirits[1] == 2 then
			v.castedSpirits[1] = 0 -- 1 second timer reset
			v.castedSpirits[2] = 0 -- spirits reset
			v.castedSpirits[4] = false -- suspend reset
		end
	end

	if remaining/100 < 0 then
		resetRound()
	end
end


function checkPos(player, x, y)
	local x1, y1 = main.game.xMax, main.game.yMax
	local p = tfm.get.room.playerList[player]

	if x > p.x then
		return (x < p.x + x1) and (y < p.y + y1 and y > p.y - y1)
	else
		return (x > p.x - x1) and (y < p.y + y1 and y > p.y - y1)
	end
end	


function eventMouse(player, x, y)
	local data = playerData[player]
	if data.isDead then return end -- if dead dont execute anything
	if main.game.gracePeriod and main.game.gracePeriod > os.time() - 5000 then return end -- if grace period dont execute anything
	if not checkPos(player, x, y) then return end -- if out of range dont execute anything

	if data.castedSpirits[2] < main.game.cpsLimit then
		tfm.exec.addShamanObject(24, x, y, 0, 0, 0, false)
		data.castedSpirits[2] = data.castedSpirits[2] + 1
	else
		if not data.castedSpirits[4] then
			data.castedSpirits[3] = data.castedSpirits[3] + 1
			data.castedSpirits[4] = true
			suspendLog(player)
		end

		if data.castedSpirits[3] >= 3 then
			if not data.isFrozen then
				system.bindMouse(player, false)
				data.isFrozen = true
				tfm.exec.freezePlayer(player, true)
			else
				return
			end
		end
	end
end


local map
function resetRound()
	for k,v in next, suspendLogs do
		ui.removeTextArea(v.id, nil)
	end
	suspendLogs = {}
	scheduledTasks = {}

	map = table.random(maps)

	for k,v in next, playerData do
		v.isDead = false -- player respawned
		v.castedSpirits = {0, 0, 0, false} -- reset spirits data
		if v.isFrozen then -- if frozen then unfreeze
			tfm.exec.freezePlayer(k, false)
			v.isFrozen = false
			system.bindMouse(k, true)
		end
	end

	tfm.exec.newGame(map[1])
	tfm.exec.setGameTime(90)
end


function eventNewGame()
	local width = tonumber(tfm.get.room.xmlMapInfo.xml:match('<P[^/]+L="([^"]+)"[^/]+/>')) or 800
	local height = tonumber(tfm.get.room.xmlMapInfo.xml:match('<P[^/]+H="([^"]+)"[^/]+/>')) or 400

	xyBonusFill(-40, -40, width+40, -40) -- upper row
	for y = -15, height+40, 25 do -- left row
		xyBonus(-40, y)
	end
	for y = -15, height+40, 25 do -- right row
		xyBonus(width+40, y)
	end

	ui.setMapName("<CH>Clickwars - </CH><N>"..main.ver.."</N> Last Updated: "..main.last_updated)
	local counter = math.random(#map[2])
	local coords = map[2][1]

	for i = 1, #suspendLogs do
		ui.removeTextArea(suspendLogs[i].id)
	end
	suspendLogs = {}
	logEvents = {}


	main.game.gracePeriod = os.time()


	for player in next, playerData do
		tfm.exec.movePlayer(player, coords[1], coords[2], false, 0, 0, false)

		counter = counter + 1
		if counter <= #map[2] then
			coords = map[2][counter]
		else
			counter = 0
			coords = map[2][1]
		end

	end
end


function getLogx(str)
	local x = 700

	if #str > 23 then
		x = x - (7.1*(#str-23))
	elseif #str < 23 then
		x = x + (7.8*(#str-23))
	end

	return x
end


function suspendLog(name)
	local now = os.time()

	if #suspendLogs < 2 then
		suspendLogs[#suspendLogs + 1] = { id = 1000-42+#suspendLogs+1, label = "<R>" .. name .. " was suspended</R>" }

		logEvents[#suspendLogs] = { id = suspendLogs[#suspendLogs].id, cd = now + 3000}

		if #logEvents > 1 then
			logEvents[2].cd = logEvents[1].cd
			logEvents[1].cd = now + 3000
		end
	else
		suspendLogs[3] = { id = 1000-42+3, label = suspendLogs[2].label }
		suspendLogs[2].label = suspendLogs[1].label
		suspendLogs[1].label = "<R>" .. name .. " was suspended</R>"

		logEvents[3] = { id = 1000-42+3, cd = logEvents[2].cd }
		logEvents[2].cd = logEvents[1].cd
		logEvents[1].cd = now + 3000
	end
end


function updateLog()
	for i = 1, #suspendLogs do
		suspendLogs[i].id = 1000-42+i
	end
	for i = 1, #suspendLogs do
		ui.addTextArea(suspendLogs[i].id, suspendLogs[i].label, nil, getLogx(suspendLogs[i].label), 19*i, 0, 0, 0, 0, 1, true)
	end
end


function eventPlayerBonusGrabbed(player, bonusId)
	local x, y = xyToCoord(bonusId)
	tfm.exec.killPlayer(player)
    xyBonus(x, y, 0, player)
end


do
	for k in next, playerData do
		tfm.exec.setPlayerScore(k, playerData[k].score, false) -- set everyone's score to 0 after launch
	end
end
resetRound()