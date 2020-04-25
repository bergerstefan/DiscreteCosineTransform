function [D] = DCT(F)

    [N,M] = size(F);
    D = zeros(N,M);
    X = zeros(N);
    Y = zeros(M);

    X = 1/(2*N)*pi:2/(2*N)*pi:(1-1/(2*N))*pi;
    Y = 1/(2*M)*pi:2/(2*M)*pi:(1-1/(2*M))*pi;
    
    for j=0:N-1
        for k=0:M-1
            D(j+1,k+1) = 4/(N*M) * summation(F,j,k,N,M,X,Y);
        end
    end
    
end

function x = summation(F,j,k,N,M,X,Y)
    x=0;
    for jj=0:N-1
        for kk=0:M-1
            x = x + F(jj+1,kk+1)*cos(j*X(jj+1))*cos(k*Y(kk+1));
        end
    end
end



