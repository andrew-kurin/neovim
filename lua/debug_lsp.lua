local M = {}

function M.diagnose()
  local lazy_dir = vim.fn.stdpath("data") .. "/lazy"
  local mason_dir = vim.fn.stdpath("data") .. "/mason"
  
  local function check_path(path)
    return vim.fn.isdirectory(path) == 1 and "EXISTS" or "MISSING"
  end
  
  local function check_file(path)
    return vim.fn.filereadable(path) == 1 and "EXISTS" or "MISSING"
  end
  
  local results = {
    ["lazy directory"] = check_path(lazy_dir),
    ["mason directory"] = check_path(mason_dir),
    ["mason-lspconfig"] = check_path(lazy_dir .. "/mason-lspconfig.nvim"),
    ["mason-lspconfig lua dir"] = check_path(lazy_dir .. "/mason-lspconfig.nvim/lua"),
    ["mason-lspconfig mappings"] = check_file(lazy_dir .. "/mason-lspconfig.nvim/lua/mason-lspconfig/mappings.lua"),
    ["mason-lspconfig server (expected)"] = check_path(lazy_dir .. "/mason-lspconfig.nvim/lua/mason-lspconfig/mappings/server"),
    ["LazyVim lsp init"] = check_file(lazy_dir .. "/LazyVim/lua/lazyvim/plugins/lsp/init.lua"),
  }
  
  vim.api.nvim_echo({{"=== LSP Diagnostics ===\n", "Title"}}, false, {})
  for name, status in pairs(results) do
    local hl = status == "EXISTS" and "String" or "Error"
    vim.api.nvim_echo({{name .. ": ", "None"}, {status, hl}}, false, {})
    vim.api.nvim_echo({{"", "None"}}, true, {})
  end
  
  -- Try to load modules
  local modules = {
    "mason",
    "mason-lspconfig",
    "mason-lspconfig.mappings",
    "mason-lspconfig.mappings.server",
    "lazyvim.plugins.lsp",
  }
  
  vim.api.nvim_echo({{"=== Module Loading ===\n", "Title"}}, false, {})
  for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    local status = ok and "LOADED" or "FAILED"
    local hl = ok and "String" or "Error"
    vim.api.nvim_echo({{module .. ": ", "None"}, {status, hl}}, false, {})
    if not ok then
      vim.api.nvim_echo({{"  Error: " .. tostring(err), "Comment"}}, false, {})
    end
    vim.api.nvim_echo({{"", "None"}}, true, {})
  end
end

return M
