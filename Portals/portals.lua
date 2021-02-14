tfm.exec.disableAutoShaman(true)
tfm.exec.disablePhysicalConsumables(true)
tfm.exec.newGame("@7719367")
 
function eventPlayerDied(name)
    tfm.exec.respawnPlayer(name)
end
 
--------------------------------------
local grounds = {}
local cheese = {}
local xml

local tm = os.time()
local colors = {"15a600", "a69800", "ff9b00", "423520", "fff9"} -- colored grounds
--------------------------------------
local levels = {7697646, 7758437, 6070370, 7698072, 7758927, 7791618, 7699001, 7791556, 7791798, 7698245, 7758441, 7758484, 7759023, 7758420, 7796655, 7759281, 7758919, 7759615, 7761263, 7712060, 7759326, 7762166, 7760368, 7760342, 7791634, 7791038, 7791316, 7791005, 7791066, 7791278}
--------------------------------------
local adm
do local _,name = pcall(nil)
    adm = string.match(name, "(.-)%.")
end


function table.exists(t, v) -- return true if value exists
    for _, v2 in next, t do
        if v2 == v then
            return true
        end
    end
    return false
end

--[[--------------------------------------]]--
local Bonus = {}


function eventPlayerBonusGrabbed(playerName, bonusId)
    local playerData = tfm.get.room.playerList[playerName]
    -- Бонус из списка
    local bonus = Bonus[playerName].list[bonusId]

    if bonus.other.attachedColor == "15a600" then -- зеленый
        if playerData.hasCheese then
            tfm.exec.killPlayer(playerName)
        end

    elseif bonus.other.attachedColor == "a69800" then -- желтый 
        if not playerData.hasCheese then
            tfm.exec.killPlayer(playerName)
        end

    elseif bonus.other.attachedColor == "ff9b00" then -- оранжевый
        if playerData.cheeses ~= #cheese then
            tfm.exec.killPlayer(playerName)
        end
    

    elseif bonus.other.attachedColor == "423520" then -- коричневый
        if playerData.cheeses >= 2 then
            tfm.exec.killPlayer(playerName)
        end
    

    elseif bonus.other.attachedColor == "fff9" then -- голубой
        tfm.exec.addShamanObject(26,0,0)
        tfm.exec.addShamanObject(27,0,0)
    end

    -- Создать новый бонус на том же месте
    bonusAdd(bonus.id, bonus.x, bonus.y, playerName, bonus.other)
end


-- Создать бонус
function bonusAdd(id, x, y, playerName, other)    
    if not id then
        Bonus[playerName].lastId = Bonus[playerName].lastId + 1
        id = Bonus[playerName].lastId
    end

    Bonus[playerName].list[id] = {
        id = id,
        x = x,
        y = y,
        other = other,
    }

    tfm.exec.addBonus(0, x, y, id, 0, false, playerName)
    return id
end


-- Заполнить область начальными бонусами
function bonusFill(x0, y0, x1, y1, name, other)
    for x = x0 or 0, x1 or 800, 25 do
        for y = y0 or 0, y1 or 400, 25 do
            bonusAdd(nil, x, y, name, other)
        end
    end
end


--[[--------------------------------------]]--
function loadMapBonus(player, xml)
    if not xml then return end

    for pos,ground in next, grounds do
        local l = ground.L
        local h = ground.H
        local x = ground.X
        local y = ground.Y

        if ground.o and table.exists(colors, ground.o) then
            local w = {math.floor(x-l/2)+5, math.floor(x+l/2)}
            local h = {math.floor(y-h/2)+5, math.floor(y+h/2)}

            bonusFill(w[1], h[1], w[2], h[2], player, {
                attachedColor = ground.o,
            })
        end
    end
end


