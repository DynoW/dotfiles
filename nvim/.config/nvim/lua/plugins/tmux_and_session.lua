return {
  -- Seamless Ctrl+hjkl navigation between tmux and nvim
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    keys = {
      { "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux navigate left" },
      { "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux navigate down" },
      { "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux navigate up" },
      { "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux navigate right" },
    },
  },
}
