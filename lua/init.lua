require('geovim.geovim').setup()
print("IN INIT LUA!!!")

-- Need this for LSP/treesitter to format geojson as json in buffer
vim.filetype.add({
  extension = {
    geojson = 'json',
  }
})
