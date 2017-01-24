-- startSlotNumからendSlotNumまでを指定方向(direction)にドロップする(格納または捨てる)
function dropAll(direction, startSlotNum, endSlotNum)
    local direction = direction or "forward"

    local startSlotNum = startSlotNum or 1;
    local endSlotNum = endSlotNum or 16;
    if startSlotNum <= 0 or startSlotNum > 16 then
        startSlotNum = 1
    end
    if endSlotNum <= 0 or endSlotNum > 16 then
        endSlotNum = 16
    else
        if startSlotNum > endSlotNum then
            endSlotNum = 16
        end
    end

    for i = startSlotNum, endSlotNum do
        turtle.select(i)
        local table=turtle.getItemDetail()
        if not (table==nill) then
            if direction == "forward" then
                turtle.drop()
            elseif direction == "up" then
                turtle.dropUp()
            elseif direction == "down" then
                turtle.dropDown()
            end
        end
    end
end
