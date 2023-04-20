%Programa que calcula el vector gradiente de una funcion
%El vector gradiente es el vector formado por las derivadas paciales
clc;
clear;

%Ingresar la funcion a evaluar
fprintf('Ingrese la función f\nUse (x(1),x(2),...,x(n)) como variables\n\nf(x_n) = ');
ftemp = input('','s');

%Transforma la funcion de un string a una funcion
%Hace que exista una funcion f
eval(sprintf('f = @(x) %s;',ftemp))

h = 0.1;

%Obtener el numero de variables de la funcion
    %Convertir la funcion a un string
f1 = func2str(f);
    %Extraer cada valor/variable
st = extractBetween(f1,'(',')');
    %Borra la primera letra. El primer parentesis es x por @(x)
st(1) = [];
    %Convierte los strings en numeros
st = str2double(st);
    %Obtener el maximo de los numeros, para ver cuantas variables son
n = max(st);


%Vector de los puntos iniciales
values_temp = input('Ingresa el vector x0\n');


%Crear una "caja" para guardar los valores iniciales
values = [];


%Los valores iniciales deben coincidir en cantidad con el numero de var
if length(values_temp)>n
    for i = 1:n
        %Recortar el vector de valores
        %Llenar solo el siguiente espacio
        values = [values, values_temp(i)];
    end
elseif length(values_temp)<n
    %Darle valor a los valores
    values = values_temp;
    for i = 1:n -length(values_temp)
        %Llenar el resto de los espacios con 0
        values = [values,0];
    end
else
    %Los valores a evaluar son los valores ingresados
    values = values_temp;
end


%Crear matrices de suma y resta (f(x0+-h))
vectors1 = [];
vectors2 = [];

for i = 1:n
    %Calcular el valor inicial dado + h
    val_temp1 = values(i) + h;
    %Calcular el valor inicial dado - h
    val_temp2 = values(i) - h;
    %Para no perder el valor del vector inicial con cada loop
    temp1 = values;
    temp2 = values;
    %El valor en la posicion i es el valor de x0+-h
    temp1(i) = val_temp1;
    temp2(i) = val_temp2;
    %Vector de los valores cuando es +h
    %Mantener lo que tenia en vectors1 y agregar la sgte fila
    vectors1 = [vectors1;temp1];
    %Vector de los valores cuando es -h
    vectors2 = [vectors2;temp2];
end

%Crear el vector gradiente
grad = [];

for i = 1:n
    %Calcular las parciales para la posicion respectiva
    % :  Hace que se mantengan las siguientes posiciones
    t = (f(vectors1(i,:))-f(vectors2(i,:)))/(2*h);
    %El vector gradiente es el vector gradiente y agregarle t en la sgt pos
    grad = [grad,t];
end

%Imprimir funcion
fprintf('\nEl vector gradiente de la función:\nf(x_n)=%s\nes:\n',ftemp);
%Imprimir el vector gradiente
disp(grad);


