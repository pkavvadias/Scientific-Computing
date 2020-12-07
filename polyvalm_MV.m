function [pAc] = polyvalm_MV(p,A,b)
%Author Π.Καββαδίας, ΑΜ 1054350, Date: 5/01/2020

np = length(p);
for i = 1:np
A=A * (A *(A*(A*p(i)*b)));
end
pAc=A;