--[[
transformice lua by zigwin
#heavyrain
v1.2
--]]


do
	local _,name = pcall(nil)
	admin = string.match(name, "(.-)%.")
end

local playerData = {}

--[[ Новый игрок--]]

function eventNewPlayer(playerName)
	system.bindKeyboard(playerName, 0, true, true)  -- Left
	system.bindKeyboard(playerName, 2, true, true)  -- Right
	system.bindKeyboard(playerName, 3, true, true)  -- Down
	system.bindKeyboard(playerName, 32, true, true) -- Space
	system.bindKeyboard(playerName, 69, true, true) -- E
	system.bindKeyboard(playerName, 72, true, true) -- H
	system.bindMouse(playerName, true)

	playerData[playerName] = {
		cannons = 0,
		hasTeleported = false,
		hasCheese = false,
		isHelpVisible = false,
		power = 0,
		nextPower = 0,
		powerUsable = true,
		facingRight = true,
		powerList = {true,true,true,true,true,true},
		powersShopPage = 1,
		coin = 0,
	}
end

table.foreach(tfm.get.room.playerList, eventNewPlayer)

--[[ Переводы--]]

-- 0 - Nothing
-- 1 - Free jump   - Every round ; Usable
-- 2 - Boost 	    - Every 20 seconds ; Usable
-- 3 - Free cheese - Every round
-- 4 - Free cannon - Every even round
-- 5 - Explode     - Every round ; Usable

local text = {
	ru = {
		round = 'Раунд',
		winner = 'победитель',
		help1 = '<u><b>Управление</b>______________________________</u>\n\n● <b>↓</b> or <b>E</b> or <b>Space</b> - Подобрать бонус\n● <b>H</b> - Помощь\n● <b>Mouse Left Button</b> - Использовать предмет\n\n<u><b>Бонусы</b>__________________________________ </u>\n\n● <b><j>Звезда</j></b> - Ядро\n● <b><v>+1</v></b> - +1 К счету\n● <b><j>Сыр</j></b> - Телепорт - Только раз за раунд\n\n<u><b>События</b>__________________________________</u>\n\n● <b><r>Авиаудар</r></b> - Появляется линия ядер с местом для укрытия ● \n● <b><r>Наковальни</r></b> - Появляется много наковален\n● <b><r>Бонусная лихорадка</r></b> - Частота появления бонусов увеличивается в 10 раз\n● <b><r>Удвоенная скорость</r></b> - 4 Ядра появляются каждую секунду',
		help2 = "<u><b>Силы</b>_____________________________</u>\n<i><g>Используемый - нажми <b>↓</b> чтобы использовать.</g></i>\n\n<b><bv><u>Прыжок</u></bv></b>\n▫ Каждый раунд\n▫ Используемый\n\n<b><bv><u>Ускорение</u></bv></b>\n▫ Каждый раунд и каждые 10 сек\n▫ Используемый\n\n<b><bv><u>Сыр</u></bv></b>\n▫ Каждый раунд\n\n<b><bv><u>Ядро</u></bv></b>\n▫ Каждый четный раунд\n\n<b><bv><u>Взоваться</u></bv></b>\n▫ Каждый раунд\n▫ Используемый",
		event = {
			"Авиаудар",
			"Наковальни",
			"Удвоенная скорость",
			"Бонусная лихорадка",
		},
		powers = {
			"Прыжок",
			"Ускорение",
			"Сыр",
			"Ядро",
			"Взоваться"
		},
		buy = "Купить",
		equip = "Экипировать",
		equipped = "Экипированно",
		willbeeqippedinnextround = "Будет экипированно в следующем раунде",
		close = "Закрыть",
		coins = "Монеты"
	},
	en = {
		round = 'Round',
		winner = 'winner',
		help1 = '<u><b>Controls</b>__________________________________</u>\n\n● <b>↓</b> or <b>E</b> or <b>Space</b> - Take bonus\n● <b>H</b> - Help message\n● <b>Mouse Left Button</b> - Use item\n\n<u><b>Bonuses</b>__________________________________ </u>\n\n● <b><j>Star</j></b> - Cannon\n● <b><v>+1</v></b> - +1 To score\n● <b><j>Cheese</j></b> - Teleport - Only one in round\n\n<u><b>Events</b>___________________________________</u>\n\n● <b><r>Airstrike</r></b> - A line of cannons spawn with ● place to hide\n● <b><r>Anvils</r></b> - Alot anvils spawn\n● <b><r>Bonus Madness</r></b> - Bonus spawn rate multiplies by 10\n● <b><r>Double Speed</r></b> - 4 Cannons spawn each second',
		help2 = "<u><b>Powers</b>_____________________________</u>\n<i><g>Usable - press <b>↓</b> to use.</g></i>\n\n<b><bv><u>Free jump</u></bv></b>\n▫ Every round\n▫ Usable\n\n<b><bv><u>Boost</u></bv></b>\n▫ Every 20 seconds\n▫ Usable\n\n<b><bv><u>Free cheese</u></bv></b>\n▫ Every round\n\n<b><bv><u>Free cannon</u></bv></b>\n▫ Every even round\n\n<b><bv><u>Explode</u></bv></b>\n▫ Every round\n▫ Usable",
		event = {
			"Airstrike",
			"Anvils",
			"Double Speed",
			"Bonus Madness",
		},
		powers = {
			"Jump",
			"Boost",
			"Cheese",
			"Cannon",
			"Explode"
		},
		buy = "Buy",
		equip = "Equip",
		equipped = "Equipped",
		willbeeqippedinnextround = "Will be eqipped in next round",
		close = "Close",
		coins = "Coins"
	},
	tr = {
		round = 'Tur',
		winner = 'kazanan',
		help1 = '<u><b>Kontroller</b>_________________________________</u>\n\n● <b>↓</b> ya da <b>E</b> ya da <b>Space</b> - Bonusu almak için\n● <b>H</b> - Yardım mesajı\n● <b>Sol tık</b> - Eşya kullanmak için\n\n<u><b>Bonuslar</b>__________________________________ </u>\n\n● <b><j>Yıldız</j></b> - top\n● <b><v>+1</v></b> - skora +1 puan ekler\n● <b><j>Peynir</j></b> - Işınlanmak - Her tur da sadece 1 kere\n\n<u><b>Etkinlikler</b>________________________________</u>\n\n● <b><r>Airstrike</r></b> - 1 sırada tüm toplar ● Gizlemek için\n● <b><r>Örsler</r></b> - Birsürü örs yaratır\n● <b><r>Bonus delilik</r></b> - Bonus yaratma oranı 10 ile çarpıyor\n● <b><r>2 kat hız</r></b> - Her saniye 4 top yaratır',
		help2 = "<u><b>Powers</b>_____________________________</u>\n<i><g>Usable - press <b>↓</b> to use.</g></i>\n\n<b><bv><u>Free jump</u></bv></b>\n▫ Every round\n▫ Usable\n\n<b><bv><u>Boost</u></bv></b>\n▫ Every 20 seconds\n▫ Usable\n\n<b><bv><u>Free cheese</u></bv></b>\n▫ Every round\n\n<b><bv><u>Free cannon</u></bv></b>\n▫ Every even round\n\n<b><bv><u>Explode</u></bv></b>\n▫ Every round\n▫ Usable",
		event = {
			"Airstrike",
			"Örsler",
			"2 kat hız",
			"Bonus Delilik",
		},
		powers = {
			"Jump",
			"Boost",
			"Cheese",
			"Cannon",
			"Explode"
		},
		buy = "Buy",
		equip = "Equip",
		equipped = "Equipped",
		willbeeqippedinnextround = "Will be eqipped in next round",
		close = "Close",
		coins = "Coins"
	},
}

