-- plugin/geovim.lua
-- Load the main plugin module
local geovim = require("geovim")

-- Subcommand: say hello
vim.api.nvim_create_user_command(
    "GeoVimHello",
    function()
		-- Synchronous API call
		local handle = io.popen('curl -s "https://api.github.com/repos/neovim/neovim"')
		local result = handle:read("*a")
		handle:close()

		print(result)  -- JSON response

    end,
    { desc = "Say hello from GeoVim" }
)

-- Subcommand: print a dummy coordinate
vim.api.nvim_create_user_command(
    "GeoVimDummyCoords",
    function()
        geovim.paste_coordinates(44.9778, -93.2650)
    end,
    { desc = "Insert a dummy coordinate at the cursor" }
)
