LOCATIONS = {
    { "@Sunken Shrine/Key of Love" },
    { "@Corrupted Future/Key of Courage" },
    { "@Underworld/Key of Chaos" },
    { "@Elemental Skylands/Key of Symbiosis" },
    { "@Searing Crags/Key of Strength" },
    { "@Autumn Hills/Key of Hope" },
    { "@Howling Grotto/Wingsuit" },
    { "@Searing Crags/Rope Dart" },
    { "@Sunken Shrine/Ninja Tabi" },
    { "@Autumn Hills/Climbing Claws" },
    { "@Ninja Village/Astral Seed" },
    { "@Searing Crags/Astral Tea Leaves" },
    { "@Ninja Village/Candle" },
    { "@Quillshroom Marsh/Seashell" },
    { "@Searing Crags/Power Thistle" },
    { "@Forlorn Temple/Demon King Crown" },
    { "@Catacombs/Ruxxtin's Amulet" },
    { "@Riviere Turquoise/Fairy Bottle" },
    { "@Sunken Shrine/Sun Crest" },
    { "@Sunken Shrine/Moon Crest" },
    { "@Catacombs/Necro" },
    { "@Searing Crags/Pyro" },
    { "@Bamboo Creek/Claustro" },
    { "@Cloud Ruins/Acro" },
    { "@Ninja Village/Ninja Village Seal - Tree House" },
    { "@Autumn Hills/Autumn Hills Seal - Trip Saws" },
    { "@Autumn Hills/Autumn Hills Seal - Double Swing Saws" },
    { "@Autumn Hills/Autumn Hills Seal - Spike Ball Swing" },
    { "@Autumn Hills/Autumn Hills Seal - Spike Ball Darts" },
    { "@Catacombs/Catacombs Seal - Triple Spike Crushers" },
    { "@Catacombs/Catacombs Seal - Crusher Gauntlet" },
    { "@Catacombs/Catacombs Seal - Dirty Pond" },
    { "@Bamboo Creek/Bamboo Creek Seal - Spike Crushers and Doors" },
    { "@Bamboo Creek/Bamboo Creek Seal - Spike Ball Pits" },
    { "@Bamboo Creek/Bamboo Creek Seal - Spike Crushers and Doors v2" },
    { "@Howling Grotto/Howling Grotto Seal - Windy Saws and Balls" },
    { "@Howling Grotto/Howling Grotto Seal - Crushing Pits" },
    { "@Howling Grotto/Howling Grotto Seal - Breezy Crushers" },
    { "@Quillshroom Marsh/Quillshroom Marsh Seal - Spikey Window" },
    { "@Quillshroom Marsh/Quillshroom Marsh Seal - Sand Trap" },
    { "@Quillshroom Marsh/Quillshroom Marsh Seal - Do the Spike Wave" },
    { "@Searing Crags/Searing Crags Seal - Triple Ball Spinner" },
    { "@Searing Crags/Searing Crags Seal - Raining Rocks" },
    { "@Searing Crags/Searing Crags Seal - Rhythm Rocks" },
    { "@Glacial Peak/Glacial Peak Seal - Ice Climbers" },
    { "@Glacial Peak/Glacial Peak Seal - Projectile Spike Pit" },
    { "@Glacial Peak/Glacial Peak Seal - Glacial Air Swag" },
    { "@Tower of Time/Tower of Time Seal - Time Waster Seal" },
    { "@Tower of Time/Tower of Time Seal - Lantern Climb" },
    { "@Tower of Time/Tower of Time Seal - Arcane Orbs" },
    { "@Cloud Ruins/Cloud Ruins Seal - Ghost Pit" },
    { "@Cloud Ruins/Cloud Ruins Seal - Toothbrush Alley" },
    { "@Cloud Ruins/Cloud Ruins Seal - Saw Pit" },
    { "@Cloud Ruins/Cloud Ruins Seal - Money Farm Room" },
    { "@Underworld/Underworld Seal - Sharp and Windy Climb" },
    { "@Underworld/Underworld Seal - Spike Wall" },
    { "@Underworld/Underworld Seal - Fireball Wave" },
    { "@Underworld/Underworld Seal - Rising Fanta" },
    { "@Forlorn Temple/Forlorn Temple Seal - Rocket Maze" },
    { "@Forlorn Temple/Forlorn Temple Seal - Rocket Sunset" },
    { "@Sunken Shrine/Sunken Shrine Seal - Ultra Lifeguard" },
    { "@Sunken Shrine/Sunken Shrine Seal - Waterfall Paradise" },
    { "@Sunken Shrine/Sunken Shrine Seal - Tabi Gauntlet" },
    { "@Riviere Turquoise/Riviere Turquoise Seal - Bounces and Balls" },
    { "@Riviere Turquoise/Riviere Turquoise Seal - Launch of Faith" },
    { "@Riviere Turquoise/Riviere Turquoise Seal - Flower Power" },
    { "@Elemental Skylands/Elemental Skylands Seal - Air" },
    { "@Elemental Skylands/Elemental Skylands Seal - Water" },
    { "@Elemental Skylands/Elemental Skylands Seal - Fire" }
}

LOCATIONS_MAPPING = {}
for n, item in ipairs(LOCATIONS) do
    LOCATIONS_MAPPING[0xADD000 + n - 1] = item
end
