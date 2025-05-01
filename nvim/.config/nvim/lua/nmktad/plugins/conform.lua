return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { 'prettierd', 'biome' },
      markdown = { 'prettierd' },
      typescript = { 'prettierd', 'biome' },
      javascriptreact = { 'prettierd', 'biome' },
      typescriptreact = { 'prettierd', 'biome' },

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

    -- Set this to change the default values when calling conform.format()
    -- This will also affect the default values for format_on_save/format_after_save
    default_format_opts = {
      lsp_format = 'fallback',
    },

    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,

    notify_on_error = false,
    notify_no_formatters = true,
  },
}
