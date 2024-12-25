using Base.Threads
using BenchmarkTools

function increment_with_lock(n)
    my_lock = ReentrantLock()  
    counter = 0 

    Threads.@threads for _ in 1:n
        lock(my_lock) do
            counter += 1
        end
    end
    
    return counter
end

n = 10^6  
@btime result = increment_with_lock(n)

