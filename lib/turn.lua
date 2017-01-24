

function turn(side, n)
    local side = side or "right"
    local n = n or 1

    for i = 1, n do
        if side == "right" then
            turtle.turnRight()
        elseif side == "left" then
            turtle.turnLeft()
        end
    end
end


