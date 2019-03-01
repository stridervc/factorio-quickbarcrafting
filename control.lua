script.on_event({defines.events.on_tick},
   function (e)
		if e.tick % 60 == 0 then		-- only check every 1 second
			local p = game.players[1]
			local config = settings.get_player_settings(p)

			if not config["quickbarcrafting-enabled"].value then return end

			-- get the primary quick bar 
			local qbp = p.get_active_quick_bar_page(1)*10

			-- loop through each item in the primary quick bar
			for i = 1,10 do
				local item = p.get_quick_bar_slot(qbp+i)
				if item ~= nil then
					local minimum = config["quickbarcrafting-minimum"].value
					local craftamount = config["quickbarcrafting-craft-amount"].value

					if p.get_item_count(item.name) < minimum and item.subgroup.name ~= "raw-resource" and p.crafting_queue_size == 0 then
						-- check if this item can be crafted
						local recipe = game.recipe_prototypes[item.name]
						if recipe ~= nil and recipe.allow_as_intermediate then
							if p.begin_crafting({count=craftamount, recipe=item.name, silent=true}) > 0 then
								p.print("Quick Bar Crafting " .. item.name)
								return	-- stop at first item to craft
							end
						end
					end
				end
			end
		end
	end
)
