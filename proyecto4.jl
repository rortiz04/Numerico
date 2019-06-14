using DelimitedFiles
using Plots
using Polynomials

function getData1a()
    datos_1a = readdlm("datos1a.dat", '\t', Float64)
    x = view(datos_1a, :, 1)
    y = view(datos_1a, :, 2)
    return (x, y)
end

function build_ej1a()
    (x, y) = getData1a()
    data_count = size(x, 1)

    sum_xi_squared = 0
    sum_xi = 0
    sum_yi = 0
    sum_xi_yi = 0


    for i = 1:data_count
        sum_xi_squared += (x[i])^2
        sum_xi += x[i]
        sum_yi += y[i]
        sum_xi_yi += x[i] * y[i]
    end

    den = data_count * sum_xi_squared - (sum_xi)^2

    a0 = (sum_xi_squared * sum_yi - sum_xi_yi * sum_xi) / den

    a1 = (data_count * sum_xi_yi - sum_xi * sum_yi) / den

    return (a1, a0)
end

function fun_ej1a(x)
    (a1, a0) = build_ej1a()
    return (a1 * x + a0)
end

function plot_ej1a()
    dots = getData1a()

    x = LinRange(0, 5, 100)
    y1 = []
    for i = 1:size(x, 1)
        push!(y1, fun_ej1a(x[i]))
    end
    p = plot(x, y1, 0:5)
    plot!(p, dots, line = :scatter)
end

#Ejercicio 1b

function fun_ej1b(x)
    return((3 * x / 4) - (1 / 2))

end

function ej1b()
    x = LinRange(0, 10, 20)
    y = []
    real_func = []
    for i = 1:20
        push!(y, fun_ej1b(x[i] + randn()))
        push!(real_func, fun_ej1b(x[i]))
    end

    poly_fit_evals = build_poly_ej1b(x, y)
    plot(x, y, line = :scatter, label = "Data Points")
    plot!(x, real_func, label = "Real Function")
    plot!(x, poly_fit_evals, label = "Best Polynomial Fit")
end

function build_poly_ej1b(x, y)
    p = polyfit(x, y, 1)
    p_evals = []
    for i = 1:20
        push!(p_evals, polyval(p, x[i]))
    end
    return p_evals
end


#Ejercicio 2

#Ejercicio 2a
function fun2a(x)
    return asin(x)
end

function ej2a()
    x = LinRange(0, 1, 50)
    y = []
    for i = 1:size(x, 1)
        push!(y, fun2a(x[i]))
    end
    polys = build_poly_ej2a(x, y)
    plot(x, y, line = :scatter)
    plot!(x, polys)
end

function build_poly_ej2a(x, y)
    p_evals = []
    p = []
    for n = 1:5
        push!(p, (polyfit(x, y, n)))
        push!(p_evals, [])
        for i = 1:size(x, 1)
            push!(p_evals[n], polyval(p[n], x[i]))
        end
    end
    return p_evals
end

#Ejercicio 2b
function fun2b(x)
    return cos(x)
end

function ej2b()
    x = LinRange(-1, 2*pi, 50)
    y = []
    for i = 1:size(x, 1)
        push!(y, fun2b(x[i]))
    end
    polys = build_poly_ej2b(x, y)
    plot(x, y, line = :scatter, label = "Puntos")
    # for i=1:20
    #     plot!(p, x, polys[i], label = "Grado $i")

    # end
    plot!(x, polys[1], label = "Grado 1")
    plot!(x, polys[2], label = "Grado 2")
    plot!(x, polys[3], label = "Grado 3")
    plot!(x, polys[4], label = "Grado 4")
    plot!(x, polys[5], label = "Grado 5")
    # display(p)
end

function build_poly_ej2b(x, y)
    p_evals = []
    p = []
    for n = 1:20
        push!(p, (polyfit(x, y, n)))
        push!(p_evals, [])
        for i = 1:size(x, 1)
            push!(p_evals[n], polyval(p[n], x[i]))
        end
    end
    return p_evals
end


#Ejercicio 3

#Ejercicio 3a

function getData3a()
    datos_1a = readdlm("datos3a.dat", '\t', Float64)
    x = view(datos_1a, :, 1)
    y = view(datos_1a, :, 2)
    return (x, y)
end

function build_ej3a(x, y)
    data_count = size(x, 1)

    sum_xi_squared = 0
    sum_xi = 0
    sum_yi = 0
    sum_xi_yi = 0


    for i = 1:data_count
        sum_xi_squared += (x[i])^2
        sum_xi += x[i]
        sum_yi += y[i]
        sum_xi_yi += x[i] * y[i]
    end

    den = data_count * sum_xi_squared - (sum_xi)^2

    a0 = (sum_xi_squared * sum_yi - sum_xi_yi * sum_xi) / den

    a1 = (data_count * sum_xi_yi - sum_xi * sum_yi) / den

    return (a1, a0)
end

function ej3a()
    (x, y) = getData3a()
    ln_y = []
    ln_x = []
    for i = 1:size(x, 1)
        push!(ln_y, log(y[i]))
        push!(ln_x, log(x[i]))
    end
    (a1, a0) = build_ej3a(ln_x, ln_y)

    new_a0 = exp(a0)

    function new_function(x)
        return(new_a0 * x^(a1))
    end

    plot(x, y, line = :scatter, label= "Data Points")
    plot!(x, new_function, label="New Function")
end

#Ejercicio 3b

function getData3b()
    datos_1a = readdlm("datos3b.dat", '\t', Float64)
    x = view(datos_1a, :, 1)
    y = view(datos_1a, :, 2)
    return (x, y)
end

function build_ej3b(x, y)
    data_count = size(x, 1)

    sum_xi_squared = 0
    sum_xi = 0
    sum_yi = 0
    sum_xi_yi = 0


    for i = 1:data_count
        sum_xi_squared += (x[i])^2
        sum_xi += x[i]
        sum_yi += y[i]
        sum_xi_yi += x[i] * y[i]
    end

    den = data_count * sum_xi_squared - (sum_xi)^2

    a0 = (sum_xi_squared * sum_yi - sum_xi_yi * sum_xi) / den

    a1 = (data_count * sum_xi_yi - sum_xi * sum_yi) / den

    return (a1, a0)
end

function ej3b()
    (x, y) = getData3b()
    inv_y = []
    inv_x = []
    for i = 1:size(x, 1)
        push!(inv_y, (y[i])^(-1))
        push!(inv_x, (x[i])^(-1))
    end
    (B, A) = build_ej3b(inv_x, inv_y)

    function new_function(x)
        return(x/(A*x + B))
    end

    plot(inv_x, inv_y, line = :scatter, label= "Data Points")

    plot(x, y, line = :scatter, label= "Data Points")
    plot!(new_function, 1e-15, 20, label="New Function")
end

# deleted point (1e-15	-0.0047758295152009)
