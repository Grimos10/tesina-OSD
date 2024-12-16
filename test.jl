using BenchmarkTools

function montecarlo_pi(num_samples)
    inside_circle = Threads.Atomic{Int}(0)

    Threads.@threads for _ in 1:num_samples
        x, y = rand(), rand()
        if x^2 + y^2 <= 1
            Threads.atomic_add!(inside_circle, 1)
        end
    end

    return 4 * inside_circle[] / num_samples
end

@btime montecarlo_pi(10^7)
