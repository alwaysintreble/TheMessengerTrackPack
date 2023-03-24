ITEMS = {
    { "key_of_hope", "toggle" },
    { "key_of_chaos", "toggle" },
    { "key_of_courage", "toggle" },
    { "key_of_love", "toggle" },
    { "key_of_strength", "toggle" },
    { "key_of_symbiosis", "toggle" },
    { "windmill", "toggle" },
    { "wingsuit", "toggle" },
    { "grapplou", "toggle" },
    { "lightfoot_tabi", "toggle" },
    { "candle", "toggle" },
    { "seashell", "toggle" },
    { "power_thistle", "toggle" },
    { "demon_king_crown", "toggle" },
    { "ruxxtin_amulet", "toggle" },
    { "fairy_bottle", "toggle" },
    { "sun_crest", "toggle" },
    { "moon_crest", "toggle" },
    { "necro", "toggle" },
    { "pyro", "toggle" },
    { "claustro", "toggle" },
    { "acro", "toggle" },
    { "power_seal", "consumable" },
    { "time_shard", "consumable" },
}

ITEM_MAPPING = {}
for n, item in ipairs(ITEMS) do
    ITEM_MAPPING[0xADD000 + n - 1] = item
end
