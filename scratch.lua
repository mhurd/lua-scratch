#!/usr/local/bin/lua

-- Seven More Languages in Seven Weeks Lua Excercises 

print("*** while loop:")
local i = 1
local a = {0, 1, 2, "FROG!"}
while a[i] do
  print(a[i])
  i = i + 1
end

print()
print("*** repeat loop:")
i=1
repeat
    print(a[i])
    i = i+1
until a[i] == "FROG!"

print()
print("*** last digit is 3:")
function ends_in_3 (num)
    return num % 10 == 3
end

function print_ends_in_3 (num)
    local r = ends_in_3(num)
    print("is 3 the last digit of " .. num .. "? = " .. tostring(r))
    return r
end

print_ends_in_3(100)
print_ends_in_3(335)
print_ends_in_3(333)
print_ends_in_3(3337)
print_ends_in_3(100013)

print()
print("*** is prime?")
function is_prime (num)
    if (num <= 1) then 
        return false
    end    
    if (num == 2) then
        return true
    end
    local i = 2
    local not_prime = false
    repeat 
        not_prime = num % i == 0
        i = i + 1
    until i > (num / 2) or not_prime == true 
    local r =  not not_prime
    return r 
end

function print_is_prime (num)
    local r = is_prime(num)
    print("Is " .. num .. " prime? " .. tostring(r))
    return r
end
 
print_is_prime(1, true)
print_is_prime(2, true)
print_is_prime(3, true)
print_is_prime(4, true)
print_is_prime(9, true)
print_is_prime(11, true)
print_is_prime(104729, true) --10,000th prime
print_is_prime(611953, true, true) --50,000th prime
print_is_prime(611838, true) -- not prime

print()
print("*** Printing n primes that end in 3:")
function n_primes_ending_in_3 (num)
    local i = 0
    local t = 0
    repeat
        if ends_in_3(i, false) and is_prime(i, false) then
            print(i .. " is prime and ends in 3.")
            t = t + 1
        end
        i = i + 1
    until t == num
end

n_primes_ending_in_3(10)

print()
print("*** What if Lua didn't have a for loop:")
function for_loop (a, b, f)
    local i = a
    while  i <= b do
        f(i)
        i = i + 1
    end
end

print("function does print(num*2)")
for_loop(5, 10, function(num) print(num .. " -> " .. num*2) end)

print()
print("*** Reduce function:")
function reduce (max, init, f)
    local i = 1
    local t = init
    while  i <= max do
        t = f(t, i)
        i = i + 1
    end
    return t
end

function add (previous, next)
    return previous + next
end

function multiply (previous, next)
    return previous * next
end

print("reducing 1 to 5 using add: " .. reduce(5, 0, add))
print("reducing 1 to 5 using multiply: " .. reduce(5, 1, multiply))

print()
print("*** Factorial in terms of reduce:")
function factorial (num) 
    return reduce(num, 1, multiply)
end

print("Factorial of 5 = " .. factorial(5))
print("Factorial of 9 = " .. factorial(9))
print("Factorial of 66 = " .. factorial(66))