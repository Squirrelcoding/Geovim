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
  math.randomseed(os.time())
  local lon = 180 * math.random()
  local u = 2 * math.random() - 1
  print(u)
  local lat = math.deg(math.asin(u))
	print(lon, lat)
end

-- code stolen from stack overflow
function M.haversine_distance(lon1, lat1, lon2, lat2)
  local earth_radius = 6372.8

  -- Convert coordinates to radians
  lon1 = math.rad(lon1)
  lat1 = math.rad(lat1)
  lon2 = math.rad(lon2)
  lat2 = math.rad(lat2)

  local dlon = lon2 - lon1
  local dlat = lat2 - lat1
  local a = math.pow(math.sin(dlat / 2), 2) + math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlon/2), 2)
  local c = 2 * math.asin(math.sqrt(a))
  return c * earth_radius
end

function M.midpoint(lon1, lat1, lon2, lat2)
  -- Convert degrees to radians
  lon1 = math.rad(lon1)
  lat1 = math.rad(lat1)
  lon2 = math.rad(lon2)
  lat2 = math.rad(lat2)

  -- Convert to cartesian coordinates
  local x1 = math.cos(lat1) * math.cos(lon1)
  local y1 = math.cos(lat1) * math.sin(lon1)
  local z1 = math.sin(lat1)
  local x2 = math.cos(lat2) * math.cos(lon2)
  local y2 = math.cos(lat2) * math.sin(lon2)
  local z2 = math.sin(lat2)

  -- compute averages
  local x_avg = (x1 + x2) / 2
  local y_avg = (y1 + y2) / 2
  local z_avg = (z1 + z2) / 2

  -- convert averages to coordinates
  local r = math.sqrt(x_avg * x_avg + y_avg * y_avg + z_avg * z_avg)
  local lat_avg = math.deg(math.atan2(z_avg / r, math.sqrt((x_avg / r) * (x_avg / r) + (y_avg / r) * (y_avg / r))))
  local lon_avg = math.deg(math.atan2(y_avg / r, x_avg / r))
  print(lon_avg, lat_avg)
  return string.format("%f, %f", lat_avg, lon_avg)
end

function M.fun_fact(query)
	print("hi")
	print("hi")
	print("hi")
	print("hi")
end

function M.not_fun_fact(query)
	print("hi")
  print("bye!")
	print("hi")
	print("hi")
	print("hi")
end

function M.sign_up(query)
	print("hi")
  print("bye!")
	print("hi")
	print("hi")
	print("hi")
end

function M.log_in(query)
	print("hi")
	print("hi")
	print("hi")
	print("hi")
	print("hi")
  print("bye!")
end

function M.get_lots_of_parking_lots(query)
	print("hi")
  print("bye!")
end

return M
