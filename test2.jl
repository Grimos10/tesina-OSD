using BenchmarkTools

function sum_with_threads(a)
    n = length(a)
    results = Vector{Float64}(undef, Threads.nthreads())

    Threads.@threads for t in 1:Threads.nthreads()
        start_idx = div(n * (t - 1), Threads.nthreads()) + 1
        end_idx = div(n * t, Threads.nthreads())
        results[t] = sum(a[start_idx:end_idx])
    end

    return sum(results)
end

arr = rand(1.0:100.0, 10^7)
@btime sum_with_threads(arr)