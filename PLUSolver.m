function x = PLUSolver(A,b)
%Get the dimensions of A
persistent AOld;
persistent LOld;
persistent UOld;
persistent POld;
persistent nOld;

if isempty(AOld) || ~isequal(A, AOld) %check if old is same as curr
    n = size(A,1);

    L = eye(n);
    P = eye(n);

    U = A; %initialize U with A

    %Perform partial pivoting and compute L and U
    for k = 1:n-1
        %find pivot row (max abs value)
        [~, i] = max(abs(U(k:n, k)));
        i = i + k - 1;

        U([k i], :) = U([i k], :); %row swap
        P([k i], :) = P([i k], :);
    
        if k > 1 %L swap
            L([k i],1:k-1) = L([i k], 1:k-1);
        end
    
        %compute multipliers and update U and L
        for j = k+1:n
            L(j,k) = U(j,k)/U(k,k);
            U(j, k:n) = U(j, k:n) - L(j,k)*U(k,k:n);
        end
    end
AOld = A; %store curr value as old to check next time
UOld = U;
POld = P;
LOld = L;
nOld = n;
end
%Solve for x with back sub. It should start here if A is same
U = UOld; %reassign these values
L = LOld;
P = POld; 
n = nOld;

d = P*b;
for i = 1:n-1
    for j = i+1:n
        d(j) = d(j) - L(j, i)*d(i);
    end
end
x = zeros(n,1);
x(n) = d(n)/U(n,n);
for i = n-1:-1:1
    x(i) = (d(i) - U(i, i+1:n)*x(i+1:n)/U(i,i));
end
end



