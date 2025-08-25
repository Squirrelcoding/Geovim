local geovim = require("geovim")

local title = [[
                          ,----..                                 ____  
  ,----..       ,---,.   /   /   \                 ,---,        ,'  , `.
 /   /   \    ,'  .' |  /   .     :        ,---.,`--.' |     ,-+-,.' _ |
|   :     : ,---.'   | .   /   ;.  \      /__./||   :  :  ,-+-. ;   , ||
.   |  ;. / |   |   .'.   ;   /  ` ; ,---.;  ; |:   |  ' ,--.'|'   |  ;|
.   ; /--`  :   :  |-,;   |  ; \ ; |/___/ \  | ||   :  ||   |  ,', |  ':
;   | ;  __ :   |  ;/||   :  | ; | '\   ;  \ ' |'   '  ;|   | /  | |  ||
|   : |.' .'|   :   .'.   |  ' ' ' : \   \  \: ||   |  |'   | :  | :  |,
.   | '_.' :|   |  |-,'   ;  \; /  |  ;   \  ' .'   :  ;;   . |  ; |--' 
'   ; : \  |'   :  ;/| \   \  ',  /    \   \   '|   |  '|   : |  | ,    
'   | '/  .'|   |    \  ;   :    /      \   `  ;'   :  ||   : '  |/     
|   :    /  |   :   .'   \   \ .'        :   \ |;   |.' ;   | |`-'      
 \   \ .'   |   | ,'      `---`           '---" '---'   |   ;/          
  `---`     `----'                                      '---'                 
]]

vim.api.nvim_create_user_command(
    "GeoVimGetCoordinates",
    function()
		local handle = io.popen('curl -s "https://ipinfo.io/loc"')
		local result = handle:read("*a")
		handle:close()

		print(result)

    end,
    { desc = "Say hello from GeoVim" }
)

vim.api.nvim_create_user_command(
    "GeoVimReverseGeoCode",
    function(opts)
        local lat = opts.fargs[1]
        local lon = opts.fargs[2]
        local result = geovim.reverse_geocode(lon, lat)
		vim.fn.setreg('+', result)

    end,
    { 
        desc = "Insert a dummy coordinate at the cursor",
        nargs = "+"
    }
)

local function split_lines(str)
    local t = {}
    for line in str:gmatch("[^\r\n]+") do
        table.insert(t, line)
    end
    return t
end

local function center_lines(lines, width)
    local centered = {}
    for _, line in ipairs(lines) do
        local padding = math.floor((width - #line) / 2)
        if padding < 0 then padding = 0 end
        table.insert(centered, string.rep(" ", padding) .. line)
    end
    return centered
end

vim.api.nvim_create_user_command(
    "Geovimart",
    function()
        local lines = split_lines(title)
        local win_width = vim.o.columns * 0.8
        local win_height = #lines

        local buf = vim.api.nvim_create_buf(false, true)

        local opts = {
            relative = "editor",
            width = win_width,
            height = win_height,
            col = (vim.o.columns - win_width) / 2,
            row = (vim.o.lines - win_height) / 2,
            style = "minimal",
            border = "rounded"
        }

		local win = vim.api.nvim_open_win(buf, true, opts)
        local centered = center_lines(lines, win_width)
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, centered)

	end,
	{
		desc = "debug"
	}
)