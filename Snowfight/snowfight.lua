--[[ Snow Fight
-- defn0tubi
]]


local admin
do local _,name = pcall(nil)
	admin = string.match(name, "(.-)%.")
end

local playerData = {}

local text = {

    ["ru"] = {
        snowballSpeed = "Скорость броска",
        helpText = "<p align='center'><font size='16'><bv>#</bv><font color='#E4E5E6'>Snowfight</font></n></font></p>\n<u><font color='#E4E5E6' size='14'>Управление</font></u>\n<r>꘎</r> <font color='#E4E5E6'><b>Left Mouse Button</b></font> - бросить снежок\n<r>꘎</r> <font color='#E4E5E6'><b>E</b></font> - телепортироваться (есть бонус телепортации)\n\n<u><font color='#E4E5E6' size='14'>Бонусы</font></u>\n<r>꘎</r> <font color='#E4E5E6'><b>Облако</b></font> - дает дополнительный снежок"
    },

    ["en"] = {
        snowballSpeed = "Snowball speed",
        helpText = "<p align='center'><font size='16'><bv>#</bv><font color='#E4E5E6'>Snowfight</font></n></font></p>\n<u><font color='#E4E5E6' size='14'>Controls</font></u>\n<r>꘎</r> <font color='#E4E5E6'><b>Left Mouse Button</b></font> - throw snowball\n<r>꘎</r> <font color='#E4E5E6'><b>E</b></font> - teleport (with teleportation bonus)\n\n<u><font color='#E4E5E6' size='14'>Bonuses</font></u>\n<r>꘎</r> <font color='#E4E5E6'><b>Cloud</b></font> - gives bonus snowball"
    },

}
text["e2"] = text["en"]

local langID = {
    "ru",
    "en"
}


local counter = 0
local bonusRate = 20
local bonus, bonusAmount = {}, 0
local BBoxes, boxID = {}, 0

