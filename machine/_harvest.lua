
xSize = 8
ySize = 8

function harvest()
    turtle.up()
    turtle.forward()

    for x = 1, xSize do
        for y = 1, xSize do
            turtle.digDown()
            if not y == xSize then
                turtle.forward()
            else
                turtle.turnRight()
            end

        end

    end


end
