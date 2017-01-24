dofile("./dig.lua")
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
        if(force) then
            dig(direction)
        end
        if direction == "forward" then
            bool = turtle.forward()
        elseif direction == "back" then
            bool = turtle.back()
        elseif direction == "up" then
            bool = turtle.up()
        elseif direction == "down" then
            bool = turtle.down()
        elseif direction == "left" or direction == "right" then
            turn(direction)
            bool = turtle.forward() -- 方向は進んだ方向のまま
        end
    end
    return bool
end