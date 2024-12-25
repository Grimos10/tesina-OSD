using Base.Threads
using Base

sem = Base.Semaphore(4)  # Permette l'accesso a massimo 2 thread contemporaneamente
 
Threads.@threads for i in 1:5
    Base.acquire(sem)
    println("Thread $i entra nella sezione critica", "\t Threadid: ", Threads.threadid())
    sleep(1)
    println("Thread $i esce dalla sezione critica", "\t Threadid: ", Threads.threadid())
    Base.release(sem)
end

ch = Channel{String}(10)

Threads.@spawn for i in 1:5
    put!(ch, "Messaggio dal thread $i")
end

Threads.@spawn begin
    while isopen(ch)
        println(take!(ch))
    end
end