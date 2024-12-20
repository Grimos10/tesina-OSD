using Base.Threads
using BenchmarkTools

function increment_with_lock(n)
    my_lock = ReentrantLock()  # Crea un oggetto lock
    counter = 0  # Variabile condivisa da proteggere

    Threads.@threads for _ in 1:n
        lock(my_lock) do
            counter += 1
        end
    end

    return counter
end

# Test della funzione
n = 10^5  # Numero di iterazioni
@time result = increment_with_lock(n)

println("Risultato: $result")