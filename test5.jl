using Base.Threads
using BenchmarkTools

function sum_single(a)
    s = 0
    for x in a
        s += x
    end
    return s
end

function sum_multi(a)
    chunks = Iterators.partition(a, length(a) ÷ Threads.nthreads())
    tasks = map(chunks) do chunk
        Threads.@spawn sum_single(chunk)
    end
    chunk_sums = fetch.(tasks)
    return sum_single(chunk_sums)
end

@btime sum_multi(1:999_999_999_999_999_999)
