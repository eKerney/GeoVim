local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')
local log = require('plenary.log'):new()
local make_entry = require "telescope.make_entry"
log.level = 'debug'

local M = {}

M.show_geodata = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    finder = finders.new_async_job({
      command_generator = function()
        return { 'rg', '-g', '*.geojson', '--files', }
        -- return { "docker", "images", "--format", "json" }
      end,

      -- entry_maker = function(entry)
      --   log.debug('maker', entry)
      --   return {
      --     value = entry,
      --     display = entry.name,
      --     ordinal = entry.name,
      --   }
      -- end
    }),

    sorter = config.generic_sorter(opts),

    previewer = previewers.new_buffer_previewer({
      log.debug(entry),
      log.debug(make_entry.gen_from_file(opts)),
      title = "GeoData File Details",
      define_preview = function(self, entry)
        log.debug('preview', entry)
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true,
          -- vim.split(vim.inspect(entry[1]), "\n")
          vim.tbl_flatten({
            "```lua",
            vim.split(vim.inspect(entry[1]), "\n"),
            "```",
          })
        )
        utils.highlighter(self.state.bufnr, "markdown")
      end,
    }),

  }):find()
end

M.show_geodata()
-- nmap <Leader>w :write<CR>:source<CR>

return M
