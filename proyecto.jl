#Ejercicio 1

a = 1 + 2^(-53); b = a-1

c = 1 + 2^(-52); d = c-1

println(b)
println(d)

#Ejercicio 2

a = 2.0; 

while isfinite(a)
     	global a = a*2	   
		println(a) 
		end


c = 2.0;

while c > 0
 	global c = c/2
	println(c)
	end	

#Ejercicio 3

x = 0;

	while x!=10
	global x = x + 0.5 #Ver que pasa si se cambia 0.1 por 0.5, con 0.5 Corta en 10.0
	println(x)         # El 0.1 da muchos problemas en float :C
	end


#Ejercicio 4

x = 6;
a = [5, 4 ,3 ,2 ,1]
i = 1 
    while i < 6
  	    global x = a[i] * x 
		global i = i + 1
		end	
		println(x)


n = 6;
x = 1;
for i=1:n
	global x = i * x 		
	end
	println(x)

function factoria(n)
 	for i=1:n
	global x = i * x 		
	end
	println(x)
end



println("dame un real")
a = readline()
println("dame otro real")
b = readline()

if a > b
  	println(a)
    elseif a < b
   	println(b)
	else
    println("son iguales bro")
end

#Ejercicio 6


function potn(x, n)

res = x^n

end

function first5(x)
n = 1;
	while n <= 5
			x = x^n
			n = n + 1

end

















































