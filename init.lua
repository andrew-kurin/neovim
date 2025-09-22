-- Load LSP compatibility fix before everything else
require("config.lsp_fix")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
