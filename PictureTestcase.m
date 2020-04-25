clear all;


RGB = imread('peppers.png');
F = 255.*im2double(rgb2gray(RGB));
subplot(2,2,1);
imshow(F,'DisplayRange',[])
title('Original Bild');

[N,M] = size(F);

[A,D,Dneu] = JPG(F);
subplot(2,2,3);
contour(D);
title('Original Gewichte (contour Plot)'); 

subplot(2,2,4);
contour(Dneu);
title('Optimierte Gewichte (contour Plot)'); 

subplot(2,2,2);
imshow(A,'DisplayRange',[]);
title('Transformiertes Bild'); 



function [A,D,Dneu] = JPG(F)
    [N,M] = size(F);
    A = zeros(N,M);
    D = zeros(N,M);
    Dneu = zeros(N,M);

    sigma = loadSigma();
   

    for j=1:8:N
        for k=1:8:M
            D(j:7+j,k:7+k) = DCT(F(j:7+j,k:7+k));
        end
    end
    
    for j=0:N-1
        for k=0:M-1
            Dneu(j+1,k+1) = round(D(j+1,k+1)/sigma(1+mod(j,8),1+mod(k,8)));
        end
    end
    
    X=1:1:8;
    Y=1:1:8;
    for j=1:8:N
        for k=1:8:M
            [A(j:7+j,k:7+k)]= TDCT(F(j:7+j,k:7+k),Dneu(j:7+j,k:7+k),X,Y);
        end
    end
    
    
    Dneu(Dneu==0) = nan;

end

function sigma = loadSigma()
    sigma = [10 15 25 37 51 66 82 100;
            15 19 28 39 52 67 83 101;
            25 28 35 45 58 72 88 105;
            37 39 45 54 66 79 94 111;
            51 52 58 66 76 89 103 119;
            66 67 72 79 89 101 114 130;
            82 83 88 94 103 114 127 142;
            100 101 105 111 119 130 142 156];
end
