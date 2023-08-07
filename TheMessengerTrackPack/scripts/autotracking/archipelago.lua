ScriptHost:LoadScript("scripts/autotracking/item_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/location_mapping.lua")
ScriptHost:LoadScript("scripts/autotracking/map_switching.lua")
ScriptHost:LoadScript("scripts/autotracking/shop_data.lua")

CUR_INDEX = -1
SLOT_DATA = nil
MAX_PRICE = nil
SHARDS = nil
LOCAL_ITEMS = {}
GLOBAL_ITEMS = {}
SHOP_PRICES = {}
FIGURE_PRICES = {}
ADJUSTED_PRICES = {}

function onClear(slot_data)
    if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
        print(string.format("called onClear, slot_data:\n%s", dump_table(slot_data)))
    end
    SLOT_DATA = slot_data
    CUR_INDEX = -1
    SHARDS = 0
    -- reset locations
    for _, v in pairs(LOCATIONS_MAPPING) do
        if v[1] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing location %s", v[1]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[1]:sub(1, 1) == "@" then
                    obj.AvailableChestCount = obj.ChestCount
                else
                    obj.Active = false
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    -- reset items
    for _, v in pairs(ITEM_MAPPING) do
        if v[1] and v[2] then
            if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: clearing item %s of type %s", v[1], v[2]))
            end
            local obj = Tracker:FindObjectForCode(v[1])
            if obj then
                if v[2] == "toggle" then
                    obj.Active = false
                elseif v[2] == "progressive" then
                    obj.CurrentStage = 0
                    obj.Active = false
                elseif v[2] == "consumable" then
                    obj.AcquiredCount = 0
                elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                    print(string.format("onClear: unknown item type %s for code %s", v[2], v[1]))
                end
            elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
                print(string.format("onClear: could not find object for code %s", v[1]))
            end
        end
    end
    LOCAL_ITEMS = {}
    GLOBAL_ITEMS = {}
    -- update slot based info
    if ENABLE_DEBUG_LOG then
        print("Checking slot data.")
        print(string.format("goal: %s", slot_data["goal"]))
        print(string.format("required seals: %s", slot_data["required_seals"]))
    end

    if slot_data["goal"] then
        if slot_data["goal"] == "open_music_box" then
            Tracker:FindObjectForCode("goal").CurrentStage = 0
        elseif slot_data["goal"] == "power_seal_hunt" then
            Tracker:FindObjectForCode("goal").CurrentStage = 1
            Tracker:FindObjectForCode("required_seals").AcquiredCount = tonumber(slot_data["required_seals"])
        end
    end

    if slot_data["settings"] then
        if slot_data["settings"]["Difficulty"] == "Basic" then
            Tracker:FindObjectForCode("shuffled_power_seals").CurrentStage = 0
        end
        if slot_data["settings"]["Mega Shards"] then
            Tracker:FindObjectForCode("shuffled_shards").CurrentStage = slot_data["settings"]["Mega Shards"]
        end
    elseif slot_data["mega_shards"] then
        Tracker:FindObjectForCode("shuffled_shards").CurrentStage = slot_data["mega_shards"]
    end

    if slot_data["logic"] then
        if slot_data["logic"] == "normal" then
            Tracker:FindObjectForCode("logic").CurrentStage = 0
        elseif slot_data["logic"] == "hard" then
            Tracker:FindObjectForCode("logic").CurrentStage = 1
        elseif slot_data["logic"] == "oob" then
            Tracker:FindObjectForCode("logic").CurrentStage = 2
        end
    end

    if slot_data["shop"] then
        for k, v in ipairs(SHOP_DATA) do
            SHOP_PRICES[k] = {v[2], slot_data["shop"][v[1]]}
        end
        for _, v in ipairs(FIGURINE_DATA) do
            FIGURE_PRICES[v[2]] = slot_data["figures"][v[1]]
        end
        for _, v in ipairs(SHOP_PRICES) do
            ADJUSTED_PRICES[v[1]] = adjust_cost(v[1], v[2])
        end
        for k, _ in pairs(FIGURE_PRICES) do
            ADJUSTED_PRICES[k] = adjust_cost(k)
        end
    end
    
    if slot_data["max_price"] then
        MAX_PRICE = slot_data["max_price"]
    end
    
    adjust_display_costs()
    Tracker:FindObjectForCode("auto_tab").CurrentStage = 1
    Archipelago:SetNotify({"Slot:" .. Archipelago.PlayerNumber .. ":CurrentRegion"})

    Tracker:FindObjectForCode("shuffled_power_seals").CurrentStage = shuffled_seals()
