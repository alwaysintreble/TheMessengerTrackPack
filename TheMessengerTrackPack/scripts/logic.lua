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
