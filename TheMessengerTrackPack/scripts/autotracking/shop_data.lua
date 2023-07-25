SHOP_DATA = {
    { "HP_UPGRADE_1", "Karuta Plates" },
    { "ENEMY_DROP_HP", "Serendipitous Bodies" },
    { "DAMAGE_REDUCTION", "Path of Resilience" },
    { "HP_UPGRADE_2", "Kusari Jacket" },
    { "SHURIKEN", "Energy Shuriken" },
    { "ENEMY_DROP_MANA", "Serendipitous Minds" },
    { "SHURIKEN_UPGRADE_1", "Prepared Mind" },
    { "CHECKPOINT_FULL", "Meditation" },
    { "POTION_FULL_HEAL_AND_HP", "Rejuvenative Spirit" },
    { "SHURIKEN_UPGRADE_2", "Centered Mind" },
    { "ATTACK_PROJECTILE", "Strike of the Ninja" },
    { "AIR_RECOVER", "Second Wind" },
    { "SWIM_DASH", "Currents Master" },
    { "GLIDE_ATTACK", "Aerobatics Warrior" },
    { "CHARGED_ATTACK", "Demon's Bane" },
    { "QUARBLE_DISCOUNT_50", "Devil's Due" },
    { "TIME_WARP", "Time Sense" },
    { "POWER_SEAL", "Power Sense" },
    { "POWER_SEAL_WORLD_MAP", "Focused Power Sense" },
}

FIGURINE_DATA = {
    { "GREEN_KAPPA", "Green Kappa Figurine" },
    { "BLUE_KAPPA", "Blue Kappa Figurine" },
    { "OUNTARDE", "Ountarde Figurine" },
    { "RED_KAPPA", "Red Kappa Figurine" },
    { "DEMON_KING", "Demon King Figurine" },
    { "QUILLSHROOM", "Quillshroom Figurine" },
    { "JUMPING_QUILLSHROOM", "Jumping Quillshroom Figurine" },
    { "SCURUBU", "Scurubu Figurine" },
    { "JUMPING_SCURUBU", "Jumping Scurubu Figurine" },
    { "WALLAXER", "Wallaxer Figurine" },
    { "BARMATHAZEL", "Barmath'azel Figurine" },
    { "QUEEN_OF_QUILLS", "Queen of Quills Figurine" },
    { "DEMON_HIVE", "Demon Hive Figurine" },
}

PREREQS = {
    ["Serendipitous Bodies"] = "Karuta Plates",
    ["Path of Resilience"] = "Serendipitous Bodies",
    ["Kusari Jacket"] = "Path of Resilience",
    ["Serendipitous Minds"] = "Energy Shuriken",
    ["Prepared Mind"] = "Serendipitous Minds",
    ["Meditation"] = { "Prepared Mind", "Kusari Jacket" },
    ["Rejuvenative Spirit"] = "Meditation",
    ["Centered Mind"] = "Meditation",
    ["Second Wind"] = "Strike of the Ninja",
    ["Currents Master"] = "Second Wind",
    ["Aerobatics Warrior"] = "Currents Master",
    ["Demon's Bane"] = { "Rejuvenative Spirit", "Aerobatics Warrior" },
    ["Power Sense"] = "Time Sense",
    ["Focused Power Sense"] = "Power Sense",
}

MAX_PRICES = {
    { "Karuta Plates", 200 },
    { "Serendipitous Bodies", 300 },
    { "Path of Resilience", 500 },
    { "Kusari Jacket", 500 },
    { "Energy Shuriken", 200 },
    { "Serendipitous Minds", 300 },
    { "Prepared Mind", 600 },
    { "Meditation", 600 },
    { "Rejuvenative Spirit", 800 },
    { "Centered Mind", 800 },
    { "Strike of the Ninja", 200 },
    { "Second Wind", 350 },
    { "Currents Master", 600 },
    { "Aerobatics Warrior", 800 },
    { "Demon's Bane", 1000 },
    { "Devil's Due", 200 },
    { "Time Sense", 300 },
    { "Power Sense", 800 },
    { "Focused Power Sense", 600 }
}

MAX_FIGURINE_PRICES = {
    ["Green Kappa Figurine"] = 500,
    ["Blue Kappa Figurine"] = 500,
    ["Ountarde Figurine"] = 500,
    ["Red Kappa Figurine"] = 500,
    ["Demon King Figurine"] = 2000,
    ["Quillshroom Figurine"] = 500,
    ["Jumping Quillshroom Figurine"] = 500,
    ["Scurubu Figurine"] = 500,
    ["Jumping Scurubu Figurine"] = 500,
    ["Wallaxer Figurine"] = 500,
    ["Barmath'azel Figurine"] = 2000,
    ["Queen of Quills Figurine"] = 1000,
    ["Demon Hive Figurine"] = 500
}

function adjust_display_costs()
    local obj
    for k, v in pairs(SHOP_PRICES) do
        obj = Tracker:FindObjectForCode(string.format("@The Shop/%s", k))
        if not obj then
            obj = Tracker:FindObjectForCode(string.format("@Figurines/%s", k))
        end
        if obj and not obj == v then
            obj.ChestCount = obj.ChestCount - (obj.ChestCount - v)
        end
    end
    for k, v in pairs(FIGURE_PRICES) do
        obj = Tracker:FindObjectForCode(string.format("@Figurines/%s", k))
        if obj and not obj == v then
            obj.ChestCount = obj.ChestCount - (obj.ChestCount - v)
        end
    end
end