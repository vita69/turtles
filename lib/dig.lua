dofile("./turn.lua")
-- 指定方向のの障害物がなくなるまで掘る(又は攻撃する)
-- direction=forward, back, up, down, left, right
function dig(direction)
    local direction = direction or "forward"
    print("dig "..direction)

    if direction == "forward" then
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
    elseif direction == "back" then
        turn("right", 2)
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
        turn("left", 2)
    elseif direction == "up" then
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
    elseif direction == "down" then
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
    elseif direction == "left" then
        turn("left")
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
        turn("right")
    elseif direction == "right" then
        turn("right")
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
        turn("left")
    end
    return true
end
