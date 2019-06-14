using LinearAlgebra

#Ejercicio 1


function soltrsup(A, b)
    n = length(b)
    x = Array{Float64}(undef, n)

    for i = n:-1:1
        sum = 0
        res = 0
        for j = i+1:n
            sum += A[i,j] * x[j]
        end
        if (A[i,i] == 0)
            return "Error: coeficiente incorrecto"
        end
        res = (b[i] - sum) / A[i,i]
        x[i] = res
    end

    return x
end

function soltrinf(A, b)
    matrixSize = size(A, 2)
    x = Array{Float64}(undef, matrixSize)

    for i = 1:matrixSize
        sum = 0
        for j = 1:(i - 1)
            sum += A[i,j] * x[j]
        end
        currentRes = (b[i] - sum) / A[i,i]
        x[i] = currentRes
    end
    return x
end

#Ejercicio II

function egauss(A, b)
    n = length(b)
    newA = deepcopy(A)
    newb = deepcopy(b)
    if n == 1
        return "error"
    end
    for k = 1 : n - 1
        for i = k+1 : n
            z = (newA[i,k]) / (newA[k,k])
            for j = k : n
                newA[i,j] = (newA[i,j]) - z*(newA[k,j])
            end
            newb[i] = newb[i] - z*(newb[k])
        end
    end
    res = (newA, newb)
    return res
end


function soleg(A, b)
    trsA, vecB = egauss(A, b)
    res = soltrsup(trsA, vecB)
    return res
end

#Ejercicio III

function sollu(A, b)
    factors = lu(A)
    L = factors.L
    U = factors.U
    p = factors.p

    y = soltrinf(L, b[p])
    x = soltrsup(U, y)
    return x
end
