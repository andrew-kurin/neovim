-- ABOUTME: Fix for LazyVim compatibility with newer mason-lspconfig.nvim
-- ABOUTME: Creates compatibility shim for mason-lspconfig.mappings API changes

-- This fixes the issue where LazyVim's core LSP configuration tries to access
-- mason-lspconfig.mappings which was restructured in newer versions

-- Create the compatibility module directly in package.preload
-- This ensures it's available before LazyVim tries to require it
package.preload["mason-lspconfig.mappings"] = function()
  local mason_lspconfig = require("mason-lspconfig")

  -- Get available servers from mason-lspconfig
  local available_servers = mason_lspconfig.get_available_servers()
  local lspconfig_to_package = {}

  -- Build the mapping that LazyVim expects
  for _, server in ipairs(available_servers) do
    lspconfig_to_package[server] = server
  end

  return {
    get_mason_map = function()
      return {
        lspconfig_to_package = lspconfig_to_package
      }
    end
  }
end

return {}
