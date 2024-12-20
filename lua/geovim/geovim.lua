-- [[ GEOVIM BUSINESS LOGIC ]] --
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require('telescope.previewers')
-- local utils = require('telescope.previewers.utils')
local M = {}

local log = require('plenary.log'):new()
log.level = 'debug'

-- automatically source file on <leader>w  save
vim.keymap.set("n", "<leader>w", ":w<cr>:source %<cr>")


local find_geojson = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job({
    command_generator = function()
      return { "rg", "-g", "*.geojson", "--files" }
    end,
  })

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "(:)GeoVim(:)",
    log.debug("OPTS", opts),
    finder = finder,
    previewer = conf.grep_previewer(opts),
    -- sorter = conf.generic_sorter(opts),

  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>gv", find_geojson)
end
print("HEY")

return M
