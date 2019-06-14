using Plots

function intenumcomp(fun, a, b, N, regla)
    if regla == "trapecio"
        mtrapecio(fun, a, b, N)
    elseif regla == "simpson"
        msimpson(fun, a, b, N)
    elseif regla == "pm"
        mpunto_medio(fun, a, b, N)
    else;
        println("error: regla ", regla, " no implementada")
    end
end

function mtrapecio(fun, a, b, N)
    h = (b - a) / N
    main_slope = ((fun(a) + fun(b)) / 2)
    sum = 0
    for k = 1:(N - 1)
        sum += fun(a + k * h)
    end
    res = h * (main_slope + sum)
end

function msimpson(fun, a, b, N)
    if N % 2 == 1
        return ("error: N tiene que ser par")
    end
    h = (b - a) / N
    even_sum = 0
    odd_sum = 0
    for j = 1:((N / 2) - 1)
        even_sum += fun(a + (2 * j) * h)
    end
    for j = 1:(N / 2)
        odd_sum += fun(a + (2 * j - 1) * h)
    end
    res = (h / 3) * (fun(a) + 2 * even_sum + 4 * odd_sum + fun(b))
    return res
end

function mpunto_medio(fun, a, b, N)
    h = (b - a) / N
    sum = 0
    for j = 1:N
        xj_minus_one = (a + (j - 1) * h)
        xj = (a + j * h)
        sum += fun((xj_minus_one + xj) / 2)
    end
    res = h * sum
    return res
end

#Ejercicio 2

function error_ej2(N, regla)
    h = 1 / N
    if regla == "trapecio"
        error_trapecio_ej2(h)
    elseif regla == "simpson"
        error_simpson_ej2(h)
    elseif regla == "pm"
        error_punto_medio_ej2(h)
    else;
        println("error: regla ", regla, " no implementada")
    end
end

function error_trapecio_ej2(h)
    res = (1 / 12) * (h^2)
    return res
end

function error_simpson_ej2(h)
    res = (h^4) / 180
    return res
end

function error_punto_medio_ej2(h)
    res = (1 / 24) * (h^2)
    return res
end

#Ejercicio 3

function senint(x)
    N = ceil(x / 0.1)
    res = intenumcomp(x->cos(x), 0, x, N, "trapecio")
    return res
end

function plot_ej3()
    x = 0:0.5:(2 * pi)
    p1 = plot(x, sin, label = "sin(x)")
    p2 = plot(x, senint, label = "senint(x)")
    plot(p1, p2, layout = (2, 1))
end

#Ejercicio 4

function error_trapecio(M2, a, b, h)
    res = abs((M2 / 12) * (b - a) * (h^2))
    return res
end

function error_simpson(M4, a, b, h)
    res = abs((((b - a) * (h^4)) / 180) * M4)
    return res
end

function ej4(fun, M2, M4, a, b)
    N = 0
    current_error = 0
    aux = true
    while aux == true
        N += 2
        h = 1 / N
        current_trap_error = error_trapecio(M2, 0, 1, h)
        current_simpson_error = error_simpson(M4, 0, 1, h)
        current_error = max(current_trap_error, current_simpson_error)
        aux = current_error > (10^(-5))
    end

    res_trapecio = mtrapecio(fun, 0, 1, N)
    res_simpson = msimpson(fun, 0, 1, N)
    println("Con N = ", N, ":")
    println("   Con trapecio:   ", res_trapecio)
    println("   Con Simpson:    ", res_simpson)
end
