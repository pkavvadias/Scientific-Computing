function [dflag ,discrC,discrR]=dd_check(A)
%Author Π.Καββαδίας, ΑΜ 1054350, Date: 26/12/2019

len = length(A);
discrC = 0;
discrR = 0; 
rdflag = 0;
cdflag = 0;
for i = 1:len
    sumRows = 0;
    for j = 1:len
        sumRows = sumRows + abs(A(i,j));
    end
    sumRows = sumRows - abs(A(i,i));
    if abs(A(i,i))>= sumRows
        rdflag = 1;
        discrR = max(min(abs(A(i,i)) - sumRows),discrR);
    else
        rdflag = 0;
        discrR = 0;
        break
    end        
end

for j = 1:len    
    sumColumns = 0;
    for i = 1:len
        sumColumns = sumColumns + abs(A(i,j));
    end
    sumColumns = sumColumns - abs(A(j,j));
    if abs(A(j,j))>= sumColumns
        cdflag = 1;
        discrC = max(min(abs(A(j,j)) - sumColumns),discrC);
    else
        cdflag = 0;
        discrC = 0;
        break
    end        
end

if rdflag || cdflag
    dflag = 1;
else
    dflag = 0;
end