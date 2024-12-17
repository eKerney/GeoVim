print("Greetings Earth")
-- nmap <Leader>w :write<CR>:source<CR>

-- defines a factorial function
function fact(n)
  if n == 0 then
    return 1
  else
    return n * fact(n - 1)
  end
end

print("enter a number:")
a = io.read("*number") -- read a number
print(fact(a))

-- global binding
x = 42
print(x)
-- declaring nil makes lua think binding never existed
x = nil
print(x)

-- tables
a = {}              -- create a table and store its reference in `a'
k = "x"
a[k] = 10           -- new entry, with key="x" and value=10
a[20] = "great"     -- new entry, with key=20 and value="great"
print(a["x"])       --> 10
k = 20
print(a[k])         --> "great"
a["x"] = a["x"] + 1 -- increments entry "x"
print(a["x"])       --> 11


a = {} -- empty table
-- create 1000 new entries
for i = 1, 1000 do a[i] = i * 2 end
print(a[9])   --> 18
a["x"] = 10
print(a["x"]) --> 10
print(a["y"]) --> nil

a.x = 10      -- same as a["x"] = 10
print(a.x)    -- same as print(a["x"])
print(a.y)    -- same as print(a["y"])

a = {}; a.x = 1; a.y = 0
b = {}; b.x = 1; b.y = 0
c = a

print(a == c)
print(a ~= b)

-- you have that a==c but a~=b.
x = 1
v = 100
if not x then x = v end
print(x)

x = 360
y = 180
max = (x > y) and x or y
print(max)

-- strings
print("Hello " .. "World") --> Hello World
print(0 .. 1)              --> 01
