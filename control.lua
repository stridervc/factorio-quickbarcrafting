--[[

* Research to enable this?
* Button to toggle it on or off
* Config the minimum of each item there should be
* Config the number to craft

--]]

script.on_event({defines.events.on_tick},
   function (e)
		if e.tick % 60 == 0 then		-- only check every 1 second
			local p = game.players[1]

			local inventory = p.get_main_inventory()

			-- get the primary quick bar 
			local qbp = p.get_active_quick_bar_page(1)*10

			-- loop through each item in the primary quick bar
			for i = 1,10 do
				local item = p.get_quick_bar_slot(qbp+i)
				if item ~= nil then
					-- if fewer than 5 of this item, craft 5 if possible
					if p.get_item_count(item.name) < 5 and item.subgroup.name ~= "raw-resource" and p.crafting_queue_size == 0 then
						if p.begin_crafting({count=5, recipe=item.name, silent=true}) > 0 then
							p.print("Quick Bar Crafting " .. item.name)
							return	-- stop at first item to craft
						end
					end
				end
			end
		end
	end
)