function eventNewGame()
    xml = tfm.get.room.xmlMapInfo.xml
    cheese = {}
    grounds = {}
    for k in next, tfm.get.room.playerList do
        Bonus[k].lastId = 0
        Bonus[k].list = {}
    end

    tfm.exec.disableAfkDeath(true)
    tfm.exec.disableAutoTimeLeft(true)
    tfm.exec.setGameTime(300000)
    tfm.exec.disableAutoScore(true)
    tfm.exec.disableAutoNewGame(true)
    ui.setMapName("<font color='#FF8F00'>• Пор<font color='#0076FF'>тал •</font> \n" )
 
    width = tonumber(xml:match('<P[^/]+L="([^"]+)"[^/]+/>')) or 800
    height = tonumber(xml:match('<P[^/]+H="([^"]+)"[^/]+/>')) or 400

    for ground in xml:gmatch("<S[^/]+/>") do
        local pos = #grounds + 1
        grounds[pos] = {}
        grounds[pos].X = tonumber(ground:match('X="([^"]+)"'))
        grounds[pos].Y = tonumber(ground:match('Y="([^"]+)"'))
        grounds[pos].L = tonumber(ground:match('L="([^"]+)"'))
        grounds[pos].H = tonumber(ground:match('H="([^"]+)"'))
        grounds[pos].T = tonumber(ground:match('T="([^"]+)"'))
        grounds[pos].o = ground:match('o="([^"]+)"')
    end

    if xml:gmatch('dodue=""') then
        for cheeseInfo in xml:gmatch("<F[^/]+/>") do
            local pos = #cheese + 1
            cheese[pos] = {}

            cheese[pos].X = tonumber(cheeseInfo:match('X="([^"]+)"'))
            cheese[pos].Y = tonumber(cheeseInfo:match('Y="([^"]+)"'))
        end
    end

    for k in next, tfm.get.room.playerList do
        loadMapBonus(k, xml)
    end
end


function eventMouse(name, x2, y2)
    if os.time() >= tm + 1000 then
        local brk, stopSpawn
        local player = tfm.get.room.playerList[name]
        local deltaX = x2 - player.x
        local deltaY = y2 - player.y
        local normalizer = math.sqrt(math.pow(deltaX, 2) + math.pow(deltaY, 2))
        deltaX = deltaX / normalizer
        deltaY = deltaY / normalizer
        for t = 0, math.huge, math.min(math.abs(5 / deltaX), math.abs(5 / deltaY)) do
            x = player.x + deltaX * t
            y = player.y + deltaY * t
            if x < 0 or x > width or y < 0 or y > height then
                break
            end
            for i,ground in next, grounds do
                if ground.T == 9 or ground.o and ground.o == "515151" or ground.o == "5a5a5a" then
-- if player.x >= ground.X-ground.L/2 and player.x <= ground.X+ground.L/2 and player.y+5 >= ground.Y and player.y+5 <= ground.Y+ground.H then
                    if player.x > ground.X - ground.L/2 and player.x < ground.X + ground.L/2 and player.y > ground.Y - ground.H/2 and player.y < ground.Y + ground.H/2 then
                        stopSpawn = true
                        break
                    end
                end
                if x > ground.X - ground.L/2 and x < ground.X + ground.L/2 and y > ground.Y - ground.H/2 and y < ground.Y + ground.H/2 and ground.T ~= (8 or 9) then 
                    brk = true
                end
            end
            if stopSpawn then
                return
            end
            if brk then
                brk = false
                if not prtl then
                    tfm.exec.addShamanObject(26, player.x + deltaX * (t - 15), player.y + deltaY * (t - 15))
                    ui.addTextArea(1,"<font size='60' color='#FFB900'> •</font>", nil, 730,340,60,60,0,0,0,true)
                    ui.removeTextArea(2,playerNamer)
                    prtl = true
                else
                    tfm.exec.addShamanObject(27, player.x + deltaX * (t - 15), player.y + deltaY * (t - 15))
                    ui.addTextArea(2,"<font size='60' color='#0010FF'> •</font>", nil, 730,340,60,60,0,0,0,true)
                    ui.removeTextArea(1,playerNamer)
                    prtl = false
                end
                break
            end
            if not prtl then
                tfm.exec.displayParticle(9, x , y, 0, 0, 0, 0)
            else
                tfm.exec.displayParticle(2, x , y, 0, 0, 0, 0)
            end
        end
 
        tm = os.time()
    end
