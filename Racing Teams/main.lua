
local toWin = 20

local init_time = 90 -- round time in seconds

Maps = {
	["WJ"] = {324428,4192147,6119641,6119642,6119643,6119655,6120650,6133176,6146352,6274154,6641061,6641085,7465241,7485501,6799629,6755943,7627933,7628267,7628262,7628264,7628265,7627928,7627934,7627939,7600732,7601742,7601755,7627935,7601758,7608215,7608225,7608227,7628299,7627953,7627955,7627957,7574934,7630264,7630265,7630266,7630269},
	["Burlas"] = {7741281,7686258,7686256,7686255,7686253,7686251,7686250,7686248,7686247,7686246,7686245,7686242,7686241,7686234,7686233,7686231,7686230,7686229,7682367,7682365,7682362,7682361,7682358,7682356,7682354,7682351,7680982,7680981,7680978,7679563,7679561,7679560,7679558,7679556,7679087,7679084,7679079,7679078,7679074,7679070,7678148,7677803,7677802,7677801,7677799,7677798,7677797,7677796,7677795,7677794,7677793,7677791,7677790,7677787,7677785,7677782,7676869,7676867,7676862,7676856,7676859,7675766,7675499,7675498,7675496,7675491,7675489,7664114,7664113,7664112,7664111,7664110,7664107,7664106,7664103,7664105,7664102,7661197,7661195,7661194,7661191,7661039,7661038,7661037,7661035,7661031,7661029,7661028,7661026,7661024,7661022,7661019,7661018,7661017,7661015,7661013,7661012,7661011,7661009,7661008,7661005,7660877,7660876,7660875,7660874,7660873,7660871,7660869,7660868,7660866,7660865,7660864,7660863,7660725,7660648,7660647,7660644,7660641,7660640,7660638,7660637,7660636,7660635,7660633,7660632,7660631,7660628,7660627,7660626,7660624,7660623,7660622,7660621,7660619,7660617,7660616,7660428,7660613,7660612,7660436,7660434,7660433,7660430,7660425,7660424,7660421,7660420,7660419,7660417,7660416,7660321,7660320,7660319,7660316,7660314,7660312,7660311,7660308,7660307,7660305,7660301,7660300,7660297,7660295,7660290,7660289,7660287,7660283,7660285,7660282,7660278,7660276,7660270,7660272,7660268,7660167,7660164,7660160,7660398,7660155,7660400,7660401,7660149,7660148,7660146,7660144,7660138,7660132,7659998,7659995,7659994,7659993,7659992,7659991,7659987,7659983,7659980,7659978,7659917,7659921,7659923,7659927,7659933,7659934,7659935,7659937,7659938,7659939,7659941,7659945,7659949,7659951,7659955,7659957,7659958,7659964,7659914,7659681,7659678,7659677,7659742,7659744,7659757,7659747,7659748,7659749,7659751,7659752,7659760,7659762,7659765,7659766,7659768,7659772,7659773,7659774,7659775,7630519,7630522,7630524,7630528,7630532,7630537,7630542,7630545,7630560,7630564,7630565,7630567,7630571,7630588,7630591,7630593,7630595,7630596,7630607,7630612,7630634,7630646,7630648,7630650,7630657,7630662,7630664,7630668,7630669,7630670,7630673,7630675,7630677,7635526,7635528,7635533,7635534,7635535,7635536,7635537,7635538,7635539,7635540,7635541,7635542,7635544,7635545,7635546,7635547,7635549,7635550,7635551,7635552,7635553,7635555,7635556,7635560,7664101,7635563,7635566,7635567,7635568,7635570},
	["Vanilla"] = {},
	["Bootcamp"] = {'#13', '#3'},
	["Defilante"] = {'#18'},
	["Random"] = {},
	["Racing"] = {'#17'},
	["Custom1"] = {},
	["Custom2"] = {},
	["Custom3"] = {},
	["Custom4"] = {},
	["Custom5"] = {},
}


-- stuff --
tfm.exec.disableAutoScore()
tfm.exec.disableAfkDeath()
tfm.exec.disableDebugCommand()
tfm.exec.disablePhysicalConsumables()
tfm.exec.disableAutoShaman()
tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()

local mode = "none"
local Admin
do local _,name = pcall(nil) Admin = string.match(name, "(.-)%.") end

local playersInGame = {}
local bannedPlayers = {}
local MapQueue = {}
local rainbowNames = {}
local playerData = {}
local ChosenMapList = {}

local Pause = false
local Is_First = false
local Game_Running = false
local team_color_to_change

local Auto_Join = false
local Anti_Souris = false
local Turbo_Mode = false
local g_sixLoop = false

local hub = [[<C><P /><Z><S><S P="0,0,0.3,0.2,0,0,0,0" X="397" L="3000" o="0" H="3000" c="4" Y="195" T="12" /><S P="0,0,0.3,0.2,0,0,0,0" L="800" o="0" X="400" H="29" Y="386" T="12" /><S P="0,0,0.3,0.2,-90,0,0,0" L="800" o="0" X="16" H="29" Y="-3" T="12" /><S P="0,0,0.3,0.2,-180,0,0,0" L="800" o="0" X="399" H="29" Y="0" T="12" /><S P="0,0,0.3,0.2,-270,0,0,0" L="800" o="0" X="786" H="29" Y="1" T="12" /></S><D><DS Y="362" X="70" /></D><O /></Z></C>]]

local mice = {
	alive = 0,
	total = 0
}

function mice:cAlive()
	self.alive = 0
	for i,v in next, tfm.get.room.playerList do
		if not v.isDead and contains(playersInGame, i, 'index') then
			self.alive = self.alive + 1
		end
	end
end

function mice:cTotal()
	self.total = 0
	for i,v in next, tfm.get.room.playerList do
		self.total = self.total + 1
	end
end


local gameTime = {
	time = init_time,
	counter = 0
}
local sessionTime = 0
-- stuff --


Teams = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
	[5] = {},
	[6] = {},
	[7] = {},
	[8] = {},
}
points = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0,
	[7] = 0,
	[8] = 0,
}
colors = {
	[1] = 'bf19a9',
	[2] = 'F4EA0E',
	[3] = 'FFE0AF',
	[4] = 'AFFFFD',
	[5] = 'CD3D09',
	[6] = '39D358',
	[7] = 'F33A76',
	[8] = '2A51EC',
}
rainbowColors = {
	"EB0C0C",
	"EB790C",
	"EBE70C",
	"0DEB0C",
	"0CC2EB",
	"214AED",
	"B221ED"
}
system.disableChatCommandDisplay()


-- custom functions --
function secondsToClock(x)
	local ms = tonumber(x)
	local min = math.floor(ms/60)
	local sec = ms%60

	if sec < 10 then
		sec = "0"..tostring(sec)
	end

	return min..":"..sec

end

function contains(exampletable, element, by)

	by = by or 'value'

	if by == 'value' then

		for i,v in next, exampletable do
			if v == element then
				return true
			end
		end

	elseif by == 'index' then

		for i,v in next, exampletable do
			if i == element then
				return true
			end
		end
	end