local mapList = {
    {
        code = [[<C><P /><Z><S><S P="0,0,0.05,0.1,0,0,0,0" L="801" X="400" H="35" Y="384" T="11" /></S><D><P X="90" P="0,0" Y="238" T="54" /><P X="715" P="0,0" Y="212" T="59" /><P X="59" P="0,0" Y="162" T="59" /><P X="69" P="0,0" Y="367" T="51" /><P X="695" P="0,0" Y="252" T="54" /><P P="0,0" X="685" Y="179" T="59" /><P X="703" P="0,0" Y="370" T="51" /><P X="422" P="0,0" Y="200" T="59" /><P X="384" P="0,0" C="c54000" Y="262" T="60" /><P X="417" P="0,0" Y="239" T="54" /><P X="382" P="0,0" Y="224" T="59" /><P X="402" P="0,0" Y="370" T="51" /><P X="418" P="0,0" Y="386" T="55" /><P X="380" P="0,0" Y="387" T="55" /><P X="39" P="0,0" Y="387" T="55" /><P X="91" P="0,0" Y="385" T="55" /><P X="559" P="0,0" Y="371" T="57" /></D><O /></Z></C>]],
        bonusSpawn = function()
            return math.random(100, 700), math.random(140, 340)
        end
    },

    {
        code = [[<C><P L="1600" defilante="0,0,0,1" /><Z><S><S L="30" X="19" H="200" Y="194" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="20" X="19" H="190" Y="195" T="3" P="0,0,0,20,0,0,0,0" /><S L="30" H="200" X="1580" Y="194" T="1" P="0,0,0,0.2,0,0,0,0" /><S L="20" H="190" X="1580" Y="195" T="3" P="0,0,0,20,0,0,0,0" /><S L="400" X="800" H="20" Y="390" T="11" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" X="399" H="20" Y="390" T="11" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" X="1200" H="20" Y="390" T="11" P="0,0,0.3,0.2,0,0,0,0" /><S L="160" X="1300" H="20" Y="160" T="11" P="0,0,0.3,0.2,0,0,0,0" /><S L="160" X="300" H="20" Y="160" T="11" P="0,0,0.3,0.2,0,0,0,0" /><S L="200" X="800" H="20" Y="120" T="11" P="0,0,0.3,0.2,0,0,0,0" /></S><D><DS Y="365" X="800" /><P X="800" Y="108" T="173" P="0,0" /><P X="322" Y="380" T="132" P="0,0" /><P X="220" Y="170" T="58" P="0,0" /><P X="299" Y="170" T="58" P="0,0" /><P X="1222" Y="170" T="58" P="0,0" /><P X="1299" Y="170" T="58" P="0,0" /><P X="1324" Y="149" T="143" P="0,0" /><P X="751" Y="379" T="143" P="0,0" /><P X="1281" Y="380" T="50" P="0,0" /><P X="270" Y="150" T="62" P="0,0" /></D><O /></Z></C>]],
        bonusSpawn = function()
            local coordinates = {
                {361,359},
                {1243,359},
                {16,80},
                {804,88},
                {804,196},
                {687,118},
                {912,118},
                {1363,133},
                {1236,133},
                {354,133},
                {241,133},
                {543,154},
                {1046,154}
            }
            local i = math.random(#coordinates)

            return coordinates[i][1], coordinates[i][2]
        end
    },
}
local currentMap = math.random(#mapList)


function eventNewPlayer(playerName)
    local Data = tfm.get.room.playerList[playerName]
    system.bindMouse(playerName, true)
    system.bindKeyboard(playerName, 72, true, true) -- H down

    if not playerData[playerName] then
        playerData[playerName] = {
            coordStep = 0,
            standing = false,
            x = tfm.get.room.playerList[playerName].x,
            y = tfm.get.room.playerList[playerName].y,
            points = 0,
            snowballSpeed = 10, -- snowball speed multiplier
            bonusSnowballs = 0,
            cooldown = 500,
            delay = 500,
            skills = {false, false, false},
            powers = {false, false, false},
            inGame = false,
            charge = 1,
            helpOpened = false,
            language = text[Data.community] and Data.community or 'en'
        }
    end
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)


function snowball(x1, y1, x2, y2, playerName)
    local Data = playerData[playerName]
    local force = Data.snowballSpeed * Data.charge

    local dx, dy = x2-x1, y2-y1
    local a = math.atan2(dy, dx)
    local vx, vy = math.cos(a), math.sin(a)

    if Data.powers[1] then
        for i = 3, 9, 3 do
            tfm.exec.addShamanObject(34, x1 + 20 * vx, y1 + 20 * vy + i, a*180/math.pi, force * vx, force * vy, false)
        end
    else
        tfm.exec.addShamanObject(34, x1 + 20 * vx, y1 + 20 * vy, a*180/math.pi, force * vx, force * vy, false)
    end

    Data.charge = 1
    playerDanger(playerName)
end


function addBBox(x, y, color)
    local id = bonusAmount
    BBoxes[bonusAmount] = id

    tfm.exec.addPhysicObject(id,x,y,{
        type=12,
        restitution=0,
        friction=0,
        width=20,
        height=20,
        color=color,
        groundCollision=false,
        miceCollision=false
    })
end


function table.get(t, get)

    for i,v in next, t do
        if v == get then
            return i
        end
    end
    return false
end


function playerDanger(playerName)
    local Data = playerData[playerName]

    if Data.charge >= 5 then
        tfm.exec.setNameColor(playerName, 0xC1403D)
    elseif Data.charge >= 3.7 then
        tfm.exec.setNameColor(playerName, 0x51B2CF)
    elseif Data.charge > 2 then
        tfm.exec.setNameColor(playerName, 0x77C67F)
    elseif Data.charge < 2 then
        tfm.exec.setNameColor(playerName, 0xD4DADC)
    end
end


function helpMessage(playerName)
    playerData[playerName].helpOpened = not playerData[playerName].helpOpened

    if playerData[playerName].helpOpened then
        ui.addTextArea(0,text[playerData[playerName].language].helpText,playerName,225,50,350,300,0x324650,0x212F36,1,true)
        ui.addTextArea(-1,"<p align='center'><a href='event:prevlang'>←</a> "..string.upper(tostring(playerData[playerName].language)).." <a href='event:nextlang'>→</a></p>",playerName,515,335,60,25,0x000000,0x000000,1,true)
    else
        ui.removeTextArea(0, playerName)
        ui.removeTextArea(-1, playerName)
    end
end


function eventMouse(playerName, xMousePosition, yMousePosition)
    local Data1 = playerData[playerName]
    local Data2 = tfm.get.room.playerList[playerName]

    if Data1.cooldown + Data1.delay < os.time() and not Data2.isDead then
        snowball(Data1.x, Data1.y, xMousePosition, yMousePosition, playerName)
        Data1.cooldown = os.time()
    elseif Data1.cooldown + Data1.delay > os.time() and not Data2.isDead then
        if Data1.bonusSnowballs > 0 then
            snowball(Data1.x, Data1.y, xMousePosition, yMousePosition, playerName)
            Data1.bonusSnowballs = Data1.bonusSnowballs - 1
        end
    end
end


function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)
    local Data = playerData[playerName]

    if keyCode == 72 then
        helpMessage(playerName)
    end
end


