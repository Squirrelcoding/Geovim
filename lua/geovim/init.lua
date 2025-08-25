local M = {}

-- Reverse geocode
function M.reverse_geocode(lat, lon)
	local url = "https://nominatim.openstreetmap.org/search?q=Minneapolis&format=json"
	local result = vim.fn.system({ "curl", "-s", url })
	local decoded = vim.fn.json_decode(result)

	print(vim.inspect(decoded)) 
end

local function url_escape(str)
    if not str then return "" end
    str = string.gsub(str, "([^%w%.%- ])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)
    str = string.gsub(str, " ", "+")
    return str
end

function M.geocode(user_input)
	local url = string.format("https://nominatim.openstreetmap.org/search?q=%s&format=json", url_escape(user_input))
	local result = vim.fn.system({ "curl", "-s", url })
	local decoded = vim.fn.json_decode(result)

	local lon = decoded[1]["lon"]
	local lat = decoded[1]["lat"]

	return lon, lat
end


function M.reverse_geocode(lon, lat)
	local url = string.format("https://nominatim.openstreetmap.org/reverse?lat=%f&lon=%f&format=json", lat, lon)
	local result = vim.fn.system({ "curl", "-s", url })
	local decoded = vim.fn.json_decode(result)


	return decoded['display_name']
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

function M.vibe_geocode(query)
	print("hi")
end

function M.vibe_reverse_geocode(query)
	print("hi")
end

function M.random_coordinates(query)
	print("hi")
end

function M.current_location(query)
	print("hi")
end

function M.haversine_distance(query)
	print("hi")
end

function M.distance(query)
	print("hi")
end

function M.fun_fact(query)
	print("hi")
end

function M.not_fun_fact(query)
	print("hi")
end

function M.sign_up(query)
	print("hi")
end

function M.log_in(query)
	print("hi")
end

function M.get_lots_of_parking_lots(query)
	print("hi")
end

-- Extra features:
-- Progress bar for premium users


return M
