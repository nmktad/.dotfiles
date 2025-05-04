return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettierd', 'prettier', 'biome' },
      typescript = { 'prettierd', 'prettier', 'biome' },
      javascriptreact = { 'prettierd', 'prettier', 'biome' },
      typescriptreact = { 'prettierd', 'prettier', 'biome' },
      -- javascript = { 'prettierd', 'biome' },
      -- typescript = { 'prettierd', 'biome' },
      -- javascriptreact = { 'prettierd', 'biome' },
      -- typescriptreact = { 'prettierd', 'biome' },
      markdown = { 'prettierd' },

      -- Conform will run multiple formatters sequentially
      go = { 'goimports', 'gofumpt', 'gopls' },

      -- JSON formatter using jq
      json = { 'jq' },

      --  Dockerfile formatter using hadolint
      dockerfile = { 'hadolint' },

      -- You can also customize some of the format options for the filetype
      rust = { 'rustfmt', lsp_format = 'fallback' },

      python = function(bufnr)
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' }
        else
          return { 'isort', 'black' }
        end
      end,

      -- Use the "*" filetype to run formatters on all filetypes.
      ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
  },
}
