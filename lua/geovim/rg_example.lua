local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')
local log = require('plenary.log'):new()
log.level = 'debug'

local M = {}

M.show_geodata = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    finder = finders.new_oneshot_job({ 'rg', '--line-number', '--column', '' }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    entry_maker = function(entry)
      log.debug('maker', entry)
      return {
        value = entry,
      }
    end,

    previewer = previewers.new_buffer_previewer({
      log.debug(entry),
      define_preview = function(self, entry)
        -- vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true,
        --   -- vim.split(vim.inspect(entry[1]), "\n")
        --   vim.tbl_flatten({
        --     "```lua",
        --     vim.split(vim.inspect(entry[1]), "\n"),
        --     "```",
        --   })
        -- )
        utils.highlighter(self.state.bufnr, "markdown")
      end,
    })

  }):find()
end

M.show_geodata()
return M
