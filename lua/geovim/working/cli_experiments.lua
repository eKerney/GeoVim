local handle = io.popen("echo hello")
local result = handle:read("*a")
handle:close()
print(result)
