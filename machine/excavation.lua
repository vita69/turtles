-- 暫定版(動作未チェック)

-- 掘削サイズ
width = 4
height = 4
depth = 100 -- 0を指定した場合は、燃料が尽きるまで直進する
fuelMinLevel = (((width - 1) * 2) + ((height - 1) * 2)) * depth + (depth * 2) -- 最低必要燃料数(深さ指定時) / 1ブロック分の周回移動分+depth往復量
isSetTorch = true; -- 松明を設置するか
torchSpan = 8
torchSlot = 5

function digBlock(n)
    -- 1ブロック進む
    while turtle.detect() do
        turtle.dig()
        turtle.attack()
    end
    turtle.forward()

    turtle.turnLeft()
    for i = 1, width - 1 do
        while turtle.detect() do
            turtle.dig()
            turtle.attack()
        end
        turtle.forward()
    end

    turtle.turnLeft()
    turtle.turnLeft()

    for i = 1, height - 1 do
        while turtle.detect() do
            turtle.dig()
            turtle.attack()
        end
        while turtle.detectUp() do
            turtle.digUp()
            turtle.attackUp()
        end
        turtle.Up()
    end

    for i = 1, width - 1 do
        while turtle.detect() do
            turtle.dig()
            turtle.attack()
        end

        if isSetTorch and turtle.getItemCount(torchSlot) > 0 and n % torchSpan == 0 then
            if i == 1 then
                turtle.forward()
                turtle.turnLeft()
                turtle.turnLeft()
                turtle.select(torchSlot)
                turtle.place()
                turtle.turnLeft()
                turtle.turnLeft()
            elseif i == width - 1 then
                turtle.select(torchSlot)
                turtle.place()
                turtle.forward()
            else
                turtle.forward()
            end
        else
            turtle.forward()
        end


    end

    turtle.turnLeft()
    turtle.turnLeft()

    for i = 1, height - 1 do
        while turtle.detect() do
            turtle.dig()
            turtle.attack()
        end
        while turtle.detectDown() do
            turtle.digDown()
            turtle.attackDown()
        end
        turtle.Down()
    end
    turtle.turnRight()
end


print("currentFuelLevel = "..turtle.getFuelLevel())
print("   needFuelLevel = "..fuelMinLevel)

if turtle.getFuelLevel() < fuelMinLevel then
    print("fuel is lower. please into fuel item to slot(16).")
end
turtle.select(16)
while turtle.getFuelLevel() < fuelMinLevel do

end
print("refuel is completed.")
print("")
print("-- star excavaton --")


if depth <= 0 then
    while true do
        -- 燃料があるまで掘り進む
        digBlock()
        sleep(0)
    end
else

    local isContinue = true

    -- 右下から開始を想定
    -- 燃料が余っていたら、右方向に移動し、再度同じ方向へ掘削を開始する(通路間隔は1マス開ける)
    -- 往復分の燃料がなかったら、停止
    while isContinue do
        for i = 0, depth do
            digBlock(i)
            i = i + 1
        end
        for i = 0, depth do
            turtle.back()
        end

        if turtle.getFuelLevel() < fuelMinLevel + width then -- widthは通路間移動の為に追加
            print("fuel is lower. stopped.")
            isContinue = false;
        else
            print("move to next route(left side).")
            turtle.turnLeft()
            for i = 1, 4 do
                while turtle.detect() do
                    turtle.dig()
                    turtle.attack()
                end
                turtle.forward()
            end
            turtle.turnRight()
        end
    end
end
print("")
print("-- star excavaton --")