end
 
 
eventPlayerWon = eventPlayerDied
ui.addTextArea(2,"<font size='60' color='#0010FF'> •</font>", nil, 730,340,60,60,0,0,0,true)
 
 
function eventNewPlayer(name)
    if not Bonus[name] then
        Bonus[name] = {
            lastId = 0,
            list = {},
        }
    end


    ui.setMapName("<font color='#FF8F00'>• Пор<font color='#0076FF'>тал •</font> \n" )
    system.bindKeyboard(name,46,true,true) -- This allows all players to press the Delete button.
    system.bindKeyboard(name,81,true,true) -- This allows all players to press the Q button.
    ui.addTextArea(10,"<a href='event:click'> Панель админа", adm, 350,380,100,20,0,0x212F36,0.8,true)
    ui.addTextArea(11,"<a href='event:help'> ?",name, 5,25,18,18,0,0x333333,0.6,true)
    system.bindKeyboard(adm,78,true,true) -- This allows only admin to press the N button.
    system.bindMouse(name, true)
    tfm.exec.respawnPlayer(name)


    loadMapBonus(name, xml)
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)
 
 
eventTextAreaCallback = function(id, playerName, name, b)
    if name == "help" then
        ui.addTextArea(100,"",playerName, 190,60,440,280,0,0x212F36,0.5,true)
        ui.addTextArea(101,"<font size='30'>Правила:</font>",playerName, 200,60,800,400,0,0,0,true)
        ui.addTextArea(102,"<font color='#FF0000'>• Красная</font> - Объекты могут пройти через неё, а мыши нет.",playerName, 200,110,600,300,0,0,0,true)
        ui.addTextArea(103,"<font color='#0000FF'>• Синяя</font> - Мыши могут пройти через неё, а объекты нет.",playerName, 200,130,600,300,0,0,0,true)
        ui.addTextArea(104,"<font color='#00FF00'>• Зелёная</font> - Можно пройти только без сыра.",playerName, 200,150,600,300,0,0,0,true)
        ui.addTextArea(105,"<font color='#FFFF00'>• Жёлтая</font> - Можно пройти только с сыром.",playerName, 200,170,600,300,0,0,0,true)
        ui.addTextArea(106,"<font color='#FF8900'>• Оранжевая</font> - Можно пройти, если мышка взяла весь сыр на карте.",playerName, 200,190,600,300,0,0,0,true)
        ui.addTextArea(107,"<font color='#00FFFF'>• Голубая</font> - Если пройти через неё, то стираются порталы.",playerName, 200,210,600,300,0,0,0,true)
        ui.addTextArea(108,"<font color='#6F5733'>• Коричневая</font> - Нельзя пройти, если у тебя 2 сыра или больше.",playerName, 200,230,600,300,0,0,0,true)
        ui.addTextArea(110,"Delete",playerName, 210,270,42,20,0,0xE1E1E1,0.5,true)
        ui.addTextArea(111," Q",playerName, 210,310,20,20,0,0xE1E1E1,0.5,true)
        ui.addTextArea(116," N",playerName, 400,310,20,20,0,0xE1E1E1,0.5,true)
        ui.addTextArea(117,"- Убить всех (Только админу)",playerName, 430,310,200,20,0,0,0,true)
        ui.addTextArea(112,"- Убить себя",playerName, 260,270,200,20,0,0,0,true)
        ui.addTextArea(113,"- Стереть порталы",playerName, 240,310,200,20,0,0,0,true)
        ui.addTextArea(109,"<a href='event:close1'> X", playerName, 610,60,20,20,0,0,0,true)
 
    elseif name == "close1" then
        for i=100,117 do ui.removeTextArea(1*i,playerName) end
 
    elseif name == "click" then
        ui.addTextArea(-1," ", playerName, 185,70,470,340,0,0xFFFFFF,0.5,true)
        ui.addTextArea(-2,"Список карт:", playerName, 200,80,400,200,0,0,0,true)
        ui.addTextArea(-3,"Первая локация:", playerName, 200,100,400,200,0,0,0,true)
        ui.addTextArea(-4,"Вторая локация:", playerName, 200,160,400,200,0,0,0,true)
        ui.addTextArea(-5,"Третья локация:", playerName, 200,220,400,200,0,0,0,true)
        ui.addTextArea(-6,"Локация ''Космос'':", playerName, 200,280,400,200,0,0,0,true)
        ui.addTextArea(-7,"Сложность:", playerName, 550,100,400,200,0,0,0,true)
        ui.addTextArea(-8,"Очень легкий", playerName, 520,120,400,200,0,0,0,true)
        ui.addTextArea(-9,"Легкий", playerName, 520,140,400,200,0,0,0,true)
        ui.addTextArea(-10,"Нормальный", playerName, 520,160,400,200,0,0,0,true)
        ui.addTextArea(-11,"Сложный", playerName, 520,180,400,200,0,0,0,true)
        ui.addTextArea(-12,"Очень Сложный", playerName, 520,200,400,200,0,0,0,true)
        ui.addTextArea(-13,"<font color='#00FFD5'>•</font>", playerName, 630,120,400,200,0,0,0,true)
        ui.addTextArea(-14,"<font color='#38FF00'>•</font>", playerName, 630,140,400,200,0,0,0,true)
        ui.addTextArea(-15,"<font color='#FFA100'>•</font>", playerName, 630,160,400,200,0,0,0,true)
        ui.addTextArea(-16,"<font color='#FF0500'>•</font>", playerName, 630,180,400,200,0,0,0,true)
        ui.addTextArea(-17,"<font color='#F700FF'>•</font>", playerName, 630,200,400,200,0,0,0,true)
        ui.addTextArea(-18,"<a href='event:mapStartMenu'> 0", playerName, 620,230,18,18,0,0xDADADA,0.5,true)
 
        local id = -26
        local mapId = 1
 
        local stages = {
            [1] = 10,
            [2] = 7,
            [3] = 7,
            [4] = 6
        }
 
        local colors = {
            [1] = {'00FFD5', '00FFD5', '38FF00', '38FF00', '38FF00', 'FFA100', 'FFA100', 'FFA100', 'FF0500', 'FF0500'},
            [2] = {'38FF00', 'FFA100', 'FFA100', 'FF0500', 'FFA100', 'FFA100', 'FF0500'},
            [3] = {'FFA100', 'FFA100', 'FF0500', 'FF0500', 'FFA100', 'FF0500', 'F700FF'},
            [4] = {'FFA100', 'FFA100', 'FF0500', 'FF0500', 'FF0500', 'F700FF'}  	
        }
 
        for y = 1, 4 do
            local bgColor = y == 4 and 0x9100FF or 0x434343

 
            for i = 1, stages[y] do
                ui.addTextArea(id,"<p align='center'><a href='event:map"..mapId.."'><font color='#"..colors[y][i].."'>"..i.."</font></p>", playerName, 170+i*30,70+y*60,18,18,0,bgColor,0.5,true)
                id = id - 1
                mapId = mapId + 1
            end
        end
 
        ui.addTextArea(-19,"<a href='event:close'> Х", playerName, 630,80,18,18,0,0,0,true)
        ui.addTextArea(-20,"<a href='event:killall'> Убить всеx", playerName, 520,230,80,18,0,0xFF0000,0.5,true)
        ui.addTextArea(-21,"<a href='event:crash'> Краш", playerName, 520,260,45,18,0,0xFF0000,0.5,true)

    elseif name == "killall" then
        for playerName in pairs(tfm.get.room.playerList) do
            tfm.exec.killPlayer(playerName)
        end

 
    elseif name == "crash" then
        ui.removeTextArea(-21, playerName)
        ui.addTextArea(-22,"Подтвердить?", playerName, 540,260,100,18,0,0,0,true)
        ui.addTextArea(-23,"<a href='event:yes'> Да", playerName, 520,290,28,18,0,0xFF0000,0.5,true)
        ui.addTextArea(-24,"<a href='event:no'> Нет", playerName, 610,290,33,18,0,0x20FF00,0.5,true)
 
    elseif name == "yes" then
        tfm.exec.newGame("@7768958")
        ui.addTextArea(-21,"<a href='event:crash'> Краш", playerName, 520,280,45,18,0,0xFF0000,0.5,true)
        for i=22,24 do ui.removeTextArea(-1*i,playerName) end
 
    elseif name == "no" then
        ui.addTextArea(-21,"<a href='event:crash'> Краш", playerName, 520,260,45,18,0,0xFF0000,0.5,true)
        for i=22,24 do ui.removeTextArea(-1*i,playerName) end
 
    elseif name == "mapStartMenu" then
        tfm.exec.newGame("@7719367")
 
    elseif name:match("map%d+") then
        local key = tonumber(name:match("%d+"))
        tfm.exec.newGame(levels[key])
 
    elseif name == "close" then
        for i=1,65 do ui.removeTextArea(-1*i,playerName) end
    end
 
    ui.setMapName("<font color='#FF8F00'>• Пор<font color='#0076FF'>тал •</font> \n" )
end
 
function eventKeyboard(playerName,keyCode,down,xPlayerPosition,yPlayerPosition)
    if (keyCode == 46) then
        tfm.exec.killPlayer(playerName)
 
    elseif (keyCode == 78) then
        for playerName in pairs(tfm.get.room.playerList) do
            tfm.exec.killPlayer(playerName) 
            tfm.exec.disableAutoNewGame(true)
        end    

    elseif (keyCode == 81) then
        tfm.exec.addShamanObject(26,0,0)
        tfm.exec.addShamanObject(27,0,0)
    end
end

function eventChatCommand(name, message)
    if name == adm then
        if message:sub(0,4) == "kill" then
            if message:sub(6) ~= "" then
                tfm.exec.killPlayer(message:sub(6))
            end
        end
        if message:sub(0,4) == "stop" then
            system.exit()
        end
    end
end

system.disableChatCommandDisplay("kill",true)
system.disableChatCommandDisplay("stop",true)