minetest.register_privilege("clearinv", {
    description = "Permission to clear inventories using /ocb_clearinv",
    give_to_singleplayer = false,
})

minetest.register_chatcommand("ocb_day", {
    description = "Set time to day (only for admins)",
    privs = {server = true},
    func = function(name)
        minetest.set_timeofday(0.23)
        return true, "Time set to day."
    end,
})

minetest.register_chatcommand("ocb_night", {
    description = "Set time to night (only for admins)",
    privs = {server = true},
    func = function(name)
        minetest.set_timeofday(0.75)
        return true, "Time set to night."
    end,
})

minetest.register_chatcommand("ocb_clearinv", {
    params = "[playername]",
    description = "Clear inventory of player (or yourself if no name)",
    privs = {clearinv = true},
    func = function(name, param)
        local target_name = param ~= "" and param or name
        local player = minetest.get_player_by_name(target_name)
        if not player then
            return false, "Player '" .. target_name .. "' not found."
        end
        local inv = player:get_inventory()
        if not inv th
