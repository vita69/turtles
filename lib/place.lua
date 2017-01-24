
dofile("./turn.lua")

function place(direction)
    local direction = direction or "forward"
    local bool = false
    if direction == "forward" then
        bool = turtle.place()
    elseif direction == "back" then
        turn("right", 2)
        bool = turtle.place()
        turn("left", 2)
    elseif direction == "up" then
        bool = turtle.placeUp()
    elseif direction == "down" then
        bool = turtle.placeDown()
    elseif direction == "left" or direction == "right" then
        turn(direction)
        bool = turtle.place()
    end
    return bool
end