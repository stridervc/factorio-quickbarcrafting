script.on_event({defines.events.on_tick},
   function (e)
		if e.tick % 60 == 0 then		-- only check every 1 second
			for index, player in pairs(game.connected_players) do
				autoCraft(player)
			end
		end
	end
)

function autoCraft(player) 
	local config = settings.get_player_settings(player)

	if not config["quickbarcrafting-enabled"].value then return end
	if player.crafting_queue_size ~= 0 then return end

	local minimum = config["quickbarcrafting-minimum"].value
	local craftamount = config["quickbarcrafting-craft-amount"].value

	-- get the primary quick bar 
	local qbp = player.get_active_quick_bar_page(1)*10

	-- loop through each item in the primary quick bar
	for i = 1,10 do
		local item = player.get_quick_bar_slot(qbp+i)
		if item ~= nil and player.get_item_count(item.name) < minimum then
			-- check if this item can be crafted
			local recipe = game.recipe_prototypes[item.name]
			if recipe ~= nil and recipe.allow_as_intermediate then
				if player.begin_crafting({count=craftamount, recipe=item.name, silent=true}) > 0 then
					player.print("Quick Bar Crafting " .. item.name)
					return	-- stop at first item to craft
				end
			end
		end
	end
end
