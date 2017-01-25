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

    if direction == "left" or direction == "right" then
        turn(direction)
    end

    for i = 1, n do
        if(force) then
            dig(direction)
        end
        bool = false
        if direction == "forward" then
            while bool do
                bool = turtle.forward()
            end
        elseif direction == "back" then
            while bool do
                bool = turtle.back()
            end
        elseif direction == "up" then
            while bool do
                bool = turtle.up()
            end
        elseif direction == "down" then
            while bool do
                bool = turtle.down()
            end
        elseif direction == "left" or direction == "right" then
            while bool do
                bool = turtle.forward() -- 方向は進んだ方向のまま
            end
        end
    end
    return bool
end