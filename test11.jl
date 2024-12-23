########################################
# Data-Race example
########################################
using BenchmarkTools

n = 1_000_000_000

#myvector = collect(1:n)
myvector = Vector{Int8}(undef, n)
for i in 1:n
    myvector[i] = Int8(i % 128)
end
# single-threaded

myvector

@btime sum(myvector)

# single-threaded

function multi_sum1(myvector)
    temp = 0
    for i in eachindex(myvector)
        temp += myvector[i]
    end
    return temp
end

@btime multi_sum1(myvector)

# multi-threaded with data-race

function multi_sum2(myvector)
    temp = 0
    Threads.@threads for i in eachindex(myvector)
        temp += myvector[i]
    end
    return temp
end

multi_sum2(myvector)

# multi-threaded without data-race

function multi_sum3(myvector)
    temp = zeros(Int, Threads.nthreads())
    Threads.@threads for i in eachindex(myvector)
        temp[Threads.threadid()] += myvector[i]
    end
    # for i in eachindex(temp)
    #     println(i, "\t = ", temp[i])
    # end
    return sum(temp)
end

@btime multi_sum3(myvector)

# time

@time multi_sum3(myvector)

@time sum(myvector)


