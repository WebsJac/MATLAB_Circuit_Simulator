%Gauss Elimination with Partial Pivoting Code - adapted from course notes
function x = GaussElimPivot(A,b)
A = A;
b = b;
Ab = [A,b]; %concatenate into single matrix

[n, ~] = size(A); %get size of A

for j = 1:n-1 %loop over each column
    [~, cp] = max(abs(Ab(j:n, j))); %find the row with largest abs value
    cp = cp + j -1; %adjust the row index to account for previous iterations

    % swap rows j and cp
    Ab([j cp], :) = Ab([cp j], :);
    
    %perform elimination by getting factor and then doing curr -
    %factor*pivot row

    for i = j+1:n
        factor = Ab(i,j) / Ab(j,j);
        Ab(i,j:end) = Ab(i,j:end) - factor *Ab(j,j:end);
    end 
end 

%solve for x using back-substitution
x = zeros(n,1);
x(n) = Ab(n,n+1)/Ab(n,n); %our b value in last row /A coefficient in last row = x in last row
for i = n-1:-1:1 %b term + iterate through and add previous terms times their coefficient each time
    x(i) = (Ab(i, n+1) - Ab(i,i+1:n) *x(i+1:n))/Ab(i,i);
end
end 
