system.disableChatCommandDisplay()

local perms = {
    admin = {
        ["Aaa_bbb_ccc_ddd#2783"] = true
    },

    mod = {
        ["Zigwin#0000"] = true
    },

    default = {}
}


local commands = {
    ["repeat"] = {
        execute = function(say)
            if not say then print('Nothing to repeat') return end
            print(say)
        end,

        permissions = 'admin'
    }
}


table.find = function(t, o)
    if index then
        for k, v in next, t do
            if k == o or v == o then
                return true
            end
        end
    end
end


string.split = function(str, delimiter)
    local delimiter,a = delimiter or ',', {lay}
    for part in str:gmatch('[^'..delimiter..']+') do
        a[#a+1] = part
    end
    return a
end


eventNewPlayer = function(name)
    if not table.find(perms[default], name) then
        perms[default][name] = true
    end
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)


eventChatCommand = function(name, msg)
    local args = string.split(msg, ' ')
    local command = commands[args[1]] or "None"
    if command == "None" then return end
    
    if not table.find(perms[command.permissions], name) then return end
    print(1)
    command.execute(table.concat(args, ' ', 2))
end