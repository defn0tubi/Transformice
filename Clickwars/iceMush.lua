local admin
do local _,name = pcall(nil)
	admin = string.match(name, "(.-)%.")
end

local platforms = 0
local firstPoint = nil
local secondPoint = nil

system.bindMouse(admin, true)
tfm.exec.bindKeyboard(admin, string.byte('Z'), true, true)


function createIce(x1, y1, x2, y2)
    local dx, dy = x2-x1, y2-y1
    local a = math.atan2(dy, dx)

    platforms = platforms + 1

    tfm.exec.addPhysicObject(platforms,(x2+x1)/2,(y2+y1)/2,{
        type=1,
        restitution=0,
        angle=a*180/math.pi,
        friction=0,
        width=x2 ~= x1 and math.abs(x2-x1) or math.abs(y2-y1),
        height=10,
        groundCollision=true,
    })
end


function eventMouse(p, x, y)
    if not firstPoint then
        firstPoint = {x, y}

        return
    end

    if firstPoint and not secondPoint then
        secondPoint = {x, y}
        local ice = createIce(firstPoint[1], firstPoint[2], secondPoint[1], secondPoint[2])
        firstPoint = nil
        secondPoint = nil

        return
    end
end


function eventKeyboard(playerName, keyCode, down, xPlayerPosition, yPlayerPosition)

    if keyCode == string.byte('Z') and platforms > 0 then
        tfm.exec.removePhysicObject(platforms)
        platforms = platforms - 1
    end

end