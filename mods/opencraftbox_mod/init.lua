-- Set 'clearinv' priv
minetest.register_privilege("clearinv", {
    description = "Permission to clear inventories using /ocb_clearinv",
    give_to_singleplayer = false,
})

-- Switch to day (only for admins)
minetest.register_chatcommand("ocb_day", {
    description = "Set time to day (only for admins)",
    privs = {server = true},
    func = function(name)
        minetest.set_timeofday(0.23)
        return true, "Time set to day."
    end,
})

-- Switch to the night (only for admins)
minetest.register_chatcommand("ocb_night", {
    description = "Set time to night (only for admins)",
    privs = {server = true},
    func = function(name)
        minetest.set_timeofday(1.0)
        return true, "Time set to night."
    end,
})

-- Clear the inventory of a player (need clearinv priv)
minetest.register_chatcommand("ocb_clearinv", {
    params = "[playername]",
    description = "Clear inventory of player (or yourself if no name) - requires 'clearinv' privilege",
    privs = {clearinv = true},
    func = function(name, param)
        local target_name = param ~= "" and param or name
        local player = minetest.get_player_by_name(target_name)
        if not player then
            return false, "Player '" .. target_name .. "' not found."
        end
        local inv = player:get_inventory()
        if not inv then
            return false, "Could not access inventory of " .. target_name
        end
        inv:set_list("main", {})
        inv:set_list("craft", {})
        inv:set_list("craftpreview", {})
        return true, "Inventory cleared for player " .. target_name
    end,
})

-- Command /ocb_heal : heals a player (yourself or another one)
minetest.register_chatcommand("ocb_heal", {
    description = "Heal the specified player, or yourself if left empty",
    privs = {server = true}, -- restricted to admins
    params = "[playername]",
    func = function(name, param)
        local target_name = param ~= "" and param or name
        local target = minetest.get_player_by_name(target_name)

        if not target then
            return false, "Player '" .. target_name .. "' not found."
        end

        local max_hp = target:get_properties().hp_max or 20
        target:set_hp(max_hp)

        if target_name == name then
            return true, "You have been fully healed."
        else
            minetest.chat_send_player(target_name, "You have been healed by " .. name .. ".")
            return true, "You healed " .. target_name .. "."
        end
    end,
})
