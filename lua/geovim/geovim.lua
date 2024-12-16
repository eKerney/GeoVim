-- [[ GEOVIM BUSINESS LOGIC ]] --
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')

local log = require('plenary.log'):new()
log.level = 'debug'

-- automatically source file on <leader>w  save
vim.keymap.set("n", "<leader>w", ":w<cr>:source %<cr>")

local M = {}

local find_geojson = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  -- finders.new_async_job {
  --   command_generator = function(prompt)
  --     if not prompt or prompt == "" then
  --       return nil
  --     end
  --
  --     local pieces = vim.split(prompt, "  ")
  --     local args =
  --   end
  -- }

  pickers.new(opts, {
    finder = finders.new_async_job({
      command_generator = function()
        return { "rg", "-g", "*.geojson", "--files" }
      end,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end
    }),

    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts, {}),


  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<leader>gv", find_geojson)
end


return M