end


function index(exampletable, element)

	for i,v in next, exampletable do
		if v == element then
			return i 
		end
	end

end


function set()

	local ret = {}
	for _,k in ipairs({}) do 
		ret[k] = true 
	end
	return ret

 end


function string.split(str, delimiter)
    local delimiter,a = delimiter or ',', {lay}
    for part in str:gmatch('[^'..delimiter..']+') do
        a[#a+1] = part
    end
    return a
end


team_index = 1
function CreateTeams()

	if mode == "2teams" then

		for name in next, tfm.get.room.playerList do
			if not playersInGame[name] then
				Teams[team_index][#Teams[team_index]  + 1] = name
				if team_index == 2 then team_index = 0 end
				team_index = team_index + 1
				playersInGame[name] = true
			end
		end

	end

	if mode == "4teams" then

		for name in next, tfm.get.room.playerList do
			if not playersInGame[name] then
				Teams[team_index][#Teams[team_index]  + 1] = name
				if team_index == 4 then team_index = 0 end
				team_index = team_index + 1
				playersInGame[name] = true
			end
		end

	end

	if mode == "8teams" then

		for name in next, tfm.get.room.playerList do
			if not playersInGame[name] then
				Teams[team_index][#Teams[team_index]  + 1] = name
				if team_index == 8 then team_index = 0 end
				team_index = team_index + 1
				playersInGame[name] = true
			end
		end

	end

	SetNameColors()

end

function SetNameColors()

	for player in next, tfm.get.room.playerList do
		for i = 1, #Teams do
			if contains(Teams[i], player) then
				tfm.exec.setNameColor(player, "0x"..colors[i])
			end
		end
	end

end

function TeamDisplay()

	for i = 1, tonumber(string.sub(mode,1,1)) do
		if #Teams[i] >= 1 then
			ui.updateTextArea(i-1,"<p align='center'><font size='14' color='#E6E6E6'><u>Team "..i.."</u></font>\n<font color='#E6E6E6'>━━━━━━━━━━━━━━━━━━</font>\n<font color='#"..colors[i].."'>"..table.concat(Teams[i], "\n").."</font></p>", nil)
		else
			ui.updateTextArea(i-1,"<p align='center'><font size='14' color='#E6E6E6'><u>Team "..i.."</u></font>\n<font color='#E6E6E6'>━━━━━━━━━━━━━━━━━━</font>\n<font color='#E6E6E6'>No players :(</font></p>", nil)
		end
	end

end


local HiddenMap, currentMap, nextMap = ..., currentMap or "Hub", ...
function newMap()

	if not Pause then
		if #MapQueue < 1 then
			for i,v in next, ChosenMapList do
				if v == currentMap then
					HiddenMap = v
					table.remove(ChosenMapList, i)
					break
				end
			end

			nextMap = ChosenMapList[math.random(#ChosenMapList)]

			if HiddenMap then
				ChosenMapList[#ChosenMapList + 1] = HiddenMap
			end

		elseif #MapQueue > 0 then
			nextMap = MapQueue[1]
			table.remove(MapQueue, 1)
		end

		tfm.exec.newGame(nextMap)

	end

end

function newGame()

	for i = 1, #Teams do
		points[i] = 0
		Teams[i] = {}
	end

	playersInGame = {}
	winnersTeam = nil
	mode = "none"
	ui.addTextArea(-420, "<a href='event:2teams'><p align='center'><font size='16' color='#E6E6E6'>2 Teams</font></p></a>", Admin, 340, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-421, "<a href='event:4teams'><p align='center'><font size='16' color='#E6E6E6'>4 Teams</font></p></a>", Admin, 340, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-422, "<a href='event:8teams'><p align='center'><font size='16' color='#E6E6E6'>8 Teams</font></p></a>", Admin, 340, 160, 100, 0, 0x000001, 0x000001, 0.55, true)

end


function playerCheck()

	for i,v in next, tfm.get.room.playerList do
		if not playersInGame[i] then
			tfm.exec.killPlayer(i)
		end
		if Anti_Souris then
			if string.sub(i, 1, 1) == "*" then
				tfm.exec.killPlayer(i)
			end
		end
	end

end


function displayScore(name)

	if mode == "2teams" then
		if playerData[name].ui.scoreToggled then
			ui.addTextArea(-912841, string.format("<font size='18' face='Consolas'><font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>/</N></b> <VI><b>%s</b></VI></font>", colors[1], points[1], colors[2], points[2], toWin), nil, 350, 20, 0, 0, 0x000001, 0x000001, 0.1, true)
		else
			ui.removeTextArea(-912841, name)
		end
	end

	if mode == "4teams" then
		if playerData[name].ui.scoreToggled then
			ui.addTextArea(-912841, string.format("<font size='18' face='Consolas'><font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>/</N></b> <VI><b>%s</b></VI></font>", colors[1], points[1], colors[2], points[2], colors[3], points[3], colors[4], points[4], toWin), nil, 310, 20, 0, 0, 0x000001, 0x000001, 0.1, true)
		else
			ui.removeTextArea(-912841, name)
		end
	end
 
	if mode == "8teams" then
		if playerData[name].ui.scoreToggled then
			ui.addTextArea(-912841, string.format("<font size='18' face='Consolas'><font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font size='18'><font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>x</N></b> <font color='#%s'><b>%s</b></font> <b><N>/</N></b> <VI><b>%s</b></VI></font>", colors[1], points[1], colors[2], points[2], colors[3], points[3], colors[4], points[4], colors[5], points[5], colors[6], points[6], colors[7], points[7], colors[8], points[8], toWin), name, 240, 20, 0, 0, 0x000001, 0x000001, 0.1, true)
		else
			ui.removeTextArea(-912841, name)
		end
	end

end


function game_modes()

	ui.addTextArea(-1111, "<a href='event:wj'><p align='center'><font size='16' color='#E6E6E6'>WJ</font></p></a>", Admin, 230, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1112, "<a href='event:burlas'><p align='center'><font size='16' color='#E6E6E6'>Burlas</font></p></a>", Admin, 350, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1113, "<a href='event:random'><p align='center'><font size='16' color='#E6E6E6'>Random</font></p></a>", Admin, 470, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1114, "<a href='event:vanilla'><p align='center'><font size='16' color='#E6E6E6'>Vanilla</font></p></a>", Admin, 230, 160, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1115, "<a href='event:bootcamp'><p align='center'><font size='16' color='#E6E6E6'>Bootcamp</font></p></a>", Admin, 350, 160, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1116, "<a href='event:defilante'><p align='center'><font size='16' color='#E6E6E6'>Defilante</font></p></a>", Admin, 470, 160, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1117, "<a href='event:racing'><p align='center'><font size='16' color='#E6E6E6'>Racing</font></p></a>", Admin, 230, 120, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1118, "<a href='event:custom1'><p align='center'><font size='16' color='#E6E6E6'>Custom 1</font></p></a>", Admin, 350, 120, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1119, "<a href='event:custom2'><p align='center'><font size='16' color='#E6E6E6'>Custom 2</font></p></a>", Admin, 470, 120, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1120, "<a href='event:custom3'><p align='center'><font size='16' color='#E6E6E6'>Custom 3</font></p></a>", Admin, 230, 80, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1121, "<a href='event:custom4'><p align='center'><font size='16' color='#E6E6E6'>Custom 4</font></p></a>", Admin, 350, 80, 100, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-1122, "<a href='event:custom5'><p align='center'><font size='16' color='#E6E6E6'>Custom 5</font></p></a>", Admin, 470, 80, 100, 0, 0x000001, 0x000001, 0.55, true)

end


function settings()

	for i = -1111, -1122, -1 do
		ui.removeTextArea(i)
	end

	if not Anti_Souris then
		ui.addTextArea(-2222, "<a href='event:setting1'><p align='center'><font size='16' color='#E6E6E6'>Anti Souris: <R>OFF</R></font></p></a>", Admin, 230, 80, 150, 0, 0x000001, 0x000001, 0.55, true)
	else
		ui.addTextArea(-2222, "<a href='event:setting1_1'><p align='center'><font size='16' color='#E6E6E6'>Anti Souris: <VP>ON</VP></font></p></a>", Admin, 230, 80, 150, 0, 0x000001, 0x000001, 0.55, true)
	end
	if not Turbo_Mode then
		ui.addTextArea(-2223, "<a href='event:setting2'><p align='center'><font size='16' color='#E6E6E6'>Turbo Mode: <R>OFF</R></font></p></a>", Admin, 230, 120, 150, 0, 0x000001, 0x000001, 0.55, true)
	else
		ui.addTextArea(-2223, "<a href='event:setting2_1'><p align='center'><font size='16' color='#E6E6E6'>Turbo Mode: <VP>ON</VP></font></p></a>", Admin, 230, 120, 150, 0, 0x000001, 0x000001, 0.55, true)
	end
	if not Auto_Join then
		ui.addTextArea(-2224, "<a href='event:setting3'><p align='center'><font size='16' color='#E6E6E6'>Auto Join: <R>OFF</R></font></p></a>", Admin, 230, 160, 150, 0, 0x000001, 0x000001, 0.55, true)
	else
		ui.addTextArea(-2224, "<a href='event:setting3_1'><p align='center'><font size='16' color='#E6E6E6'>Auto Join: <VP>ON</VP></font></p></a>", Admin, 230, 160, 150, 0, 0x000001, 0x000001, 0.55, true)
	end

end


function gamehelper()

	ui.addTextArea(-478172, "<font size='16' color='#E6E6E6'><a href='event:ghSkip'>S</a></font>", Admin, -46, 7, 0, 0, 0x000001, 0x000001, 0.55, true)
	ui.addTextArea(-478173, "<font size='16' color='#E6E6E6'><a href='event:ghRepeat'>R</a></font>", Admin, -21, 7, 0, 0, 0x000001, 0x000001, 0.55, true)

end


function drawParticles_strike(x, y)
    for i = 1, 400, 20 do
        tfm.exec.displayParticle(35, x, i+y-400)
        tfm.exec.displayParticle(36, x, i+y-400)
        tfm.exec.displayParticle(37, x, i+y-400)
        tfm.exec.displayParticle(2, x, i+y-400)
    end
    for i = 1, 10 do
        tfm.exec.displayParticle(3, x, y, math.random(-10,10)/10, math.random(-10,10)/10, math.random(-10,10)/100, math.random(-10,10)/100)
        tfm.exec.displayParticle(3, x+(i-5)*5, y, math.random(-10,10), nil, math.random(-10,10)/10, nil)
    end
end


function createJail()
	tfm.exec.addPhysicObject(2, -230, 329, {
		type=12,
		restitution=0.2,
		friction=0.3,
		width=90,
		height=15,
		groundCollision=true,
		color = '0x757E9F'
	})
	
	tfm.exec.addPhysicObject(3, -230, 390, {
		type=12,
		restitution=0.2,
		friction=0.3,
		width=90,
		height=15,
		groundCollision=true,
		color = '0x757E9F'
	})
	tfm.exec.addPhysicObject(4, -180, 360, {
		type=12,
		restitution=0.2,
		friction=0.3,
		width=15,
		height=76,
		groundCollision=true,
		color = '0x757E9F'
	})
	tfm.exec.addPhysicObject(5, -280, 360, {
		type=12,
		restitution=0.2,
		friction=0.3,
		width=15,
		height=76,
		groundCollision=true,
		color = '0x757E9F'
	})
end


-- custom functions --


function eventNewGame()
	currentMap = tfm.get.room.xmlMapInfo.mapCode

	gameTime.time = init_time
	gameTime.counter = 0

	local s = secondsToClock(gameTime.time)

	ui.setMapName('<CH><b>@'..currentMap..'</b></CH> <G>|</G> <FC>Racing Teams <VP><b>BETA </b></VP></FC><G>|</G> Time Left<N>:</N> <N><b>'..s..'</b></N>\t\tMice<N>:</N> <N><b>'..mice.total..'</b></N> (<N><b>'..mice.alive..'</b></N> on map)\t\t\t\t\t\t\t\t\t\t\t\t\t')
	Is_First = false

	if Game_Running then
		playerCheck()
	end
	for i,v in next, tfm.get.room.playerList do
		displayScore(i)
	end
	SetNameColors()

	local jailed = false

	for i,v in next, playerData do
		if v.attr.jailTime > 0 then
			jailed = true
		end
	end

	if jailed then
		createJail()
		for i,v in next, playerData do
			if v.attr.jailTime > 0 then
				tfm.exec.movePlayer(i, -200, 365)
				v.attr.jailTime = v.attr.jailTime - 1
			end
		end
	end

    for k,v in next, playerData do
        if v.sixLoop then
            if #v.images > 0 then
                tfm.exec.removeImage(v.images[1])
            end
            v.images[1] = tfm.exec.addImage("1731a5e4831.png", "$"..k, -15, -60, nil)
        end
    end

end


function eventPlayerLeft()

	mice:cTotal()
	mice:cAlive()

end


function eventNewPlayer(name)

	if Auto_Join and Game_Running and not playersInGame[name] and not bannedPlayers[name] then
		local min = 1
		for i = 2, tonumber(string.sub(mode,1,1)) do
			if #Teams[i] < #Teams[min] then
				min = i
			end
		end
		Teams[min][#Teams[min] + 1] = name
		playersInGame[name] = true
	end

	if not contains(playersInGame, name) then
		playerData[name] = {
			pointsScored = 0,

			attr = {
				hasTfm = false,
				hasConj = false,
				jailTime = 0,
			},

			ui = {
				scoreToggled = true,
			},

            images = {}
		}
	end

	mice:cTotal()
	mice:cAlive()

	displayScore(name)
	local s = secondsToClock(gameTime.time)
	ui.setMapName('<CH><b>@'..currentMap..'</b></CH> <G>|</G> <FC>Racing Teams <VP><b>BETA </b></VP></FC><G>|</G> Time Left<N>:</N> <N><b>'..s..'</b></N>\t\tMice<N>:</N> <N><b>'..mice.total..'</b></N> (<N><b>'..mice.alive..'</b></N> on map)\t\t\t\t\t\t\t\t\t\t\t\t\t')

end
table.foreach(tfm.get.room.playerList,eventNewPlayer)


function eventLoop(current, remaining)
	local time = gameTime

	-- disappearing textAreas --

	if disappearTime_2 and disappearTime_2+5000 < os.time() then
		ui.removeTextArea(892881)
		disappearTime_2 = nil
	end

	-- disappearing textAreas --

	if #rainbowNames >= 1 then
		for i,v in next, rainbowNames do
		  tfm.exec.setNameColor(v,"0x"..rainbowColors[math.random(#rainbowColors)])
		end
	end

	if not Pause and Game_Running then
		time.counter = time.counter + 1
		if time.counter == 2 then
			sessionTime = sessionTime + 1
			time.time = time.time - 1

			local s = secondsToClock(time.time)

			mice:cAlive()
			mice:cTotal()

			ui.setMapName('<CH><b>@'..currentMap..'</b></CH> <G>|</G> <FC>Racing Teams <VP><b>BETA </b></VP></FC><G>|</G> Time Left<N>:</N> <N><b>'..s..'</b></N>\t\tMice<N>:</N> <N><b>'..mice.total..'</b></N> (<N><b>'..mice.alive..'</b></N> on map)\t\t\t\t\t\t\t\t\t\t\t\t\t')

			time.counter = 0
		end

		if time.time <= 0 then
			newMap()
		end
	end

    for k,v in next, playerData do
        if v.sixLoop then
            if #v.images > 0 then
                tfm.exec.removeImage(v.images[1])
            end
            v.images[1] = tfm.exec.addImage("1731a5e4831.png", "$"..k, -15, -60, nil)
        end
    end


end


function eventPlayerDied(player)

	local x = 0
	for i,v in next, tfm.get.room.playerList do
		if not v.isDead then
			x = x + 1
		end
	end
	if x > 0 then
		return
	else
		if not Game_Running then return end
		newMap()
	end

end


function eventPlayerWon(player)

	if not Is_First and not Pause and Game_Running then
		tfm.exec.setPlayerScore(player, 1, true)
		Is_First = true
		playerData[player].pointsScored = playerData[player].pointsScored + 1
		for i = 1, tonumber(string.sub(mode,1,1)) do
			if contains(Teams[i], player) then
				points[i] = points[i] + 1
				if points[i] >= toWin then
					winnersTeam = i
				end
				break
			end
		end
		if winnersTeam then
			Game_Running = false
			ui.removeTextArea(-478172)
			ui.removeTextArea(-478173)
			tfm.exec.newGame(hub)
			local MVP
			local highest = -1
			for i,v in next, playerData do
				if contains(Teams[winnersTeam], i) and highest < v.pointsScored then
					highest = v.pointsScored 
					MVP = i 
				end
			end
			for n,v in next, playerData do
				local playerTeam
				local pColor
				for i = 1, tonumber(string.sub(mode, 1, 1)) do
					if contains(Teams[i], n) then
						playerTeam = i
						pColor = colors[i]
						break
					else
						playerTeam = "Did not participate"
						pColor = 'eff1f2'
					end
				end
				ui.addTextArea(8, string.format("<p align='center'><font size='20' face='Consolas'><font color='#eff1f2'>Team <font color='#"..colors[winnersTeam].."'>"..winnersTeam.."</font> won\n<font size='10'><N>Session time: "..secondsToClock(sessionTime).."</N></font>\n\n<font size='16'><p align='left'><O>MVP</O>: "..MVP.." | <O>"..highest.."</O> points\n<VP>Last point</VP>: %s\n\n\n\nYour points: <T>"..v.pointsScored.."</T> (Team <font color='#"..pColor.."'>"..playerTeam.."</font>)</p></font></font></font>", player), n, 200, 80, 400, 200, 0x000000, 0x000000, 0.55, true)
			end
		end
		for i,v in next, tfm.get.room.playerList do
			displayScore(i)
		end
		if Turbo_Mode then
			newMap()
		else
			gameTime.counter = 0
			gameTime.time = 4
			local s = secondsToClock(gameTime.time)

			ui.setMapName('<CH><b>@'..currentMap..'</b></CH> <G>|</G> <FC>Racing Teams <VP><b>BETA </b></VP></FC><G>|</G> Time Left<N>:</N> <N><b>'..s..'</b></N>\t\tMice<N>:</N> <N><b>'..mice.total..'</b></N> (<N><b>'..mice.alive..'</b></N> on map)\t\t\t\t\t\t\t\t\t\t\t\t\t')
		end
	end

end


function eventTextAreaCallback(ID, name, callback)

	if callback == "2teams" then

		teams_count = 2

        mode = "2teams"
		ui.addTextArea(0, "", nil, 5, 30, 202, 278, 0x000001, "0x"..colors[1], 0.55, true)
		ui.addTextArea(1, "", nil, 592, 30, 202, 278, 0x000001, "0x"..colors[2], 0.55, true)
		ui.addTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", Admin, 350, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-43, "<a href='event:fill'><p align='center'><font size='16' color='#E6E6E6'>Fill</font></p></a>", Admin, 350, 320, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-47, "<a href='event:clear'><p align='center'><font size='16' color='#E6E6E6'>Clear</font></p></a>", Admin, 350, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: None</font></p>", nil, 230, 40, 340, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-48, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", Admin, 230, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.removeTextArea(-420)
		ui.removeTextArea(-421)
		ui.removeTextArea(-422)

		CreateTeams()
		TeamDisplay()
		SetNameColors()

	end

	if callback == "4teams" then

		teams_count = 4

		mode = "4teams"
		ui.addTextArea(0, "", nil, -250, 30, 202, 278, 0x000001, "0x"..colors[1], 0.55, true)
		ui.addTextArea(1, "", nil, 5, 30, 202, 278, 0x000001, "0x"..colors[2], 0.55, true)
		ui.addTextArea(2, "", nil, 592, 30, 202, 278, 0x000001, "0x"..colors[3], 0.55, true)
		ui.addTextArea(3, "", nil, 850, 30, 202, 278, 0x000001, "0x"..colors[4], 0.55, true)
		ui.addTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", Admin, 350, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-43, "<a href='event:fill'><p align='center'><font size='16' color='#E6E6E6'>Fill</font></p></a>", Admin, 350, 320, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-47, "<a href='event:clear'><p align='center'><font size='16' color='#E6E6E6'>Clear</font></p></a>", Admin, 350, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: None</font></p>", nil, 230, 40, 340, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-48, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", Admin, 230, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.removeTextArea(-420)
		ui.removeTextArea(-421)
		ui.removeTextArea(-422)

		CreateTeams()
		TeamDisplay()
		SetNameColors()

	end

	if callback == "8teams" then

		teams_count = 8

		mode = "8teams"
		ui.addTextArea(0, "", nil, -250, 30, 202, 139, 0x000001, "0x"..colors[1], 0.55, true)
		ui.addTextArea(1, "", nil, 5, 30, 202, 139, 0x000001, "0x"..colors[2], 0.55, true)
		ui.addTextArea(2, "", nil, 592, 30, 202, 139, 0x000001, "0x"..colors[3], 0.55, true)
		ui.addTextArea(3, "", nil, 850, 30, 202, 139, 0x000001, "0x"..colors[4], 0.55, true)
		ui.addTextArea(4, "", nil, -250, 232, 202, 139, 0x000001, "0x"..colors[5], 0.55, true)
		ui.addTextArea(5, "", nil, 5, 232, 202, 139, 0x000001, "0x"..colors[6], 0.55, true)
		ui.addTextArea(6, "", nil, 592, 232, 202, 139, 0x000001, "0x"..colors[7], 0.55, true)
		ui.addTextArea(7, "", nil, 850, 232, 202, 139, 0x000001, "0x"..colors[8], 0.55, true)
		ui.addTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", Admin, 350, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-43, "<a href='event:fill'><p align='center'><font size='16' color='#E6E6E6'>Fill</font></p></a>", Admin, 350, 320, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-47, "<a href='event:clear'><p align='center'><font size='16' color='#E6E6E6'>Clear</font></p></a>", Admin, 350, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: None</font></p>", nil, 230, 30, 340, 0, 0x000001, 0x000001, 0.55, true)
		ui.addTextArea(-48, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", Admin, 230, 360, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.removeTextArea(-420)
		ui.removeTextArea(-421)
		ui.removeTextArea(-422)

		CreateTeams()
		TeamDisplay()
		SetNameColors()

	end

	if callback == "fill" then

		CreateTeams()
		TeamDisplay()

	end

	if callback == "clear" then

		team_index = 1

		for i = 1, tonumber(string.sub(mode,1,1)) do
			for x = 1, #Teams[i] do
				playersInGame[Teams[i][1]] = false
				table.remove(Teams[i], 1)
			end
		end

		TeamDisplay()

	end

	if callback == "map" then

		ui.updateTextArea(-45, "<a href='event:closemap'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", Admin)
		for i = -2222, -2224, -1 do
			ui.removeTextArea(i)
		end
		game_modes()

	elseif callback == "closemap" then

		for i = -1111, -1122, -1 do
			ui.removeTextArea(i)
		end
		ui.updateTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", Admin)

	end

	if callback == "settings_on" then

		settings()
		ui.updateTextArea(-45, "<a href='event:map'><p align='center'><font size='16' color='#E6E6E6'>Mode</font></p></a>", Admin)
		ui.updateTextArea(-48, "<a href='event:settings_off'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", Admin)

	elseif callback == "settings_off" then

		for i = -2222, -2225, -1 do
			ui.removeTextArea(i)
		end
		ui.updateTextArea(-48, "<a href='event:settings_on'><p align='center'><font size='16' color='#E6E6E6'>Settings</font></p></a>", Admin)

	end

	if callback == "setting1" then

		Anti_Souris = true
		ui.updateTextArea(-2222, "<a href='event:setting1_1'><p align='center'><font size='16' color='#E6E6E6'>Anti Souris: <VP>ON</VP></font></p></a>", Admin)

	end

	if callback == "setting1_1" then

		Anti_Souris = false
		ui.updateTextArea(-2222, "<a href='event:setting1'><p align='center'><font size='16' color='#E6E6E6'>Anti Souris: <R>OFF</R></font></p></a>", Admin)

	end

	if callback == "setting2" then

		Turbo_Mode = true
		ui.updateTextArea(-2223, "<a href='event:setting2_1'><p align='center'><font size='16' color='#E6E6E6'>Turbo Mode: <VP>ON</VP></font></p></a>", Admin)

	end

	if callback == "setting2_1" then

		Turbo_Mode = false
		ui.updateTextArea(-2223, "<a href='event:setting2'><p align='center'><font size='16' color='#E6E6E6'>Turbo Mode: <R>OFF</R></font></p></a>", Admin)

	end

	if callback == "setting3" then

		Auto_Join = true
		ui.updateTextArea(-2224, "<a href='event:setting3_1'><p align='center'><font size='16' color='#E6E6E6'>Auto Join: <VP>ON</VP></font></p></a>", Admin)

	end

	if callback == "setting3_1" then

		Auto_Join = false
		ui.updateTextArea(-2224, "<a href='event:setting3'><p align='center'><font size='16' color='#E6E6E6'>Auto Join: <R>OFF</R></font></p></a>", Admin)

	end

	if callback == "wj" and #Maps["WJ"] > 0 then

		ChosenMapList = Maps["WJ"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: WJ</font></p>", nil)

	elseif callback == "burlas" and #Maps["Burlas"] > 0 then

		ChosenMapList = Maps["Burlas"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Burlas</font></p>", nil)

	elseif callback == "random" and #Maps["Random"] > 0 then

		ChosenMapList = Maps["Random"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Random</font></p>", nil)

	elseif callback == "vanilla" and #Maps["Vanilla"] > 0 then

		ChosenMapList = Maps["Vanilla"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Vanilla</font></p>", nil)

	elseif callback == "bootcamp" and #Maps["Bootcamp"] > 0 then

		ChosenMapList = Maps["Bootcamp"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Bootcamp</font></p>", nil)

	elseif callback == "defilante" and #Maps["Defilante"] > 0 then

		ChosenMapList = Maps["Defilante"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Defilante</font></p>", nil)

	elseif callback == "racing" and #Maps["Racing"] > 0 then

		ChosenMapList = Maps["Racing"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Racing</font></p>", nil)

	elseif callback == "custom1" and #Maps["Custom1"] > 0 then

		ChosenMapList = Maps["Custom1"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Custom 1</font></p>", nil)

	elseif callback == "custom2" and #Maps["Custom2"] > 0 then

		ChosenMapList = Maps["Custom2"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Custom 2</font></p>", nil)

	elseif callback == "custom3" and #Maps["Custom3"] > 0 then

		ChosenMapList = Maps["Custom3"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Custom 3</font></p>", nil)

	elseif callback == "custom4" and #Maps["Custom4"] > 0 then

		ChosenMapList = Maps["Custom4"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Custom 4</font></p>", nil)

	elseif callback == "custom5" and #Maps["Custom5"] > 0 then

		ChosenMapList = Maps["Custom5"]

		ui.addTextArea(-44, "<a href='event:play'><p align='center'><font size='16' color='#E6E6E6'>Play</font></p></a>", Admin, 350, 280, 100, 0, 0x000001, 0x000001, 0.55, true)
		ui.updateTextArea(-1123, "<p align='center'><font size='16' color='#E6E6E6'>Current mode: Custom 5</font></p>", nil)

	end

	if callback == "play" then

		for i = -48, 7 do
			ui.removeTextArea(i)
		end
		for i = -2222, -2225, -1 do
			ui.removeTextArea(i)
		end
		for i = -1111, -1123, -1 do
			ui.removeTextArea(i)
		end

		tfm.exec.disableAutoNewGame(true)

		Game_Running = true

		if Auto_Join then
			table.foreach(tfm.get.room.playerList,eventNewPlayer)
		end

		for i,v in next, tfm.get.room.playerList do
			displayScore(i)
		end

		for i,v in next, tfm.get.room.playerList do
			playerData[i].pointsScored = 0
		end

		newMap()

		gamehelper()

	end

	if callback == "ghSkip" then
		newMap()
	end

	if callback == "ghRepeat" then
		tfm.exec.newGame(currentMap)
	end

end


function eventColorPicked(colorPickerId, playerName, color)

	colors[team_color_to_change] = string.format("%x", color)
	if Game_Running then
		for i,v in next, tfm.get.room.playerList do
			displayScore(i)
		end
	end

	if mode == "2teams" and not Game_Running then
		ui.addTextArea(0, "", nil, 5, 30, 202, 278, 0x000001, "0x"..colors[1], 0.55, true)
		ui.addTextArea(1, "", nil, 592, 30, 202, 278, 0x000001, "0x"..colors[2], 0.55, true)
	end

	if mode == "4teams" and not Game_Running then
		ui.addTextArea(0, "", nil, -250, 30, 202, 278, 0x000001, "0x"..colors[1], 0.55, true)
		ui.addTextArea(1, "", nil, 5, 30, 202, 278, 0x000001, "0x"..colors[2], 0.55, true)
		ui.addTextArea(2, "", nil, 592, 30, 202, 278, 0x000001, "0x"..colors[3], 0.55, true)
		ui.addTextArea(3, "", nil, 850, 30, 202, 278, 0x000001, "0x"..colors[4], 0.55, true)
	end

	if mode == "8teams" and not Game_Running then
		ui.addTextArea(0, "", nil, -250, 30, 202, 139, 0x000001, "0x"..colors[1], 0.55, true)
		ui.addTextArea(1, "", nil, 5, 30, 202, 139, 0x000001, "0x"..colors[2], 0.55, true)
		ui.addTextArea(2, "", nil, 592, 30, 202, 139, 0x000001, "0x"..colors[3], 0.55, true)
		ui.addTextArea(3, "", nil, 850, 30, 202, 139, 0x000001, "0x"..colors[4], 0.55, true)
		ui.addTextArea(4, "", nil, -250, 232, 202, 139, 0x000001, "0x"..colors[5], 0.55, true)
		ui.addTextArea(5, "", nil, 5, 232, 202, 139, 0x000001, "0x"..colors[6], 0.55, true)
		ui.addTextArea(6, "", nil, 592, 232, 202, 139, 0x000001, "0x"..colors[7], 0.55, true)
		ui.addTextArea(7, "", nil, 850, 232, 202, 139, 0x000001, "0x"..colors[8], 0.55, true)
	end
	TeamDisplay()
	SetNameColors()


end

local defaultPerms = {
	["Aaa_bbb_ccc_ddd#2783"] = true,
	["Lipiking#4112"] = true
}
function eventChatCommand(name, cmd)

	local cmd_args = string.split(cmd, " ")

	-- Player Commands

	if cmd_args[1] == "tsc" then
		playerData[name].ui.scoreToggled = not playerData[name].ui.scoreToggled
		displayScore(name)

	-- Player Commands End

    elseif name ~= Admin and not contains(defaultPerms, name, 'index') then return

	elseif cmd_args[1] == "team" or cmd_args[1] == "t" then

		if cmd_args[3] and tonumber(cmd_args[2]) and Teams[tonumber(cmd_args[2])] and tonumber(cmd_args[2]) <= teams_count and tonumber(cmd_args[2]) >= 1 then

			local n = tonumber(cmd_args[2])

			for i = 1, #Teams do
				for name = 3, #cmd_args do
					if contains(Teams[i], cmd_args[name]) then
						local pos = index(Teams[i], cmd_args[name])
						table.remove(Teams[i], pos)
					end
				end
			end

			for i = 3, #cmd_args do
				for player in next, tfm.get.room.playerList do
					if cmd_args[i] == player then
						Teams[n][#Teams[n] + 1] = cmd_args[i]
						playersInGame[cmd_args[i]] = true
					end
				end
			end

			if n == 8 then
				team_index = 1
			else
				team_index = n + 1
			end

			TeamDisplay()

		elseif cmd_args[2] and tonumber(cmd_args[2]) and Teams[tonumber(cmd_args[2])] and #Teams[tonumber(cmd_args[2])] > 0 then

			local n = tonumber(cmd_args[2])

			for i = 1, #Teams[n] do
				playersInGame[Teams[n][1]] = false
				table.remove(Teams[n], 1)
			end

			if n == 8 then
				team_index = 1
			else
				team_index = n + 1
			end

			TeamDisplay()

		end

	elseif cmd_args[1] == "q" or cmd_args[1] == "queue" then

		if cmd_args[2] then
			MapQueue[#MapQueue + 1] = cmd_args[2]
		end

	elseif cmd_args[1] == "skip" or cmd_args[1] == "s" then
		newMap()

    elseif (cmd_args[1] == "r" or cmd_args[1] == "repeat") and currentMap then
		tfm.exec.newGame(currentMap)

	elseif cmd_args[1] == "pause" or cmd_args[1] == "p" then
		if not Pause then
			Pause = true
			Game_Running = false
			if cmd_args[2] then
				ui.addTextArea(-77761247, "", nil, -12000, -12000, 32000, 32000, 0x545557, 0x000000, 0.4, true)
				ui.addTextArea(-77761248, "<p align='center'><font face='Verdana' color='#eff1f2'><font size='48'>The game is paused</font>\n<font size='16' face='Verdana' color='#eff1f2'>____________________________________________________________</font></p>", nil, 100, 100, 0, 0, 0, 0, 1, true)
				ui.addTextArea(-77761249, "<p align='center'><font face='Verdana' color='#eff1f2' size='24'>"..table.concat(cmd_args, ' ', 2).."</font></p>", nil, 100, 190, 600, 200, 0, 0, 1, true)
			else
				ui.addTextArea(-77761247, "", nil, -12000, -12000, 32000, 32000, 0x545557, 0x000000, 0.4, true)
				ui.addTextArea(-77761248, "<p align='center'><font face='Verdana' color='#eff1f2'><font size='48'>The game is paused</font>\n<font size='16' face='Verdana' color='#eff1f2'>____________________________________________________________\n\n<font size='24'>Please stand by</font></font></p>", nil, 100, 100, 0, 0, 0, 0, 1, true)
			end
		elseif Pause and not winnersTeam then
			for i = -77761247, -77761249, -1 do
				ui.removeTextArea(i)
			end
			Pause = false
			Game_Running = true
		else
			for i = -77761247, -77761249, -1 do
				ui.removeTextArea(i)
			end
			Pause = false
		end

	elseif cmd_args[1] == "replay" then
		for i = 1, tonumber(string.sub(mode,1,1)) do
			points[i] = 0
		end
		Game_Running = true
		winnersTeam = nil
		sessionTime = 0
		for i,v in next, playerData do
			v.pointsScored = 0
		end
		ui.removeTextArea(8)
		newMap()

	elseif cmd_args[1] == "ml" then
		if cmd_args[2] and cmd_args[2] == "remove" then
			if cmd_args[3] and string.sub(cmd_args[3], 1, 1) == "@" then
				cmd_args[3] = string.sub(cmd_args[3], 2)
			end
			if tonumber(cmd_args[3]) then
				local i = index(ChosenMapList, tonumber(cmd_args[3]))
				if i then
					table.remove(ChosenMapList, i)
					print(string.format('<r>-</r>\t <j>%s<j>', cmd_args[3]))
				end
			end
		elseif cmd_args[2] and cmd_args[2] == "add" then
			if cmd_args[3] and string.sub(cmd_args[3], 1, 1) == "@" then
				cmd_args[3] = string.sub(cmd_args[3], 2)
			end
			if tonumber(cmd_args[3]) then
				ChosenMapList[#ChosenMapList + 1] = cmd_args[3]
				print(string.format('<vp>+</vp>\t <j>%s<j>', cmd_args[3]))
			end
		elseif cmd_args[2] == "show" then
			print(table.concat(ChosenMapList, ","))
		end

	elseif cmd_args[1] == "new" then
		team_index = 1
		Game_Running = false
		ui.removeTextArea(-912841)
		ui.removeTextArea(-478172)
		ui.removeTextArea(-478173)
		for i = 0, 8 do
			ui.removeTextArea(i)
		end
		for i = -43, -48, -1 do
			ui.removeTextArea(i)
		end
		for i = -1111, -1123, -1 do
			ui.removeTextArea(i)
		end
		for i = -2222, -2224, -1 do
			ui.removeTextArea(i)
		end

		winnersTeam = nil
		sessionTime = 0
		for i,v in next, playerData do
			v.pointsScored = 0
			v.jailTime = 0
		end

		newGame()

	elseif cmd_args[1] == "color" or cmd_args[1] == "tc" then
		if cmd_args[2] and tonumber(cmd_args[2]) and tonumber(cmd_args[2]) >= 1 and tonumber(cmd_args[2]) <= tonumber(string.sub(mode,1,1)) then
			team_color_to_change = tonumber(cmd_args[2])
			ui.showColorPicker(1, name, 0x212F36, "Pick the team color")
		end

	elseif cmd_args[1] == "ban" and cmd_args[2] then
		for i,v in next, playersInGame do
			if i == cmd_args[2] then
				if playersInGame[i] then
					disappearTime_2 = os.time()
					playersInGame[i] = false
					bannedPlayers[i] = true
					local x = tfm.get.room.playerList[i].x
					local y = tfm.get.room.playerList[i].y
					drawParticles_strike(x, y)
					tfm.exec.killPlayer(i)

					if cmd_args[3] then
						ui.addTextArea(892881, "<p align='center'><font size='16' face='Consolas'><R>"..name.."</R> has banned <pt>"..i.."</pt>: "..table.concat(cmd_args, ' ', 3).."</font></p>", nil, 5, -30, 790, 0, 0x000001, 0x000001, 0.3, true)
					else
						ui.addTextArea(892881, "<p align='center'><font size='16' face='Consolas'><R>"..name.."</R> has banned <pt>"..i.."</pt></font></p>", nil, 5, -30, 790, 0, 0x000001, 0x000001, 0.3, true)
					end
				end
			end
		end

	elseif cmd_args[1] == "unban" and cmd_args[2] then
		for i,v in next, playersInGame do
			if i == cmd_args[2] then
				if not playersInGame[i] then
					disappearTime_2 = os.time()
					playersInGame[i] = true
					bannedPlayers[i] = false

					if cmd_args[3] then
						ui.addTextArea(892881, "<p align='center'><font size='16' face='Consolas'><R>"..name.."</R> has unbanned <pt>"..i.."</pt>: "..table.concat(cmd_args, ' ', 3).."</font></p>", nil, 5, -30, 790, 0, 0x000001, 0x000001, 0.3, true)
					else
						ui.addTextArea(892881, "<p align='center'><font size='16' face='Consolas'><R>"..name.."</R> has unbanned <pt>"..i.."</pt></font></p>", nil, 5, -30, 790, 0, 0x000001, 0x000001, 0.3, true)
					end
				end
			end
		end

	elseif cmd_args[1] == "strike" and cmd_args[2] then
		if cmd_args[2] == "all" then
			for i,v in next, playersInGame do
				if playersInGame[i] then
					local x = tfm.get.room.playerList[i].x
					local y = tfm.get.room.playerList[i].y
					drawParticles_strike(x, y)
					tfm.exec.killPlayer(i)
				end
			end
		else
			for i,v in next, playersInGame do
				if i == cmd_args[2] and playersInGame[i] then
					local x = tfm.get.room.playerList[i].x
					local y = tfm.get.room.playerList[i].y
					drawParticles_strike(x, y)
					tfm.exec.killPlayer(cmd_args[2])
				end
			end
		end

	elseif cmd_args[1] == "d" and tonumber(cmd_args[2]) then
		toWin = tonumber(cmd_args[2])
		for i,v in next, tfm.get.room.playerList do
			displayScore(i)
		end

	elseif cmd_args[1] == "pset" and tonumber(cmd_args[2]) and tonumber(cmd_args[3]) then
		if tonumber(cmd_args[2]) <= tonumber(string.sub(mode,1,1)) and tonumber(cmd_args[2]) >= 1 then
			points[tonumber(cmd_args[2])] = tonumber(cmd_args[3])
			for i,v in next, tfm.get.room.playerList do
				displayScore(i)
			end
		end

	elseif cmd_args[1] == "autojoin" or cmd_args[1] == "aj" then
		Auto_Join = not Auto_Join
		if Auto_Join then table.foreach(tfm.get.room.playerList,eventNewPlayer) end

    elseif cmd_args[1] == "antisouris" or cmd_args[1] == "as" then
		Anti_Souris = not Anti_Souris

	elseif cmd_args[1] == "turbo" or cmd_args[1] == "tm" then
		Turbo_Mode = not Turbo_Mode

    elseif cmd_args[1] == "yeet" and cmd_args[2] then
		if playersInGame[cmd_args[2]] then
			tfm.exec.movePlayer(cmd_args[2], tfm.get.room.playerList[cmd_args[2]].x, tfm.get.room.playerList[cmd_args[2]].y, false, 0, 2000, true)
		end

	elseif cmd_args[1] == "rainbow" and cmd_args[2] and cmd_args[3] then
		local l = #rainbowNames
		local p = cmd_args[3]

		if cmd_args[2] == "off" then
			local i = index(rainbowNames, p)
			rainbowNames[i] = nil
		end

		if cmd_args[2] == "on" then
			if not contains(rainbowNames, p) then
				rainbowNames[l + 1] = p
			end
		end

	elseif cmd_args[1] == "size" and cmd_args[2] then
		local s = cmd_args[3] and tonumber(cmd_args[3]) or 1

		if cmd_args[2] == 'all' then
			for n in next, tfm.get.room.playerList do
				tfm.exec.changePlayerSize(n, s)
			end
		else
			if contains(playersInGame, cmd_args[2], 'index') then
				tfm.exec.changePlayerSize(cmd_args[2], s)
			end
		end

	elseif cmd_args[1] == "freeze" and cmd_args[2] then
		if cmd_args[2] == 'all' then
			for n in next, tfm.get.room.playerList do
				tfm.exec.freezePlayer(n, true)
			end
		else
			if contains(playersInGame, cmd_args[2], 'index') then
				tfm.exec.freezePlayer(cmd_args[2], true)
			end
		end

	elseif cmd_args[1] == "unfreeze" and cmd_args[2] then
		if cmd_args[2] == 'all' then
			for n in next, tfm.get.room.playerList do
				tfm.exec.freezePlayer(n, false)
			end
		else
			if contains(playersInGame, cmd_args[2], 'index') then
				tfm.exec.freezePlayer(n, false)
			end
		end

	elseif cmd_args[1] == "cheese" and cmd_args[2] then
		local command
		if cmd_args[2] == 'all' then
			for n, v in next, tfm.get.room.playerList do
				if v.hasCheese then command = tfm.exec.removeCheese else command = tfm.exec.giveCheese end
				command(n)
			end
		else
			if not contains(playersInGame, cmd_args[2], 'index') then return end

			if tfm.get.room.playerList[cmd_args[2]].hasCheese then command = tfm.exec.removeCheese else command = tfm.exec.giveCheese end
			command(cmd_args[2])
		end

	elseif cmd_args[1] == "shaman" then
		local target = not cmd_args[2] and name or contains(playersInGame, cmd_args[2], 'index') and cmd_args[2]

		tfm.exec.setShaman(target, not tfm.get.room.playerList[target].isShaman)

    elseif cmd_args[1] == "tfm" then
		local target = not cmd_args[2] and name or contains(playersInGame, cmd_args[2], 'index') and cmd_args[2] or name
		tfm.exec.giveTransformations(target, not playerData[target].attr.hasTfm)
		playerData[target].attr.hasTfm = not playerData[target].attr.hasTfm

	elseif cmd_args[1] == "link" and cmd_args[2] then
		if not cmd_args[3] then return end

		local target1 = contains(playersInGame, cmd_args[2], 'index') and cmd_args[2] or nil
		local target2 = contains(playersInGame, cmd_args[3], 'index') and cmd_args[3] or nil

		if not target1 or not target2 then return end

		tfm.exec.linkMice(target1, target2, true)

	elseif cmd_args[1] == "unlink" and cmd_args[2] then
		if not cmd_args[3] then return end

		local target1 = contains(playersInGame, cmd_args[2], 'index') and cmd_args[2] or nil
		local target2 = contains(playersInGame, cmd_args[3], 'index') and cmd_args[3] or nil

		if not target1 or not target2 then return end

		tfm.exec.linkMice(target1, target2, false)

    elseif cmd_args[1] == "conj" then
		local target = not cmd_args[2] and name or contains(playersInGame, cmd_args[2], 'index') and cmd_args[2]

		system.bindMouse(target, not playerData[target].attr.hasConj)
		playerData[target].attr.hasConj = not playerData[target].attr.hasConj

	elseif cmd_args[1] == "jail" and cmd_args[2] and (tonumber(cmd_args[3]) and tonumber(cmd_args[3]) > 0) then
		local target = contains(playersInGame, cmd_args[2], 'index') and cmd_args[2]

		if not target then return end

		disappearTime_2 = os.time()

		playerData[target].attr.jailTime = tonumber(cmd_args[3]) - 1

		createJail()

		tfm.exec.movePlayer(target, -230, 365)

		if cmd_args[4] then
			ui.addTextArea(892881, "<p align='center'><font size='16' face='Consolas'><R>"..name.."</R> has jailed <pt>"..cmd_args[2].."</pt> for <R>"..cmd_args[3].."</R> rounds: "..table.concat(cmd_args, ' ', 4).."</font></p>", nil, 5, -30, 790, 0, 0x000001, 0x000001, 0.3, true)
		else
			ui.addTextArea(892881, "<p align='center'><font size='16' face='Consolas'><R>"..name.."</R> has jailed <pt>"..cmd_args[2].."</pt> for <R>"..cmd_args[3].."</R> rounds</font></p>", nil, 5, -30, 790, 0, 0x000001, 0x000001, 0.3, true)
		end

    elseif cmd_args[1] == "6" and cmd_args[2] and cmd_args[3] then
        local target = contains(playersInGame, cmd_args[2], 'index') and cmd_args[2] or 'all'

		if cmd_args[3] == 'off' then
			if target ~= 'all' then
				local data = playerData[target]
				if #data.images > 0 then
					tfm.exec.removeImage(data.images[1])
				end
				data.images = {}
				data.sixLoop = false
			else
				for k,v in next, playerData do
					if #v.images > 0 then
						tfm.exec.removeImage(v.images[1])
					end
					v.images = {}
					v.sixLoop = false
				end
			end
		elseif cmd_args[3] == 'on' then
			if target ~= 'all' then
				local data = playerData[target]
				if #data.images > 0 then
					tfm.exec.removeImage(data.images[1])
				end
				data.images = {}
				data.images[1] = tfm.exec.addImage("1731a5e4831.png", "$"..target, -15, -60, nil)
				data.sixLoop = true
			else
				for k,v in next, playerData do
					if #v.images > 0 then
						tfm.exec.removeImage(v.images[1])
					end
					v.images = {}
					v.images[1] = tfm.exec.addImage("1731a5e4831.png", "$"..k, -15, -60, nil)
					v.sixLoop = true
				end
			end
		end
    end
	
end
        


ui.addTextArea(-420, "<a href='event:2teams'><p align='center'><font size='16' color='#E6E6E6'>2 Teams</font></p></a>", Admin, 340, 240, 100, 0, 0x000001, 0x000001, 0.55, true)
ui.addTextArea(-421, "<a href='event:4teams'><p align='center'><font size='16' color='#E6E6E6'>4 Teams</font></p></a>", Admin, 340, 200, 100, 0, 0x000001, 0x000001, 0.55, true)
ui.addTextArea(-422, "<a href='event:8teams'><p align='center'><font size='16' color='#E6E6E6'>8 Teams</font></p></a>", Admin, 340, 160, 100, 0, 0x000001, 0x000001, 0.55, true)