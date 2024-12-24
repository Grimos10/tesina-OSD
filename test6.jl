using Base.Threads
using BenchmarkTools

function threaded_sum(arr)
    s = Atomic{Int}(0)  # Variabile atomica per evitare data races
    Threads.@threads for i in arr
        atomic_add!(s, i)
    end
    return s[]
end

arr = collect(1:10^6)


@btime threaded_sum(arr)

