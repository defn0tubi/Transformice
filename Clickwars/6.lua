local a = tfm.exec.addImage("17729f24684.png", "?1", 760, 17)
ui.addTextArea(1, "<a href='event:options'>\t\t\t\t</a>", nil, 760, 17, 40, 40, 0x000000, 0x000000, 0, true)


eventTextAreaCallback = function(textAreaId, playerName, eventName)
    if eventName == "options" then
        ui.addTextArea(1, "Never gonna give you up", nil, 400, 200, 150, 150, 0x324650, 0x212F36, 1, true)
    end
end