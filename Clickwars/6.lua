local images = {}


eventNewPlayer = function(name)
    system.bindMouse(name, true)
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)


eventMouse = function(n, x, y)
    local obj = tfm.exec.addShamanObject(1, x, y, 0, 0, 0, false)
    images[#images + 1] = tfm.exec.addImage('177460c3798.png', '#'..obj, -30, -35, nil)

    print("\nBox:\n[X] "..x.."\n[Y] "..y)
    print("\nImage:\n[X] "..(x-30).."\n[Y] "..y-35)
end