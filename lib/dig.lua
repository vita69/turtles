-- 指定方向のの障害物がなくなるまで掘る(又は攻撃する)
function dig(direction)
    local direction = direction or "forward"
    print("dig "..direction)

    if direction == "forward" then
        while turtle.detect() do
            turtle.dig()
            turtle.attack() -- mob用
        end
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
    end
    return true
end
