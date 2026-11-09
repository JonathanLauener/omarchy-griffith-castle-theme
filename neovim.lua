-- Griffith Castle: same engine as the amber theme (neanias/everforest-nvim),
-- own palette. The colourscheme lives in this theme's nvim/colors/ and is
-- linked to ~/.config/nvim/colors/ by the griffith-castle theme-set hook.
return {
  { "neanias/everforest-nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "griffith-castle",
    },
  },
}