function eventLoop(currentTime, timeRemaining)
    counter = counter + 1

    if timeRemaining <= 0 then
        local nextMap = math.random(#mapList)
        while currentMap == nextMap do
            nextMap = math.random(#mapList)
        end
        currentMap = nextMap

        resetRound()
    end

    if counter % bonusRate == 0 then
        bonusAmount = bonusAmount + 1
		local x, y = mapList[currentMap].bonusSpawn()
        bonus[bonusAmount] = {x = x, y = y, type = math.random(0,2)}
    end

    for _, bonusData in next, bonus do
		if bonusData.type == 0 then
			addBBox(bonusData.x, bonusData.y, 0x33D650)
        elseif bonusData.type == 1 then
            addBBox(bonusData.x, bonusData.y, 0xC83533)
        else
            addBBox(bonusData.x, bonusData.y, 0x3382E7)
		end
	end

    for name, data in next, playerData do
        if counter % 4 == 0 then
            data.charge = data.charge + 0.3 > 5 and 5 or data.charge + 0.3
        end
        playerDanger(name)

        if data.multishotDuration and data.multishotDuration + 10000 < os.time() then
            data.multishotDuration = nil
            data.powers[1] = false
        end

        if data.rapidfireDuration and data.rapidfireDuration + 3000 < os.time() then
            data.delay = 500
            data.rapidfireDuration = nil
            data.powers[2] = false
        end

        local lang = data.language
        ui.addTextArea(1,"<font size='12'><n><b>"..text[lang].snowballSpeed..": "..data.charge.."</b></n></font>",name,3,25,165,40,0x000000,0x000000,1,true)
    end

end

-- [[ Coordinates & bonus system // thx to Zigwin#0000 ]]
local sensors = {}

function eventPlayerBonusGrabbed(playerName, bonusId)
    x, y = xyToCoord(bonusId)

    playerData[playerName].x = x
    playerData[playerName].y = y

    xPlayerPosition = playerData[playerName].x
    yPlayerPosition = playerData[playerName].y

    for bonusId, bonusData in next, bonus do
        if xPlayerPosition >= bonusData.x - 20 and xPlayerPosition <= bonusData.x + 20 and yPlayerPosition >= bonusData.y - 20 and yPlayerPosition <= bonusData.y + 20 then
            if bonusData.type == 0 then
                tfm.exec.setPlayerScore(playerName, 1, true)
                tfm.exec.displayParticle(3, xPlayerPosition, yPlayerPosition, 0, -2, 0, 0.1)

                playerData[playerName].powers[1] = true
                playerData[playerName].multishotDuration = os.time()
            elseif bonusData.type == 1 then
                tfm.exec.setPlayerScore(playerName, 1, true)
                tfm.exec.displayParticle(5, xPlayerPosition, yPlayerPosition, 0, -2, 0, 0.1)

                playerData[playerName].powers[2] = true
                playerData[playerName].rapidfireDuration = os.time()
                playerData[playerName].delay = 150
            else
                tfm.exec.displayParticle(29, xPlayerPosition, yPlayerPosition, 0, -2, 0, 0.1)

                playerData[playerName].bonusSnowballs = playerData[playerName].bonusSnowballs + 1
            end

            table.remove(bonus, bonusId)
            tfm.exec.removePhysicObject(bonusId)
            table.remove(BBoxes, bonusId)
            bonusAmount = bonusAmount - 1
            return
        end
    end

    xyBonus(x, y, 0, false, playerName)
end

function xyBonus(x, y, a, visible, player)
    local negativeY = false
    if y < 0 then negativeY = true end
    id = x*1000+y
    sensors[id] = negativeY
    tfm.exec.addBonus(0, x, y, id, a or 0, false, player)
end

function xyToCoord(xy)
    if sensors[xy] then
        return (xy-xy%1000)/1000, -(-xy%1000)
    else
        return (xy-xy%1000)/1000, xy%1000
    end

    table.remove(sensors, xy)
end

function resetRound()
    tfm.exec.newGame(mapList[currentMap].code)
    for x = -300, 1900, 25 do
        for y = -400, 400, 25 do
            xyBonus(x, y)
        end
    end
    tfm.exec.snow(0, 50)
end
-- [[ Coordinates & bonus system--]]


function eventPlayerDied(playerName)
    tfm.exec.respawnPlayer(playerName)
end


function eventTextAreaCallback(textAreaID, playerName, callback)
    local Data1 = playerData[playerName]

    if textAreaID == -1 then
        local currentLangPos = table.get(langID, Data1.language)

        if callback == "prevlang" then
            if not langID[currentLangPos - 1] then
                Data1.language = langID[#langID]
            else
                Data1.language = langID[currentLangPos - 1]
            end
        end

        if callback == "nextlang" then
            if not langID[currentLangPos + 1] then
                Data1.language = langID[1]
            else
                Data1.language = langID[currentLangPos + 1]
            end
        end

        for i = 1, 2 do
            helpMessage(playerName)
        end
    end
end

tfm.exec.disableAutoNewGame()
tfm.exec.disableAutoTimeLeft()
tfm.exec.disableAutoShaman()
tfm.exec.disableAfkDeath()


resetRound()