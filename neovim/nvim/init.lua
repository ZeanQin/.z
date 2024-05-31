-- load init.vim.deprecated
local vimrc = vim.fn.stdpath("config") .. "\\init.vim.deprecated"
vim.cmd.source(vimrc)

-- browser-bookmarks.nvim
require('telescope').setup {
  extensions = {
    bookmarks = {
      selected_browser = 'chrome',
      url_open_command = 'start chrome',
    }
  }
}
require('telescope').load_extension('bookmarks')
vim.keymap.set('n', '<Leader>fa', ':Telescope bookmarks<CR>')

-- which-key.nvim
vim.o.timeout = true
vim.o.timeoutlen = 300
require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}