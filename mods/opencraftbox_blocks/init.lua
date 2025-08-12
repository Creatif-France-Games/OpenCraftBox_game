local S = minetest.get_translator(minetest.get_current_modname())minetest.register_node("opencraftbox_blocks:checkerboard", {
    description = S("Checkerboard"),
    tiles = {"damier.png"},
    is_ground_content = false,
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
    type = "shapeless",
    output = "opencraftbox:checkerboard",
    recipe = {"default:clay", "dye:black"},
})
