return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    local chatgpt = require("chatgpt")
    chatgpt.setup({
      api_key_cmd = "op item get OPENAI_MBAIR --fields label=password",
    })
    vim.keymap.set(
      "n",
      "<leader>v",
      chatgpt.edit_with_instructions,
      { remap = false, desc = "ChatGPT edit with instructions" }
    )
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
    "nvim-telescope/telescope.nvim",
  },
}
