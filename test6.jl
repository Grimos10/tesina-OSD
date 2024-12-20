using Base.Threads
using BenchmarkTools

function threaded_sum(arr)
    s = Atomic{Int}(0)  # Variabile atomica per evitare data races
    @threads for i in arr
        atomic_add!(s, i)
    end
    return s[]
end

# Creazione di un array
arr = collect(1:10^9)

# Calcolo della somma con multi-threading
#result = threaded_sum(arr)
@time threaded_sum(arr)

#println("Risultato: $result")
