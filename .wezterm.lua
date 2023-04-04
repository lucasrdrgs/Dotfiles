local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Dracula'

config.colors = {
  background = 'black',
  selection_bg = 'white',
  selection_fg = 'black',
  cursor_bg = 'white',
  cursor_fg = 'black',
}

config.font = wezterm.font 'Liga Menlo'

config.window_background_opacity = 0.85

config.keys = {
  {
    key = 'v',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'h',
    mods = 'CTRL|ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'w',
    mods = 'CTRL|ALT',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

return config
