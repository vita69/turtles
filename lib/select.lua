
function select(slot, slotMax)
    local activeSlot = 0
    local bool = false

    for i = slot, slotMax do
        if turtle.getItemCount(slot) > 0 then
            activeSlot = i
            break
        end
    end

    if activeSlot > 0 then
        bool = turtle.select(activeSlot)
    else
        bool = false
    end
    return bool
end

