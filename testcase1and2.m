clear all;
%TODO Achsen scalieren



%%Testcase1
N = 20;
M = 20;
Nreconst = 40;
Mreconst = 40;

Xrec = 1/(2*Nreconst)*pi:2/(2*Nreconst)*pi:(1-1/(2*Nreconst))*pi;
Yrec = 1/(2*Mreconst)*pi:2/(2*Mreconst)*pi:(1-1/(2*Mreconst))*pi;

X = 1/(2*N)*pi:2/(2*N)*pi:(1-1/(2*N))*pi;
Y = 1/(2*M)*pi:2/(2*M)*pi:(1-1/(2*M))*pi;

F = zeros(N,M);

for i=0:N-1
    for j=0:M-1
        F(i+1,j+1)= test1(X(i+1),Y(j+1));
    end
end

subplot(3,3,1);
surf(F);
title('originale Funktion F1'); 


D = DCT(F);
subplot(3,3,2);
% D(D==0) = nan;
surf(D);
title('Gewichte für Funktion F1'); 

A = TDCT(F,D,Xrec,Yrec);
subplot(3,3,3);
surf(A);
title('Rekonstruction Funktion F1'); 



%%Testcase2
P = 10;
P_max = 50;

Preconst = 20;

Xrec = 1/(2*Preconst)*pi:2/(2*Preconst)*pi:(1-1/(2*Preconst))*pi;
Yrec = Xrec;

delta = pi/P;

X = delta:delta:(P)*delta;
Y = X;
F = zeros(P,P);

for i=1:P
    for j=1:P
        F(i,j)= test2(X(i),Y(j));
    end
end

subplot(3,3,4);
surf(F);
title('originale Funktion F2'); 

D = DCT(F);
subplot(3,3,5);
% D(D==0) = nan;
surf(D);
title('Gewichte für Funktion F2'); 

A = TDCT(F,D,Xrec,Yrec);
subplot(3,3,6);
surf(A);
title('Rekonstruction Funktion F2'); 


err = zeros(P_max);


for n=1:5:P_max
    delta = pi/n;

    X = delta:delta:(n)*delta;
    Y = X;
    F = zeros(n,n); 
    A = zeros(n,n);
    for i=1:n
        for j=1:n
            F(i,j)= test2(X(i),Y(j));
        end
    end
    D = DCT(F); 
    A = TDCT(F,D,X,Y);
    
    %Fehler bestimmen
    
    err(n) = max(max(abs(A-F)));    
    
end
subplot(3,3,7);
err(err==0) = nan;
plot(err,'o');
title('Maximaler Fehler für N Punkte F2'); 


function z = test1(x,y)
    z = cos(2*x) + cos(3*y);
end

function z = test2(x,y)
    z = (x- pi/2)^2 + (y- pi/2)^2;
end
