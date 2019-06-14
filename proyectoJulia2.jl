
#fun es una función que dado x retorna f (x)
#I = [a, b] es un intervalo en R
#err es la tolerancia deseada del error
#mit es el número máximo de iteraciones permitidas


function fun_lab2ej2a(x)
		x = tan(x)-(2*x)
		return(x)

end

#function graficar(matriz)
#    plotly() # Choose the Plotly.jl backend for web interactivity
#    plot(matriz[1],matriz[2],seriestype = :scatter)
#end

#raiz real -0,325
#raiz real 0,325

function rbisec(fun,(a,b),err,mit)

	u = fun(a)
	v = fun(b)
	mid = b - a
	#println(a, b, u, v)

	if sign(u) == sign(v)
		println("no hay raiz")
	end
		for k = 1:mit
			mid = mid/2
			c = a + mid
			w = fun(c)
			println("iteraciones:",k,",aprox:" ,c,",f(c)=" ,w,",punto medio:" ,mid)
			if (abs(mid) < err || abs(w) < err)
				return(c," es una aproximacion a mi raiz")
			end
			if sign(w) != sign(u)
				b = c
				v = w
			 else
				a = c
				u = w
			end
	    end
end



function rnewton(fun,x0,err,mit)
		(a,b) = fun(x0)
		hx = []
		hf = []

		if (abs(a) < err)
		 return (hx,hf)
		end
		for k = 1:mit
			x1 = x0 - (a/b)
			(a,b) = fun(x1)
			push!(hx,x1)
			push!(hf,a)
			r = x0 - x1
			if (abs(r) < err || abs(a) < err)
				println(x1)
				println("se hicieron ", k, " iteraciones")
				return (hx,hf)
			end
			x0 = x1
		end
		#println("no hay aproximacion a la raiz")
		println("se terminaron las iteraciones")
		println(x0," es una aprox del punto fijo")
end

global d = 8

function fun_lab2ej4a(d)
	if (d>0)
		fun(x) = (x^3- d,3*(x^2))
		r = rnewton(fun,d, 10e-6,100)
       	return (r)
    end

end

function ripf(fun, x0, err, mit)
	xh = []
	for k=1:mit
		y = fun(x0)
		push!(xh, y)
		if ((abs(x0 - y)) < err)
			println(y," es una aprox del punto fijo")
			return xh
		end
		x0 = y
    end
	println("se terminaron las iteraciones")
	#println(x0," es una aprox del punto fijo")
end

function fun_lab2ej6(x)
	return(2^(x-1))
end

function tester(x0,mit)
    for i = 0:mit
        if (ripf(fun_lab2ej6, x0+(i/10), 1e-5, 100) == -1)
            println("Diverge en ", x0+(i/10))
        else;
            println("Converge en ", x0+(i/10))
        end
    end
end
function parcialab(x)
	return (exp(-x^2)-0.9)
end

global N = 3

function escalonN(x)
	v = LinRange(0,1,N)
	if (x>=1 || x<=0)
		return ("la x no es valida")
	end
	for i=1:N-1
		if ((x >= v[i]) && (x < v[i+1]))
			return (parcialab(v[i]))
	    end
	end

end

global eN = 1000

function minimoN(x)
	res = rbisec(parcialab,(0,0.9),1e-10,20)
		for i=10:eN
			res2 = rbisec(escalonN,(0,0.9),1e-300,10)
				if (abs(res)-abs(res2)) <= 0.0001
				 return res2
		    end
		end

end
