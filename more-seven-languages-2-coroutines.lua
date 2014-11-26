#!/usr/local/bin/lua

scheduler = require 'scheduler'

print("*** Coroutines and generators:")
function fibonacci()
    local m = 1
    local n = 1
    while true do
        coroutine.yield(m)
        m, n = n, m + n
    end
end

generator = coroutine.create(fibonacci)
succeeded, value = coroutine.resume(generator)
print("First resume: " .. value)
succeeded, value = coroutine.resume(generator)
print("Second resume: " .. value)
succeeded, value = coroutine.resume(generator)
print("Third resume: " .. value)
succeeded, value = coroutine.resume(generator)
print("Fourth resume: " .. value)

print()
print("*** Multi-tasking:")

function punch() 
    for i = 1, 4 do
        print('punch ' .. i)
        scheduler.wait(0.5)
    end
end

function block()
    for i = 1, 2 do
        print('block ' .. i)
        scheduler.wait(1.0)
    end
end

scheduler.schedule(0.0, coroutine.create(punch))
scheduler.schedule(0.0, coroutine.create(block))
scheduler.run()

print()
print("OO Queue:")

function table_to_string (t) 
    if t == nil then
        return "nil"
    end
    local result = {}
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
        result[#result + 1] = k .. ": " .. tostring(v)
    end
    if count == 0 then
        result = {"Empty"}
    end    
    return table.concat(result, "\n")
end

Queue = {
    name = "Queue",
    __tostring = table_to_string
}
function Queue:new(array)
    array = array or {}   -- create object if user does not provide one
    setmetatable(array, self)
    self.__index = self
    return array
end
function Queue:add(item)
    self[#self + 1] = item
end
function Queue:remove()
    if #self == 0 then
        return nil
    else
        r = self[1]
        for i = 1, #self do
            if i < #self then
                self[i] = self[i+1]
            else
                self[i] = nil
            end    
        end
        return r
    end
end
q = Queue:new({1, 2})
print(q)
print("Add 3 to the queue:")
q:add(3)
print(q)
print("Call remove: ")
print("Got " .. tostring(q:remove()))
print(q)
print("Call remove again: ")
print("Got " .. tostring(q:remove()))
print(q)
print("Call remove again: ")
print("Got " .. tostring(q:remove()))
print(q)
print("Call remove again: ")
print("Got " .. tostring(q:remove()))
print(q)