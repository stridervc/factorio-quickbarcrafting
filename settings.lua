data:extend({
	{
		name = "quickbarcrafting-enabled",
		type = "bool-setting",
		setting_type = "runtime-per-user",
		default_value = true,
		order = "a"
	}
})

data:extend({
	{
		name = "quickbarcrafting-notify",
		type = "bool-setting",
		setting_type = "runtime-per-user",
		default_value = true,
		order = "b"
	}
})

data:extend({
	{
		name = "quickbarcrafting-minimum",
		type = "int-setting",
		setting_type = "runtime-per-user",
		default_value = 10,
		order = "c"
	}
})


data:extend({
	{
		name = "quickbarcrafting-craft-amount",
		type = "int-setting",
		setting_type = "runtime-per-user",
		default_value = 5,
		order = "d"
	}
})

data:extend({
	{
		name = "quickbarcrafting-craft-secondary",
		type = "bool-setting",
		setting_type = "runtime-per-user",
		default_value = false,
		order = "e"
	}
})

data:extend({
	{
		name = "quickbarcrafting-craft-all",
		type = "bool-setting",
		setting_type = "runtime-per-user",
		default_value = false,
		order = "f"
	}
})
