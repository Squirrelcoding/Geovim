-- lua/geovim/init.lua
local M = {}

-- Example subcommand 1: Print Hello
function M.hello()
    print("Hello from GeoVim!")
end

-- Example subcommand 2: Print coordinates (just dummy for now)
function M.paste_coordinates(lat, lon)
    lat = lat or 0
    lon = lon or 0
    local coords = string.format("(%s, %s)", lat, lon)
    -- Insert at cursor position
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row-1, col, row-1, col, {coords})
    print("Inserted coordinates: " .. coords)
end

-- Example subcommand 3: Reverse geocode placeholder
function M.reverse_geocode(lat, lon)
    print(string.format("Looking up address for: (%s, %s)", lat or "0", lon or "0"))
    -- TODO: Add API call here
end

return M
