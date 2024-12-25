using Base.Threads

a = zeros(Int, 10)
println(a)
Threads.@threads for i = 1:10
    a[i] = Threads.threadid()
end

println(a)