end

function shuffled_seals()
    -- First Power Seal in the datapackage
    local loc = 11391000
    for _, i in ipairs(Archipelago.CheckedLocations) do
        if loc == i then
            return 1
        end
    end
    for _, i in ipairs(Archipelago.MissingLocations) do
        if loc == i then
            return 1
        end
    end
    return 0
end

function onItem(index, item_id, item_name, player_number)
    if index <= CUR_INDEX then
        return
    end
    local is_local = player_number == Archipelago.PlayerNumber
    CUR_INDEX = index;
    local v = ITEM_MAPPING[item_id]
    if not v then
        if AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: could not find item mapping for id %s", item_id))
        end
        return
    end
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    if string.sub(item_name, 1, 10) == "Time Shard" then
        local count = tonumber(string.sub(item_name, 13, -2))
        if not count then
            count = 1
        elseif count >= 100 then
            SHARDS = SHARDS + count
        end
        obj = Tracker:FindObjectForCode("time_shard")
        obj.AcquiredCount = obj.AcquiredCount + count
    elseif obj then
        if v[2] == "toggle" then
            obj.Active = true
        elseif v[2] == "progressive" then
            if obj.Active then
                obj.CurrentStage = obj.CurrentStage + 1
            else
                obj.Active = true
            end
        elseif v[2] == "consumable" then
            obj.AcquiredCount = obj.AcquiredCount + obj.Increment
        elseif AUTOTRACKER_ENABLE_DEBUG_LOGGING_AP then
            print(string.format("onItem: unknown item type %s for code %s", v[2], v[1]))
        end
    end

    if is_local then
        if LOCAL_ITEMS[v[1]] then
            LOCAL_ITEMS[v[1]] = LOCAL_ITEMS[v[1]] + 1
        else
            LOCAL_ITEMS[v[1]] = 1
        end
    else
        if GLOBAL_ITEMS[v[1]] then
            GLOBAL_ITEMS[v[1]] = GLOBAL_ITEMS[v[1]] + 1
        else
            GLOBAL_ITEMS[v[1]] = 1
        end
    end
end

function onLocation(location_id, location_name)
    local v = LOCATIONS_MAPPING[location_id]
    local d = LOCATIONS_MAPPING[location_id]
    if not v[1] then
        return
    end
    local obj = Tracker:FindObjectForCode(v[1])
    local detObj = Tracker:FindObjectForCode(d[1])
    if obj then
        if v[1]:sub(1, 1) == "@" then
            obj.AvailableChestCount = obj.AvailableChestCount - 1
            detObj.AvailableChestCount = detObj.AvailableChestCount - 1
        else
            obj.Active = true
            detObj.Active = true
        end
    end
end

function onChangedRegion(key, current_region, old_region)
    if Tracker:FindObjectForCode("auto_tab").CurrentStage == 1 then
        if TABS_MAPPING[current_region] then
            CURRENT_ROOM = TABS_MAPPING[current_region]
        else
            CURRENT_ROOM = CURRENT_ROOM_ADDRESS
        end
        Tracker:UiHint("ActivateTab", CURRENT_ROOM)
    end
end

function setup_default_shops()
    SHOP_PRICES = MAX_PRICES
    FIGURE_PRICES = MAX_FIGURINE_PRICES

    for _, v in ipairs(SHOP_PRICES) do
    ADJUSTED_PRICES[v[1]] = adjust_cost(v[1], v[2])
    end
    for k, _ in pairs(FIGURE_PRICES) do
    ADJUSTED_PRICES[k] = adjust_cost(k)
    end
end

setup_default_shops()
Archipelago:AddClearHandler("clear handler", onClear)
Archipelago:AddItemHandler("item handler", onItem)
Archipelago:AddLocationHandler("location handler", onLocation)
Archipelago:AddSetReplyHandler("CurrentRegion", onChangedRegion)
