return {
  -- Install the Kanagawa plugin
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      theme = "dragon", -- options: "wave" (default), "dragon", "lotus"
      background = {
        dark = "dragon", -- sets dark mode to the Dragon variant
        light = "lotus",
      },
    },
  },

  -- Tell LazyVim to load it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon", -- loads the dragon theme directly
    },
  },
}