text.e2 = text.en

local language = tfm.get.room.community or "en"
if language == "xx" then
	language = tfm.get.room.playerList[admin].community
end
if not text[language] then
	language = 'en'
end


--[[ Карты--]]

local mapList = {
	{
		code = [[<C><P Ca='' /><Z><S><S L="200" H="40" X="100" Y="380" T="9" P="0,0,,,,0,0,0" /><S L="200" X="700" H="40" Y="380" T="9" P="0,0,,,,0,0,0" /><S L="50" H="20" X="225" Y="370" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="50" X="575" H="20" Y="370" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="300" H="40" X="400" Y="360" T="9" P="0,0,,,,0,0,0" /></S><D><DS Y="340" X="400" /><F Y="100" X="400" /></D><O /></Z></C>]],
		bonusSpawn = function()
			return math.random(15, 785), math.random(325, 375)
		end
	},

	{
		code = [[<C><P Ca='' /><Z><S><S L="200" H="80" X="400" Y="380" T="9" P="0,0,,,,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="20" H="20" c="3" Y="290" T="1" X="220" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="6a7495" X="220" c="4" Y="290" T="12" H="10" /><S X="580" L="20" H="20" c="3" Y="290" T="1" P="0,0,0,0.2,0,0,0,0" /><S H="10" L="10" o="6a7495" X="580" c="4" Y="290" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" X="400" H="60" Y="250" T="9" P="0,0,,,,0,0,0" /><S X="220" L="20" H="20" c="3" Y="210" T="1" P="0,0,0,0.2,0,0,0,0" /><S H="10" L="10" o="6a7495" X="220" c="4" Y="210" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="20" X="580" c="3" Y="210" T="1" H="20" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="6a7495" X="580" c="4" Y="211" T="12" H="10" /><S L="40" X="700" H="220" Y="310" T="9" P="0,0,,,,0,0,0" /><S L="40" H="220" X="100" Y="310" T="9" P="0,0,,,,0,0,0" /><S L="180" H="20" X="210" Y="370" T="9" P="0,0,,,,0,0,0" /><S L="180" X="590" H="20" Y="370" T="9" P="0,0,,,,0,0,0" /></S><D><DS Y="340" X="400" /><F Y="100" X="400" /></D><O /></Z></C>]],
		bonusSpawn = function()
			local coordinates = {
				{100,250},
				{220,250},
				{580,250},
				{700,250},
				{220,355},
				{580,355}
			}
			local out = math.random(1, 6)
			return coordinates[out][1], coordinates[out][2]
		end
	},

	{
		code = [[<C><P Ca='' /><Z><S><S L="50" H="80" X="400" Y="200" T="9" P="0,0,,,,0,0,0" /><S L="50" X="440" H="80" Y="220" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="480" Y="240" T="9" P="0,0,,,,0,0,0" /><S L="50" X="560" H="80" Y="280" T="9" P="0,0,,,,0,0,0" /><S L="50" X="520" H="80" Y="260" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="600" Y="300" T="9" P="0,0,,,,0,0,0" /><S L="50" X="640" H="80" Y="320" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="680" Y="340" T="9" P="0,0,,,,0,0,0" /><S L="50" X="720" H="80" Y="360" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="760" Y="380" T="9" P="0,0,,,,0,0,0" /><S L="50" X="280" H="80" Y="260" T="9" P="0,0,,,,0,0,0" /><S L="50" X="360" H="80" Y="220" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="320" Y="240" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="240" Y="280" T="9" P="0,0,,,,0,0,0" /><S L="50" X="200" H="80" Y="300" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="160" Y="320" T="9" P="0,0,,,,0,0,0" /><S L="50" X="120" H="80" Y="340" T="9" P="0,0,,,,0,0,0" /><S L="50" H="80" X="80" Y="360" T="9" P="0,0,,,,0,0,0" /><S L="50" X="40" H="80" Y="380" T="9" P="0,0,,,,0,0,0" /><S L="20" H="20" X="400" Y="370" T="1" P="0,0,0,0.2,0,0,0,0" /></S><D /><O /></Z></C>]],
		bonusSpawn = function()
			local coordinates = {
				{300,365},
				{500,365},
				{150,150},
				{650,150},
				{400,345},
				{400,60}
			}
			local out = math.random(1, 6)
			return coordinates[out][1], coordinates[out][2]
		end
	},

	{
		code = [[<C><P Ca='' /><Z><S><S L="200" H="100" X="400" Y="200" T="9" P="0,0,,,,0,0,0" /><S L="60" H="250" X="50" Y="275" T="9" P="0,0,,,,0,0,0" /><S L="60" X="750" H="250" Y="275" T="9" P="0,0,,,,0,0,0" /><S L="500" X="400" H="40" Y="400" T="9" P="0,0,,,,0,0,0" /><S L="40" H="40" X="650" Y="380" T="9" P="0,0,,,,0,0,0" /><S L="40" X="150" H="40" Y="380" T="9" P="0,0,,,,0,0,0" /><S L="100" H="20" X="190" Y="160" T="9" P="0,0,,,,0,0,0" /><S L="100" X="610" H="20" Y="160" T="9" P="0,0,,,,0,0,0" /></S><D><F Y="179" D="" X="49" /><F Y="209" D="" X="49" /><F Y="389" D="" X="49" /><F Y="359" D="" X="49" /><F Y="329" D="" X="29" /><F Y="299" D="" X="29" /><F Y="269" D="" X="29" /><F Y="239" D="" X="29" /><F Y="179" D="" X="749" /><F Y="209" D="" X="749" /><F Y="239" D="" X="769" /><F Y="269" D="" X="769" /><F Y="299" D="" X="769" /><F Y="329" D="" X="769" /><F Y="359" D="" X="749" /><F Y="389" D="" X="749" /><DS Y="140" X="400" /></D><O /></Z></C>]],
		bonusSpawn = function()
			return math.random(100, 700), math.random(140, 340)
		end
	},

	{
		code = [[<C><P DS="m;100,385,700,385" Ca="" /><Z><S><S H="300" L="20" X="200" c="3" Y="250" T="1" P="0,0,0,0.2,0,0,0,0" /><S X="200" L="20" H="440" c="3" Y="-180" T="1" P="0,0,0,0.2,0,0,0,0" /><S X="600" L="20" H="300" c="3" Y="250" T="1" P="0,0,0,0.2,0,0,0,0" /><S H="440" L="20" X="600" c="3" Y="-180" T="1" P="0,0,0,0.2,0,0,0,0" /><S H="290" L="10" o="6a7495" X="200" c="4" Y="250" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="6a7495" X="600" c="4" Y="250" T="12" H="290" /><S H="40" L="10" o="6a7495" X="600" c="4" Y="10" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="6a7495" X="200" c="4" Y="10" T="12" H="40" /><S L="300" H="60" X="400" Y="130" T="9" P="0,0,,,,0,0,0" /><S L="300" X="400" H="40" Y="360" T="9" P="0,0,,,,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" H="30" c="3" Y="385" T="15" X="100" /><S L="45" H="30" X="72" Y="385" T="9" P="0,0,,,,0,0,0" /><S L="45" X="127" H="30" Y="385" T="9" P="0,0,,,,0,0,0" /><S L="45" H="30" X="672" Y="385" T="9" P="0,0,,,,0,0,0" /><S L="45" X="727" H="30" Y="385" T="9" P="0,0,,,,0,0,0" /><S X="700" L="10" H="30" c="3" Y="385" T="15" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0,0.2,0,0,0,0" L="1600" X="400" c="3" Y="-10" T="1" H="20" /><S L="100" X="700" H="160" Y="130" T="9" P="0,0,,,,0,0,0" /><S L="100" H="100" X="700" Y="290" T="9" P="0,0,,,,0,0,0" /><S L="100" X="100" H="100" Y="290" T="9" P="0,0,,,,0,0,0" /><S L="100" H="160" X="100" Y="130" T="9" P="0,0,,,,0,0,0" /></S><D><F Y="255" D="" X="130" /><F Y="125" D="" X="70" /><F Y="145" D="" X="80" /><F Y="165" D="" X="83" /><F Y="185" D="" X="79" /><F Y="205" D="" X="69" /><F Y="275" D="" X="120" /><F Y="295" D="" X="116" /><F Y="315" D="" X="120" /><F Y="335" D="" X="130" /><F Y="335" D="" X="669" /><F Y="315" D="" X="679" /><F Y="295" D="" X="683" /><F Y="275" D="" X="680" /><F Y="255" D="" X="670" /><F Y="205" D="" X="730" /><F Y="185" D="" X="720" /><F Y="165" D="" X="716" /><F Y="145" D="" X="720" /><F Y="125" D="" X="730" /><F Y="110" D="" X="400" /><F Y="110" D="" X="530" /><F Y="110" D="" X="270" /><F Y="100" D="" X="410" /><F Y="100" D="" X="390" /><F Y="90" D="" X="400" /><F Y="100" D="" X="280" /><F Y="100" D="" X="260" /><F Y="90" D="" X="270" /><F Y="100" D="" X="520" /><F Y="100" D="" X="540" /><F Y="90" D="" X="530" /></D><O /></Z></C>]],
		bonusSpawn = function()
			local coordinates = {
				{335,130},
				{465,130},
				{100,225},
				{700,225},
				{400,50},
				{400,255}
			}
			local out = math.random(1, 6)
			return coordinates[out][1], coordinates[out][2]
		end
	},

}

local currentMap = math.random(1, #mapList)

--[[ Основное--]]

local isEvent = false
local currentEvent = 1
local bonus, bonusAmount = {}, 0
local objectList, objects = {}, 0
local timer = 0
local round = 0
local bonusRate = 20
local CannonsPairsPerSecond = 1
local canUsePowers = false

function eventLoop(currentTime, timeRemaining)

	timer = timer + 1

	if timer % 20 == 0 then
		for playerName, Data in next, playerData do
			if Data.power == 2 then
				Data.powerUsable = true
			end
		end
	end

	if timer % bonusRate == 0 then
		--[[ Add bonus--]]
		--[[
		0 - + 1 Score
		1 - Cannon
		--]]
		bonusAmount = bonusAmount + 1
		local x, y = mapList[currentMap].bonusSpawn()
		bonus[bonusAmount] = {x = x, y = y, type = math.random(0,1)}
	end

		--[[ Show bonus--]]
	for _, bonusData in next, bonus do
		if bonusData.type == 0 then
			tfm.exec.displayParticle(15, bonusData.x, bonusData.y)
		else
			tfm.exec.displayParticle(29, bonusData.x, bonusData.y)
		end
	end


		--[[ Spawn cannon--]]
	if currentTime > 5000 then
		
		canUsePowers = true

		for i = 1, CannonsPairsPerSecond do
			local newObjectId
			local id = math.random(0,11)
			local x = math.random(15,785)
	
			if id < 10 then
				id = "0"..id
			end
			if id == "00" then
				newObjectId = tfm.exec.addShamanObject(17, x, -200)
			else
				newObjectId = tfm.exec.addShamanObject("17"..id, x, -200)
			end
			tfm.exec.addShamanObject(0, x, 50)
	
			objects = objects + 1
			objectList[objects] = newObjectId
	
			if currentTime > 8500 then
				tfm.exec.removeObject(objectList[1])
				table.remove(objectList, 1)
				objects = objects - 1
			end
		end
	end

	--[[ Reset Game --]]

	if timeRemaining <= 0 then
		for playerName, playerData in next, tfm.get.room.playerList do
			if not playerData.isDead then
				tfm.exec.displayParticle(15, playerData.x, playerData.y, math.random(-100,100)/100, -3, 0, 0.1)
				tfm.exec.displayParticle(15, playerData.x, playerData.y, math.random(-100,100)/100, -3, 0, 0.1)
				tfm.exec.displayParticle(15, playerData.x, playerData.y, math.random(-100,100)/100, -3, 0, 0.1)
				tfm.exec.setPlayerScore(playerName, 3, true)
			end
		end
		bonus = {}
		bonusAmount = 0
		objectList = {}
		objects = 0

		if round == 10 then
			--[[ End --]]
			local winner
			for playerName, playerData in next, tfm.get.room.playerList do
				winner = playerName
				break
			end

			for playerName, Data in next, tfm.get.room.playerList do
				if Data.score > tfm.get.room.playerList[winner].score then
					winner = playerName
				end

				tfm.exec.setPlayerScore(playerName, 0)

				if Data.score >= 30 then
					playerData[playerName].coin = playerData[playerName].coin + 1
				end
			end

			for playerName, Data in next, playerData do
				Data = {
					cannons = 0,
					hasTeleported = false,
					hasCheese = false,
				}
			end

			tfm.exec.newGame([[<C><P DS="y;350" /><Z><S><S L="800" H="40" X="400" Y="380" T="9" P="0,0,,,,0,0,0" /><S H="200" L="100" o="ddac2a" X="400" c="3" Y="300" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="a3790e" X="401" c="3" Y="300" T="12" H="200" /><S X="441" L="10" o="342604" H="200" c="3" Y="300" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="ca9a1d" X="399" c="3" Y="300" T="12" H="200" /><S X="439" L="10" o="a3790e" H="200" c="3" Y="300" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S H="200" L="10" o="a3790e" X="361" c="3" Y="300" T="12" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="10" o="eabe4b" H="200" c="3" Y="300" T="12" X="359" /><S P="0,0,0.3,0.2,0,0,0,0" L="140" o="eabe4b" X="400" c="3" Y="210" T="12" H="20" /><S H="10" L="20" o="eabe4b" X="470" c="3" Y="220" T="13" P="0,0,0.3,0.2,0,0,0,0" /><S P="0,0,0.3,0.2,0,0,0,0" L="20" o="eabe4b" X="330" c="3" Y="220" T="13" H="10" /></S><D /><O /></Z></C>]])
			tfm.exec.setGameTime(600)
			tfm.exec.setUIMapName("#heavyrain - <bl>Zigwin<bl>   <g>|<g>   <v>"..winner.."</v> <n>- "..(text[language].winner).."</n>")
			round = -1

			tfm.exec.movePlayer(winner, 400, 100)

			for playerName, playerData in next, tfm.get.room.playerList do
				if playerName ~= winner then
					tfm.exec.playEmote(playerName, 1)
				else
					tfm.exec.playEmote(playerName, 0)
				end
			end
		else
			--[[ Next Round --]]
			local newMap = math.random(1, #mapList)
			while newMap == currentMap do
				newMap = math.random(1, #mapList)
			end

			currentMap = newMap

			-- Remember if player has cheese
			for playerName, Data in next, tfm.get.room.playerList do
				if not Data.isDead and Data.hasCheese then
					playerData[playerName].hasCheese = true
				end
			end

			tfm.exec.newGame(mapList[currentMap].code)
		end
	end

	--[[ Events --]]
	if isEvent then
		if currentEvent == 2 and timer % 20 == 0 then
			--[[ Spawn anvils --]]
			for i = 1, 10 do
				local x = math.random(0, 1) == 0 and i*80-40 or i*80-80
				tfm.exec.addShamanObject(10, x, -200, 90, 0, 0)
				tfm.exec.addShamanObject(0, x, 50)
			end
		elseif currentEvent == 1 then
			--[[ Airstrike--]]
			if timer % 60 == 0 or (currentTime > 10000 and currentTime < 10500) then
				local randomPos = math.random(40, 760)
				tfm.exec.addPhysicObject(0, randomPos, 100, {type = 8,
					width = 80,
					height = 20,
					miceCollision = false,
					groundCollision = true
				})
				tfm.exec.displayParticle(33, randomPos, 200)
				tfm.exec.displayParticle(33, randomPos+10, 200)
				tfm.exec.displayParticle(33, randomPos-10, 200)
				for i = 1, 28 do
					local x = i * 30 - 50
					tfm.exec.addShamanObject(17, x, -500)
					tfm.exec.addShamanObject(0, x, 50)
				end
			elseif timer % 64 == 0 or (currentTime >= 12000 and currentTime < 12500)then
				tfm.exec.removePhysicObject(0)
			end
		end
	end
end

function eventNewGame()
	canUsePowers = false

	timer = 0

	for playerName, Data in next, playerData do
		Data.hasTeleported = false
		if Data.hasCheese then
			tfm.exec.giveCheese(playerName)
		end
		updateItem(playerName)

		--[[ Change power--]]

		Data.power = Data.nextPower

		--[[ Recharge powers --]]

		local power = Data.power

		if power ~= 0 then
			if power == 1 or power == 2 or power == 5 then
				Data.powerUsable = true
			elseif power == 4 and round % 2 == 0 then
				Data.cannons = Data.cannons + 1
				updateItem(playerName)
			elseif power == 3 then
				tfm.exec.giveCheese(playerName)
			end
		end
	end

	round = round + 1

	if round == 10 or round == 5 then
	--if round > 0 then			-- DEBUG
		--[[ Event --]]
		local newEvent = math.random(1, 4)
		while newEvent == currentEvent do
			newEvent = math.random(1, 4)
		end

		currentEvent = newEvent
		--currentEvent = 3		-- DEBUG

		--[[
			Airstrike
			Falling balls
			Cannons Double Speed
			Bonus Madness
		--]]

		--if currentEvent == 1 then
		--elseif currentEvent == 2 then			
		if currentEvent == 3 then
			CannonsPairsPerSecond = 2
		elseif currentEvent == 4 then
			bonusRate = 2
		end

		updateText(true)

		isEvent = true

	end

	if round <= 1 or round == 6 then
		
		--if currentEvent == 1 then

		--elseif currentEvent == 2 then

		if currentEvent == 3 then
			CannonsPairsPerSecond = 1
		elseif currentEvent == 4 then
			bonusRate = 20
		end				
		updateText(false)

		isEvent = false
	end
	tfm.exec.setUIMapName("#heavyrain - <bl>Zigwin<bl>   <g>|<g>   <n>"..(text[language].round).." : </n><v>"..round.." / 10</v>")
end

function eventMouse(playerName, xMousePosition, yMousePosition)
	local Data = tfm.get.room.playerList[playerName]
	if not Data.isDead then
		if Data.hasCheese and not playerData[playerName].hasTeleported and xMousePosition > -10 and xMousePosition < 810 and yMousePosition > -10 then
			playerData[playerName].hasTeleported = true
			playerData[playerName].hasCheese = false

			tfm.exec.displayParticle(36, Data.x, Data.x)
			tfm.exec.movePlayer(playerName, xMousePosition, yMousePosition)
			tfm.exec.displayParticle(37, xMousePosition, yMousePosition)
			tfm.exec.removeCheese(playerName)

			--[[ Update Item Display--]]
			local Cannons = playerData[playerName].cannons
			if Cannons > 0 then
				if Cannons == 1 then
					ui.updateTextArea(2, "<n><b>Cannon", playerName)
					ui.updateTextArea(3, "<font color='#000000'><b>Cannon", playerName)
				else
					ui.updateTextArea(2, "<n><b>Cannons x "..Cannons, playerName)
					ui.updateTextArea(3, "<font color='#000000'><b>Cannons x "..Cannons, playerName)
				end
			else
				ui.updateTextArea(2, "", playerName)
				ui.updateTextArea(3, "", playerName)
			end

			return
		end

		if playerData[playerName].cannons > 0 then
			playerData[playerName].cannons = playerData[playerName].cannons - 1

			tfm.exec.addShamanObject(17, xMousePosition, -200, 180)

			updateItem(playerName)
			return
		end
	end
end

function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)
	local Data = playerData[playerName]
	if keyCode == 0 then
		Data.facingRight = false
	elseif keyCode == 2 then
		Data.facingRight = true
	end

	if keyCode == 72 then
		updateHelp(playerName)
	end

	local playerPower = Data.power

	if playerPower ~= 0 and keyCode == 3 and canUsePowers then
		local powerUsable = Data.powerUsable

		if powerUsable then
			-- 1 - Jump Boost		- Every round ; Usable
			-- 2 - Speed Boost		- Every 20 seconds ; Usable
			-- 5 - Explode			- Every round ; Usable
			if playerPower == 1 then
				tfm.exec.movePlayer(playerName, 0, 0, 0, 0, -150)
			elseif playerPower == 2 then
				local facingRight = Data.facingRight
				if facingRight then
					tfm.exec.movePlayer(playerName, 0, 0, 0, 150)
				else
					tfm.exec.movePlayer(playerName, 0, 0, 0, -150)
				end
			elseif playerPower == 5 then
				drawExplosionParticles(xPlayerPosition, yPlayerPosition)
				tfm.exec.explosion(xPlayerPosition, yPlayerPosition, 50, 100, false)
				tfm.exec.killPlayer(playerName)
			end
			Data.powerUsable = false
		end
	end

	--[[ Bonus check--]]
	if not tfm.get.room.playerList[playerName].isDead then
		for bonusId, bonusData in next, bonus do
			if xPlayerPosition >= bonusData.x - 15 and xPlayerPosition <= bonusData.x + 15 and yPlayerPosition >= bonusData.y - 15 and yPlayerPosition <= bonusData.y + 15 then

				if bonusData.type == 0 then
					tfm.exec.setPlayerScore(playerName, 1, true)
					tfm.exec.displayParticle(15, xPlayerPosition, yPlayerPosition, 0, -2, 0, 0.1)
				else
					Data.cannons = Data.cannons + 1
					tfm.exec.displayParticle(29, xPlayerPosition, yPlayerPosition, 0, -2, 0, 0.1)

					updateItem(playerName)
				end
				table.remove(bonus, bonusId)
				bonusAmount = bonusAmount - 1
				return
			end
		end
	end
end

function eventTextAreaCallback(textAreaId, playerName, callback)
	if callback == 'pageleft' then
		if playerData[playerName].powersShopPage > 1 then
			playerData[playerName].powersShopPage = playerData[playerName].powersShopPage - 1
			drawPowersShop(playerName)
		end
	elseif callback == 'pageright' then
		if playerData[playerName].powersShopPage < 2 then
			playerData[playerName].powersShopPage = playerData[playerName].powersShopPage + 1
			drawPowersShop(playerName)
		end
	elseif callback == 'close' then
		for i = 1, 13 do
			ui.removeTextArea('2'..tostring(i), playerName)
		end
	elseif callback:sub(1,5) == 'equip' then
		playerData[playerName].nextPower = tonumber(callback:sub(6,6))
		drawPowersShop(playerName)
	elseif callback:sub(1,3) == 'buy' then
		local number = tonumber(callback:sub(4,4))
		playerData[playerName].powerList[number] = true
		playerData[playerName].nextPower = number
		drawPowersShop(playerName)
	end
end

function eventPlayerDied(playerName)
	playerData[playerName].hasCheese = false

	tfm.exec.setPlayerScore(playerName, 1, true)

	-- If one player left set time to 5
	local alive = false
	for playerName, playerData in next, tfm.get.room.playerList do
		if not playerData.isDead then
			if alive then
				return
			else
				alive = true
			end
		end
	end
	tfm.exec.setGameTime(5)
end

function eventChatCommand(playerName, message)
	--[[ Help message--]]
	if message == 'help' then
		updateHelp(playerName)
	elseif message == 'shop' then
		drawPowersShop(playerName)
	end
end

function eventPlayerGetCheese(playerName)
	updateItem(playerName)
end

function drawExplosionParticles(x, y)
	local draw = tfm.exec.displayParticle
	-- Clouds
	draw(3, x, y, 10, 0, -0.5, -0.1)
	draw(3, x, y, -10, 0, 0.5, -0.1)
	draw(3, x, y, 12, 1, -0.5, -0.1)
	draw(3, x, y, -12, 1, 0.5, -0.1)
	draw(3, x, y, 0.5, -12, -0.1, 0.5)
	draw(3, x, y, -0.5, -12, 0.1, 0.5)
	draw(3, x, y, 1, -11.3, -0.2, 0.6)
	draw(3, x, y, -1, -11.3, 0.2, 0.6)
	draw(3, x, y, 0, -12.5, 0, 0.5)
	-- Spirit
	draw(10, x, y, 0, 0, 0, 0)
	-- Confetti
	draw(math.random(21,24), x, y, 11 + math.random(-1,1), 0 + math.random(-1,1), -0.5, 0)
	draw(math.random(21,24), x, y, -11 + math.random(-1,1), 0 + math.random(-1,1), 0.5, 0)
	draw(math.random(21,24), x, y, 10.8 + math.random(-1,1), 2 + math.random(-1,1), -0.5, -0.1)
	draw(math.random(21,24), x, y, -10.8 + math.random(-1,1), 2 + math.random(-1,1), 0.5, -0.1)
	draw(math.random(21,24), x, y, 10.8 + math.random(-1,1), -2 + math.random(-1,1), -0.5, 0.1)
	draw(math.random(21,24), x, y, -10.8 + math.random(-1,1), -2 + math.random(-1,1), 0.5, 0.1)
	draw(math.random(21,24), x, y, 10.5 + math.random(-1,1), -4 + math.random(-1,1), -0.5, 0.2)
	draw(math.random(21,24), x, y, -10.5 + math.random(-1,1), -4 + math.random(-1,1), 0.5, 0.2)
	draw(math.random(21,24), x, y, 10 + math.random(-1,1), -5.8 + math.random(-1,1), -0.5, 0.3)
	draw(math.random(21,24), x, y, -10 + math.random(-1,1), -5.8 + math.random(-1,1), 0.5, 0.3)
	draw(math.random(21,24), x, y, 9 + math.random(-1,1), -7.5 + math.random(-1,1), -0.5, 0.35)
	draw(math.random(21,24), x, y, -9 + math.random(-1,1), -7.5 + math.random(-1,1), 0.5, 0.35)
	draw(math.random(21,24), x, y, 8 + math.random(-1,1), -8 + math.random(-1,1), -0.5, 0.3)
	draw(math.random(21,24), x, y, -8 + math.random(-1,1), -8 + math.random(-1,1), 0.5, 0.3)
	draw(math.random(21,24), x, y, 7 + math.random(-1,1), -8.5 + math.random(-1,1), -0.5, 0.2)
	draw(math.random(21,24), x, y, -7 + math.random(-1,1), -8.5 + math.random(-1,1), 0.5, 0.2)
	draw(math.random(21,24), x, y, 6 + math.random(-1,1), -8.8 + math.random(-1,1), -0.5, 0.1)
	draw(math.random(21,24), x, y, -6 + math.random(-1,1), -8.8 + math.random(-1,1), 0.5, 0.1)
end

function updateText(show)
	if show then
		for playerName, playerData in next, tfm.get.room.playerList do
			-- Get Langugae
			local language = playerData.community
			if not text[language] then language = "en" end

			-- Update Text
			ui.updateTextArea(0, "<font color='#000000' size='20' ><p align='center'><b>"..(text[language].event[currentEvent]))
			ui.updateTextArea(1, "<font size='20' ><j><p align='center'><b>"..(text[language].event[currentEvent]))
		end
	else
		ui.updateTextArea(0, "")
		ui.updateTextArea(1, "")
	end
end

function updateItem(playerName)
	local Cannons = playerData[playerName].cannons
	if tfm.get.room.playerList[playerName].hasCheese then
		ui.updateTextArea(2, "<font color='#000000'><b>Teleport", playerName)
		ui.updateTextArea(3, "<bv><b>Teleport", playerName)
	elseif Cannons > 0 then
		if Cannons == 1 then
			ui.updateTextArea(2, "<n><b>Cannon", playerName)
			ui.updateTextArea(3, "<font color='#000000'><b>Cannon", playerName)
		else
			ui.updateTextArea(2, "<n><b>Cannons x "..Cannons, playerName)
			ui.updateTextArea(3, "<font color='#000000'><b>Cannons x "..Cannons, playerName)
		end
	else
		ui.updateTextArea(2, "", playerName)
		ui.updateTextArea(3, "", playerName)
	end
end

function updateHelp(playerName)
	-- Get language
	local language = tfm.get.room.playerList[playerName].community
	if not text[language] then
		language = 'en'
	end

	-- Show help
	playerData[playerName].isHelpVisible = not playerData[playerName].isHelpVisible
	if playerData[playerName].isHelpVisible then
		ui.addTextArea(10, "", playerName, 100, 50, 600, 300, 0x3f3f3f, 0x3f3f3f, 1, true)
		ui.addTextArea(11, text[language].help1, playerName, 110, 60, 300, 280, 0x151515, 0x151515, 1, true)
		ui.addTextArea(12, "", playerName, 101, 51, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
		ui.addTextArea(13, "", playerName, 101, 348, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
		ui.addTextArea(14, "", playerName, 698, 348, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
		ui.addTextArea(15, "", playerName, 698, 51, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
		ui.addTextArea(16, text[language].help2, playerName, 430, 60, 260, 280, 0x151515, 0x151515, 1, true)
	else
		for i = 10, 16 do
			ui.removeTextArea(i, playerName)
		end
	end
end

function drawPowersShop(playerName)
	ui.addTextArea(27, "", playerName, 330, 275, 140, 30, 0x3f3f3f, 0x3f3f3f, 1, true)
	ui.addTextArea(28, "", playerName, 220, 150, 360, 120, 0x3f3f3f, 0x3f3f3f, 1, true)
	ui.addTextArea(29, "", playerName, 221, 151, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
	ui.addTextArea(210, "", playerName, 221, 268, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
	ui.addTextArea(211, "", playerName, 578, 268, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)
	ui.addTextArea(212, "", playerName, 579, 151, 1, 1, 0x8f8f8f, 0x8f8f8f, 1, true)

	local language = tfm.get.room.playerList[playerName].community
	if not text[language] then language = 'en' end

	ui.addTextArea(213, text[language].coins.." : "..playerData[playerName].coin, playerName, 5, 25, 0, 0, nil, nil, 0, true)

	for i = 1, 3 do
		local desc
		local page = playerData[playerName].powersShopPage
		local powerId = i+(page*3-3)

		if powerId > 5 then
			break
		end

		local isAvailable = playerData[playerName].powerList[powerId]

		if isAvailable then
			if powerId == playerData[playerName].power then
				desc = text[language].equipped
			elseif powerId == playerData[playerName].nextPower then
				desc = text[language].willbeeqippedinnextround
			else
				desc = isAvailable and "<p align='center'><a href='event:equip"..powerId.."'>"..text[language].equip.."</a>" or ""
			end
		else
			desc = "<p align='center'><a href='event:buy"..tostring(powerId).."'>"..text[language].buy.."</a>"
		end

		ui.addTextArea(20 + i, "<bv><p align='center'><font size='14'><u>"..(text[language].powers[powerId]).."</u></p></bv>\n\n"..desc, playerName, 110 + i * 120, 160, 100, 100, 0x151515, 0x151515, 1, true)
	end

	ui.addTextArea(24, "<p align='center'><font size='14'><a href='event:pageleft'>‹", playerName, 335, 280, 20, 20, 0x151515, 0x151515, 1, true)
	ui.addTextArea(25, "<p align='center'><font size='14'><a href='event:pageright'>›", playerName, 445, 280, 20, 20, 0x151515, 0x151515, 1, true)
	ui.addTextArea(26, "<p align='center'><a href='event:close'>"..text[language].close, playerName, 370, 280, 60, 20, 0x151515, 0x151515, 1, true)
end

ui.addTextArea(0, "", nil, 0, 42, 802, 0, nil, nil, 0)
ui.addTextArea(1, "", nil, 0, 40, 800, 0, nil, nil, 0)

ui.addTextArea(2, "", nil, 26, 366, 201, 0, nil, nil, 0)
ui.addTextArea(3, "", nil, 25, 365, 200, 0, nil, nil, 0)

tfm.exec.disableAutoShaman(true)
tfm.exec.disableAutoScore(true)
tfm.exec.disableAutoNewGame(true)
tfm.exec.disableAutoTimeLeft(true)
tfm.exec.newGame(mapList[currentMap].code)
tfm.exec.setUIMapName("#Module - <bl>Zigwin<bl>   <g>|<g>   <n>"..(text[language].round).." : </n><v>"..round.." / 10</v>")

do
	for playerName in next, tfm.get.room.playerList do
		tfm.exec.setPlayerScore(playerName, 0, false)
	end
end

--