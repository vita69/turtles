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
fuelMinLevel = (((width - 1) * 2) + ((height - 1) * 2)) * (depth / 8) + (depth * 2) -- 最低必要燃料数(深さ指定時) / 1ブロック分の周回移動分+depth往復量
isSetTorch = true; -- 松明を設置するか
torchSpan = 8
torchSlot = 1

function digBlock(n)
    move("forward", 1, true)

    -- torchを置くかどうか
    if not n % torchSpan == 0 then
        -- 設置場所でない場合は、次の場所へ
        return
    end

    turn("left")

    -- 下辺移動
    move("forward", width - 1)

    -- 左辺移動(上昇)
    move("up", height - 1, true)

    turn("right", 2)

    -- 上辺移動
    move("forward")
    turn("right", 2)
    select(1, 1)
    place()
    turn("left", 2)
    move("forward", width - 2, true)

    -- 右辺移動(下降)
    move("down", 1, true)
    select(1, 16)
    placeUp()
    move("down", height - 2, true)
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
print("-- start torch placer --")


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
print("-- stop torch placer --")




