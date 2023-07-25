function has(item, amount)
    local count = Tracker:ProviderCountForCode(item)
    if not amount then
        return count > 0
    else
        amount = tonumber(amount)
        return count >= amount
    end
end

function vertical()
    return has("wingsuit") or has("grapplou")
end

function open_music_box()
    return has("key_of_hope") and has("key_of_chaos") and has("key_of_courage")
            and has("key_of_love") and has("key_of_strength") and has("key_of_symbiosis")
end

function open_store_chest()
    local requiredSeals = Tracker:ProviderCountForCode("required_seals")
    return has("power_seal", requiredSeals)
end

function cost(location)
    local price = SHOP_PRICES[location]
    if not price then
        price = FIGURE_PRICES[location]
    end
    return price
end
function adjust_cost(location, price)
    if not price then
        price = FIGURE_PRICES[location]
        if not price then
            return ADJUSTED_PRICES[location]
        end
        price = price + adjust_cost("Demon's Bane") + adjust_cost("Focused Power Sense")
    elseif PREREQS[location] then
        if type(PREREQS[location]) == "string" then
            price = price + ADJUSTED_PRICES[PREREQS[location]]
        else
            for _, i in ipairs(PREREQS[location]) do
                price = price + ADJUSTED_PRICES[i]
            end
        end
    end
    return price
end

function can_afford(location)
    local price = ADJUSTED_PRICES[location]
    if string.sub(location, 1, 1) == "F" then
        return SHARDS >= math.min(price, MAX_PRICE) and has("money_wrench")
    end
    return SHARDS >= math.min(price, MAX_PRICE)
end 