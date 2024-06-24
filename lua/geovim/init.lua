local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local config = require('telescope.config').values
local M = {}

M.show_geodata = function(opts)
  print('hello geoworld space')
  pickers.new(opts, {
    finder = finders.new_table({
      'Yes',
      'No',
      'Possible',
      'Perhaps'
    }),
    sorter = config.generic_sorter(opts),
  }):find()
end

M.show_geodata()
-- nmap <Leader>w :write<CR>:source<CR>

return M
