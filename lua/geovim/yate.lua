local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local log = require('plenary.log'):new()
log.level = 'debug'

local M = {}

M.show_geodata = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "colors",
    finder = finders.new_oneshot_job({ "rg", "-g", "*.geojson", "--files", }, opts),
    previewer = conf.grep_previewer(opts, {}),
    sorter = conf.file_sorter(opts),

  }):find()
end

M.show_geodata()
return M

-- nmap <Leader>w :write<CR>:source<CR>
