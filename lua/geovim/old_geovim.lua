local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require('telescope.previewers')
local utils = require('telescope.previewers.utils')

local log = require('plenary.log'):new()
log.level = 'debug'

-- Need this for LSP/treesitter to format geojson as json in buffer
--
-- vim.filetype.add({
--   extension = {
--     geojson = 'json',
--   }
-- })

-- automatically source file on <leader>w  save
vim.keymap.set("n", "<leader>w", ":w<cr>:source %<cr>")

local M = {}

local find_geojson = function(opts)
  opts = opts or {}

  pickers.new(opts, {
    finder = finders.new_async_job({
      command_generator = function()
        return { "rg", "-g", "*.geojson", "--files" }
      end,
      -- results = {
      --   -- "1", "2", "3", "4",
      --   { name = "Yes",     value = { 1, 2, 3 } },
      --   { name = "No",      value = { 1, 2, 3 } },
      --   { name = "Maybe",   value = { 1, 2, 3 } },
      --   { name = "Perhaps", value = { 1, 2, 3 } },
      -- },
      entry_maker = function(entry)
        log.debug(entry)
        -- local parsed = vim.json.decode(entry)
        -- log.debug(parsed)
        return {
          value = entry,
          display = entry,
          ordinal = entry,
        }
      end
    }),

    sorter = conf.generic_sorter(opts),
    previewer = conf.grep_previewer(opts, {}),

    -- previewer = previewers.new_buffer_previewer({
    --   title = "Docker Image Details",
    --   define_preview = function(self, entry)
    --     vim.api.nvim_buf_set_lines(
    --       self.state.bufnr,
    --       0,
    --       0,
    --       true,
    --       vim.tbl_flatten({
    --         "hi",
    --         "",
    --         "```lua",
    --         vim.split(vim.inspect(entry.value), "\n"),
    --         "```",
    --       })
    --     )
    --     utils.highlighter(self.state.bufnr, "markdown")
    --   end
    -- })

  }):find()
  -- pickers.new(opts, {
  --   prompt_title = "GeoVim",
  --   finder = finders.new_oneshot_job({ "rg", "-g", "*.geojson", "--files", }, opts),
  --   previewer = conf.grep_previewer(opts, {}),
  --   sorter = conf.file_sorter(opts),
  --   print("Installing Telescope and dependencies."),
  -- }):find()
  -- vim.fn.system { 'echo', 'heyey' }
end

M.setup = function()
  vim.keymap.set("n", "<leader>,m", find_geojson)
  -- find_geojson()
end

find_geojson()
require('custom.multigrep').setup()

return M
