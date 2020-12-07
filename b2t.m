function [T] = b2t(P)
%Author Π.Καββαδίας, ΑΜ 1054350, Date: 13/01/2020

%P is and mxn matrix.We should find the dimensions
%By finding the index of diagonial and getting the max absolute value 
%we have the number of rows(m) because of the matrix format
 [~,index]=spdiags(P);   
 m=max(abs(index));
 n=length(P)/m;
 T = tensor(P,[m n m n]);
 T=permute(T, [ 1 3 2 4] ) ;
end