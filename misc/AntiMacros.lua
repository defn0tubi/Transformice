local keys = {
    W = string.byte('W'),
    UP  = 38,
    Z = string.byte('Z')
}
local cache = {}
local playerData = {}


function eventNewPlayer(n)
    if not playerData[n] then
        playerData[n] = {
            jumps = 0
        }
    end

    if not cache[n] then
        cache[n] = {
            fJumps = 0,
            lJumps = 0
        }
    end

    for _,v in next, keys do
        system.bindKeyboard(n, v, true, true)
    end
end
table.foreach(tfm.get.room.playerList, eventNewPlayer)

function macroCheck(n)
    local x

    x = cache[n].lJumps - cache[n].fJumps

    if x > 10 then
        return false
    else
        return true
    end
end


local cycle = nil
function eventLoop()

    if not cycle then
        cycle = os.time()
        for i,v in next, playerData do
            cache[i].fJumps = v.jumps
        end
        return
    end

    if cycle and cycle+1000 < os.time() then

        for i,v in next, playerData do
            local text
            cache[i].lJumps = v.jumps

            if not macroCheck(i) then
                text = "<CH>"..i.."</CH> has jumped <R>"..playerData[i].jumps.."</R> times in the <CS>last second </CS><ROSE>[SUSPICIOUS]</ROSE>"
            else
                text = "<CH>"..i.."</CH> has jumped <R>"..playerData[i].jumps.."</R> times in the <CS>last second </CS><PT>[NORMAL]</PT>"
            end
            print(text)
            playerData[i].jumps = 0
        end

        cycle = nil
    end

end


function eventKeyboard(n, k, down, x, y)

    if k == keys.W or k == keys.UP or k == keys.Z then
        playerData[n].jumps = playerData[n].jumps + 1
    end

end