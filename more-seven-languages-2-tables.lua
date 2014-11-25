#!/usr/local/bin/lua

-- Seven More Languages in Seven Weeks Lua Excercises - tables

greek_numbers = {
    ena = "one",
    dyo = "two",
    tria = "three"
}

function table_to_string (t) 
    local mt = getmetatable(t)
    if not (mt == nil) then
        if not (mt.privateTable == null) then
            t = mt.privateTable
        end
    end
    local result = {}
    for k, v in pairs(t) do
        result[#result + 1] = k .. ": " .. v
    end
    return table.concat(result, "\n")
end

function strict_read(table, key)
    local priv = getmetatable(table).privateTable
    if priv[key] then
        return priv[key]
    else
        local err = "Invalid key: " .. key
        print("   Error! " .. err)
        error(err)
    end
end

function strict_write(table, key, value)
    local priv = getmetatable(table).privateTable
    if priv[key] then
        if value == nil then
            priv[key] = nil
        else
            local err = "Duplicate key: " .. key
            print("   Error! " .. err)
            error(err)
        end
    else
        priv[key] = value
    end
end

metatable = {
    __tostring = table_to_string,
}

strict_metatable = {
    privateTable = {},
    new = function (self)
            return {
                privateTable = {},
                new = self.new,
                __tostring = self.__tostring,
                __index = self.__index,
                __newindex = self.__newindex
            }
        end,
    __tostring = table_to_string,
    __index = strict_read,
    __newindex = strict_write
}

setmetatable(greek_numbers, metatable)

print("*** Override printing tables via metatable:")
print(greek_numbers)

print()
print("*** Concatinate two arrays:")
function concatinate (a1, a2)
    local r = {}
    setmetatable(r, metatable)
    for i = 1, #a1 do
        r[i] = a1[i]     
    end
    for i = 1, #a2 do
        r[#r + 1] = a2[i]
    end
    return r
end

a1 = {1, 2, 3, 4}
setmetatable(a1, metatable)
a2 = {5, 6}
setmetatable(a2, metatable)
print("Concatinate {1, 2, 3, 4} & {5, 6} is:")
print(tostring(concatinate(a1, a2)))

print()
print("*** Strict write handles nils")
t1 = {}
setmetatable(t1, strict_metatable:new())
t1.one = 1
t1.two = 2
t1.three = 3
print(t1)
print("Throws error: t1.three = 4")
pcall(function () t1.three = 4 end)
print("Throws error: print(t1.five)");
pcall(function () print(t1.five) end)
print("Can add nil without a duplicate key error: t1.three = nil")
pcall(function () t1.three = nil end)
print(t1)