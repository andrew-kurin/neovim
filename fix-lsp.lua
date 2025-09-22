-- This file will help fix the mason-lspconfig issue
local M = {}

function M.fix_mappings()
  -- Create a shim for the missing module
  local mappings_path = vim.fn.stdpath("data") .. "/lazy/mason-lspconfig.nvim/lua/mason-lspconfig/mappings"
  local server_dir = mappings_path .. "/server"
  
  -- Create server directory if it doesn't exist
  vim.fn.mkdir(server_dir, "p")
  
  -- Create the server.lua file with proper content
  local server_file = server_dir .. "/init.lua"
  local content = [[
-- This is a compatibility shim for LazyVim
local mason_mappings = require("mason-lspconfig.mappings")

local M = {}

-- Export the mappings that LazyVim expects
M.lspconfig_to_package = mason_mappings.get_mason_map().lspconfig_to_package

return M
]]
  
  local file = io.open(server_file, "w")
  if file then
    file:write(content)
    file:close()
    print("Created compatibility shim for mason-lspconfig")
    return true
  else
    print("Failed to create compatibility shim")
    return false
  end
end

return M
