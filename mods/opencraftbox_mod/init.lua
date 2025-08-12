-- Définition du privilège 'clearinv'
minetest.register_privilege("clearinv", {
    description = "Permission to clear inventories using /ocb_clearinv",
    give_to_singleplayer = false,
})

-- Commande /ocb_day : passe au jour (seulement pour les admins avec privilège 'server')
minetest.register_chatcommand("ocb_day", {
    description = "Set time to day (only for admins)",
    privs = {server = true},
    func = function(name)
        minetest.set_timeofday(0.23)
        return true, "Time set to day."
    end,
})

-- Commande /ocb_night : passe à la nuit (seulement pour les admins avec privilège 'server')
minetest.register_chatcommand("ocb_night", {
    description = "Set time to night (only for admins)",
    privs = {server = true},
    func = function(name)
        minetest.set_timeofday(0.75)
        return true, "Time set to night."
    end,
})

-- Commande /ocb_clearinv [player] : vide l'inventaire d'un joueur, nécessite privilège 'clearinv'
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
