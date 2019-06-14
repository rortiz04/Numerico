using Plots


function lk(arreglo,k,z)
    res = 1
    for i=1:(size(arreglo,1))
        if (i != k)
            res = ((z-arreglo[i])/(arreglo[k]-arreglo[i])) * res
        end

    end
    return res
end

function ilagrange(x,y,z)
    polinomio = 0
    for i=1:(size(y,1))
        polinomio = y[i] * lk(x,i,z) + polinomio
    end
    return polinomio
end

function difdiv(x,y)
    n = size(y, 1)
    res = Array{Any}(undef,n)
    for i=1:n
        res[i] = y[i]
    end
    for j=1:n
        for k = n:-1:(j+1)
        res[k] = (res[k] - res[k-1]) / (x[k] - x[k-j])
        end
    end
    return res
end

function qi(x,i,z)
    if i > size(x, 1)
        return error
    end
    res = 1
    for j=1:i
       res = res * (z - x[j])
    end
    return res
end

function inewton(x, y, z)
    if size(y, 1) != size(x, 1)
        return error
    end
    coefs = difdiv(x, y)
    res = []
    for i=1:size(z, 1)
        aux = coefs[1]
        for j=2:size(x, 1)
            aux = aux + coefs[j] * qi(x, j-1, z[i])
        end
        push!(res, aux)
    end
    return res
end

function ej3(x)
    return (1/x)

end

function ej3arg()
    x = []
    y = []
    z = []
    for i=1: 5
        push!(x,i)
        push!(y, ej3(i))
    end
    for j=1: 101
        push!(z, (24/25 + j/25))
    end
    return (x,y,z)
end

function ej3plot()
    (x,y,z) = ej3arg()
    p = plot(inewton(x,y,z))

end

function ej4(x)
    return (1/(1+25*(x)^2))
end

function ej4arg(n)
    x = []
    y = []
    z = []
    for i=1: n+1
        xi = (2*(i-1))/n -1
        push!(x, xi)
        push!(y, ej4(xi))
    end
    for j=1: 201
        push!(z, (-101/100 + j/100))
    end
    return (x,y,z)
end

function ej4plot()
    a = []
    for i=1:15
        (x,y,z) = ej4arg(i)
        p = plot(inewton(x,y,z))
        push!(a, p)
    end
    plot(a[1], a[2], a[3], a[4], a[5], a[6], a[7], a[8], a[9], a[10], a[11], a[12], a[13], a[14], a[15])
end
