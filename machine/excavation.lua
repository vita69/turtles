-- 暫定版(動作未チェック)

dofile("./lib/dig.lua")
dofile("./lib/drop.lua")
dofile("./lib/move.lua")
dofile("./lib/place.lua")
dofile("./lib/select.lua")
dofile("./lib/turn.lua")

-- 掘削サイズ
width = 4
height = 4
depth = 100 -- 0を指定した場合は、燃料が尽きるまで直進する
fuelMinLevel = (((width - 1) * 2) + ((height - 1) * 2)) * depth + (depth * 2) -- 最低必要燃料数(深さ指定時) / 1ブロック分の周回移動分+depth往復量

function digBlock(n)
    move("forward", 1, true)
    turn("left")

    -- 下辺移動
    select(1, 16)
    place("down")
    for i = 1, width - 1 do
        move("forward", 1, true)
        select(1, 16)
        place("down")
    end

    -- 左辺移動(上昇)
    select(1, 16)
    place()
    for i = 1, height - 1 do
        move("up", 1, true)
        select(1, 16)
        place()
    end

    turn("right", 2)

    -- 上辺移動
    select(1, 16)
    place("up")
    for i = 1, width - 1 do
        move("forward", 1, true)
        select(1, 16)
        place("up")
    end

    -- 右辺移動(下降)
    select(1, 16)
    place()
    for i = 1, height - 1 do
        move("down", 1, true)
        select(1, 16)
        place()

        if i < height - 1 then
            -- 中身を削る
            turn("right", 2)
            move("forward", width - 2)
            turn("left", 2)
            move("forward", width - 2)
        end
    end

    turn("left")
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
print("-- start excavaton and repair wall --")


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
            for i = 1, width + 1 do
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
print("-- stop excavaton and repair wall --")




