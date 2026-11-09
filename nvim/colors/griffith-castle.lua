-- Griffith Castle · Neovim colourscheme
-- Built the way the amber theme does it: the everforest-nvim
-- engine (soft), shown through omarchy's transparency.lua so the
-- terminal's black shows through. The palette is Griffith's own:
-- blood-forward, bone identifiers, one cool note for strings.
pcall(function()
  require("lazy").load({ plugins = { "everforest-nvim" } })
end)

local everforest = require("everforest")
everforest.setup({
  background = "soft",
  colours_override = function(p)
    p.fg = "#ddd5d2"          -- bone, faintly warm
    p.red = "#d94f57"         -- keywords: blood
    p.orange = "#e0805f"      -- operators: ember
    p.yellow = "#d9b98a"      -- types: parchment
    p.green = "#eba0a0"       -- functions: pale rose (main accent)
    p.aqua = "#a9b8a3"        -- strings: muted sage, the one cool note
    p.blue = "#b9a0ab"        -- fields: dusty rose-grey (the haze)
    p.purple = "#c890be"      -- numbers/constants: haze magenta
    p.grey0 = "#6e6466"
    p.grey1 = "#867b7e"       -- comments, delimiters
    p.grey2 = "#a0969a"
    p.statusline1 = "#d94f57"
    p.statusline2 = "#ddd5d2"
    p.statusline3 = "#d94f57"
    p.bg_dim = "#0e090a"
    p.bg0 = "#140d0f"
    p.bg1 = "#1c1214"         -- cursorline
    p.bg2 = "#241719"
    p.bg3 = "#2e1d21"
    p.bg4 = "#382429"
    p.bg5 = "#4a3036"         -- line numbers
    p.bg_visual = "#551b24"   -- selection: blood
    p.bg_red = "#3d1519"
    p.bg_green = "#1d2420"
    p.bg_blue = "#1e1a24"
    p.bg_yellow = "#2a2218"
    p.bg_purple = "#2a1a28"
  end,
})
everforest.load()
vim.g.colors_name = "griffith-castle"
