local pickers = require("telescope.pickers")
local config = require('telescope.config').values
local finders = require("telescope.finders")
local sorters = require('telescope.sorters')
local log = require('plenary.log'):new()
log.level = 'debug'

pickers.new(opts, {
  finder = finders.new_table({
    -- 1. Structured data inside `results`.
    results = {
      { title = "One", tags = "Tag1, Tag2", path = "posts/2024-01-01-one.dj" },
      { title = "Two", tags = "Tag2",       path = "posts/2024-02-02-two.dj" },
    },
    -- 2. A function that converts a result entry to an entry telescope understands.
    entry_maker = function(entry)
      return {
        -- Display the post title instead of the path in the list.
        display = entry.title,
        -- Allow us to filter against the title and tags (typing `Tag1` finds the "One" post).
        ordinal = entry.title .. entry.tags,
        -- We could also save the whole entry for future usage, if we need it.
        value = entry,
      }
    end,
  }),
  -- sorter = config.generic_sorter(opts),
  sorter = sorters.get_generic_fuzzy_sorter(),
  log.debug(vim.api.nvim_list_bufs())

}):find()
