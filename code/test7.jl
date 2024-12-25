using Base.Threads
using BenchmarkTools

function threaded_sqrt(arr)
    results = Vector{Float64}(undef, length(arr))  # Array per i risultati
    @threads for i in eachindex(arr)
        results[i] = sqrt(arr[i])
    end
    return results
end

# Creazione di un array di numeri grandi
arr = collect(1.0:10^9)

#results = threaded_sqrt(arr)

# Calcolo della radice quadrata con multi-threading
#@btime threaded_sqrt(arr)

@btime map(sqrt, arr)

#println("Radice quadrata del primo elemento: $(results[1])")
#println("Radice quadrata dell'ultimo elemento: $(results[end])")
