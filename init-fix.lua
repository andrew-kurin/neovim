-- Add this to your init.lua temporarily
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("fix-lsp").fix_mappings()
    -- Reload LazyVim LSP configuration
    vim.cmd("lua require('lazyvim.plugins.lsp')")
  end,
  once = true,
})

-- Then load your normal config
require("config.lazy")
