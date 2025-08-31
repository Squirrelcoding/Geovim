# GeoVim

Are you working with coordinates in an app and need to quickly get the coordinates of a place? Or get the midpoint between two places? Then this is the plugin for you, it's desigtned to help you work with coordinates! 

## Installation

Using lazy.nvim:

```json
{
	'Squirrelcoding/Geovim',
}
```

Then run `:Lazy load Geovim` when you need it!

## Usage

- `:GeoVimArt` I don't know why I made this but it just brings up some nice ASCII art of the text "GEOVIM"
- `:GeoVimGetCoordinates "PLACE LOCATION"` You can put a place name inside the parentheses. The plugin uses the Nominatim geocoder so make sure to follow its naming conventions.
- `:GeoVimHaversine lon1 lat1 lon2 lat2` Gets the Haversine distance between a pair of coordinates and gets placed into the `+` register.
- `:GeoVimDistance lon1 lat1 lon2 lat2` Gets the geographical midpoint between a pair of coordinates and gets displayed.
- `:GeoVimRandomCoordinates` Uniformly generates random coordinates and displays them.