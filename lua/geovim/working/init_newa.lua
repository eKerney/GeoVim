local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')
local log = require('plenary.log'):new()
log.level = 'debug'

local M = {}

M.show_geodata = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_oneshot_job({ "rg", "-g", "*.geojson", "--files", }, opts),
    entry_maker = function(entry)
      log.debug('entry', entry)
      return {
        -- Make standard action open `entry.path`.
        filename = entry.path,
      }
    end,
    previewer = conf.grep_previewer(opts, {}),

    -- previewer = previewers.new_buffer_previewer({
    --   -- Title isn't needed.
    --   title = "Post Preview",
    --   define_preview = function(self, entry)
    --     -- Notice `entry.value.path` that uses our catch-all entry value.
    --     conf.buffer_previewer_maker(entry.value.path, self.state.bufnr, {
    --       bufname = self.state.bufname,
    --       winid = self.state.winid,
    --       preview = opts.preview,
    --       -- The file encoding is needed for proper syntax highlighting.
    --       file_encoding = opts.file_encoding,
    --     })
    --   end,
    -- }),
    --

    sorter = conf.file_sorter(opts),

  }):find()
end

M.show_geodata()
return M

-- nmap <Leader>w :write<CR>:source<CR>
