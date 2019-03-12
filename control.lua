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
	if player.character == nil then return end
	if player.crafting_queue_size ~= 0 then return end

	-- process primary quick bar
	local bar = player.get_active_quick_bar_page(1)*10
	if craftQB(player, bar) then return end

	local secondary = config["quickbarcrafting-craft-secondary"].value or false
	local all = config["quickbarcrafting-craft-all"].value or false

	-- process secondary quickbar
	if secondary or all then
		local bar = player.get_active_quick_bar_page(2)*10
		if craftQB(player, bar) then return end
	end

	-- process all quick bars
	if all then
		for bar = 0,9 do 
			if craftQB(player, bar*10) then return end
		end
	end
end

-- Perform crafting in specified quick bar for player
-- returns true if something queued, false otherwise
function craftQB(player, bar)
	local config = settings.get_player_settings(player)
	local minimum = config["quickbarcrafting-minimum"].value
	local craftamount = config["quickbarcrafting-craft-amount"].value
	local notify = config["quickbarcrafting-notify"].value

	-- loop through each item in the quick bar
	for i = 1,10 do
		local item = player.get_quick_bar_slot(bar+i)
		if item ~= nil and player.get_item_count(item.name) < minimum then
			-- check if this item can be crafted
			local recipe = game.recipe_prototypes[item.name]
			if recipe ~= nil and recipe.allow_as_intermediate then
				if player.begin_crafting({count=craftamount, recipe=item.name, silent=true}) > 0 then
					if notify then player.print("Quick Bar Crafting " .. item.name) end
					return true	-- stop at first item to craft
				end
			end
		end
	end
	return false
end
