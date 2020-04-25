function [A,D] = TDCT(F,D, x, y)
    [N,M] = size(F);
    Nrec = size(x,2);
    Mrec = size(y,2);
    A = zeros(Nrec,Mrec);
    

    for jx=1:Nrec
       for ky=1:Mrec
           for j=0:N-1
              for k=0:M-1
                  
                  cj = 1;
                  ck = 1;
                  if j==0
                      cj = 0.5;
                  end
                  if k==0
                      ck =0.5;
                  end                     
                  A(jx,ky) = A(jx,ky) + D(j+1,k+1) * cj * ck * cos(j*x(jx)) * cos (k*y(ky));
                  
              end
           end
       end
    end

    
end


% function c = getC(i)
%     if i == 0 
%         c = 0.5;
%         return
%     else
%         c = 1;   
%         return
%     end   
% end
