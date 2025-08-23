-- plugin/geovim.lua
-- Load the main plugin module
local geovim = require("geovim")

-- Subcommand: say hello
vim.api.nvim_create_user_command(
    "GeoVimGetCoordinates",
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
    "GeoVimReverseGeoCode",
    function(opts)
        local lat = opts.fargs[1]
        local lon = opts.fargs[2]
        print(geovim.reverse_geocode(lon, lat))
    end,
    { 
        desc = "Insert a dummy coordinate at the cursor",
        nargs = "+"  -- This tells Vim to expect exactly 2 arguments
    }
)

vim.api.nvim_create_user_command(
    "GeovimGeocode",
    function(opts)
		local query = opts.args
		local lon, lat = geovim.geocode(query)
		print(lon)
		print(lat)
        -- geovim.geocode(geovim.geocode(query))
    end,
    { desc = "Insert a dummy coordinate at the cursor" }
)
