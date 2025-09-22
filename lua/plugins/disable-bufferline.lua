-- ABOUTME: Disables bufferline plugin to fix configuration errors
-- ABOUTME: This prevents LazyVim from loading bufferline which was causing startup errors

return {
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}