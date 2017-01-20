-- 指定方向に進む
-- direction: 方向(default: forward)
-- n: 進行回数(default: 1)
-- force: 進めるまで繰り返す(default: false)
function move(direction, n, force)
    local direction = direction or "forward"
    local n = n or 1
    local force = force or false

    local bool = false


    for i = 1, n do

        if direction == "forward" then
            if(force) then
                dig(direction)
            end
            bool = turtle.forward()
        elseif direction == "back" then
            if(force) then
                turtle.turnRight()
                turtle.turnRight()
                dig("forward")
                bool = turtle.forward()
                turtle.turnRight()
                turtle.turnRight()
            else
                bool = turtle.back()
            end
        elseif direction == "up" then
            if(force) then
                dig(direction)
            end
            bool = turtle.up()
        elseif direction == "down" then
            if(force) then
                dig(direction)
            end
            bool = turtle.down()
        elseif direction == "left" then
            turtle.turnLeft()
            if(force) then
                dig("forward")
            end
            bool = turtle.forward()
            bool = turtle.turnRight()
        elseif direction == "right" then
            turtle.turnRight()
            if(force) then
                dig("forward")
            end
            bool = turtle.forward()
            bool = turtle.turnLeft()
        else
            if(force) then
                dig(direction)
            end
            bool = turtle.forward()
        end
    end
    return bool
end