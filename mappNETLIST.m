function [numVolts, A, b] = mappNETLIST (table, f)

max_i = max(table.i);
max_j = max(table.j);
if max_i >= max_j 
    numVolts = max_i;
else
    numVolts = max_j;
end
numNodes = numVolts;
for ii = 1:height(table)
    if startsWith(table.Component{ii}, 'V') %voltage source)
        numNodes = numNodes + 1; %add one for each voltage source
    elseif startsWith(table.Component{ii}, 'L') %inductor
        numNodes = numNodes + 1;
    end
end
A = zeros(numNodes);
b = zeros(numNodes,1);

numInd = numVolts;
for ii = 1:height(table)
    if startsWith(table.Component{ii}, 'I') %currents
        if table.i(ii) == 0 % i is grounded
            b(table.j(ii)) = b(table.j(ii)) + table.Value(ii);
        elseif table.j(ii) == 0 % j is grounded
            b(table.i(ii)) = b(table.i(ii)) - table.Value(ii);
        else
            b(table.i(ii)) = b(table.i(ii)) - table.Value(ii);
            b(table.j(ii)) = b(table.j(ii)) + table.Value(ii);
        end
    elseif startsWith(table.Component{ii}, 'R') %resistors
        if table.j(ii) == 0 %j node of resistor is grounded
            A(table.i(ii), table.i(ii)) = A(table.i(ii), table.i(ii)) + 1/table.Value(ii);
        elseif table.i(ii) == 0
            A(table.j(ii), table.j(ii)) = A(table.j(ii), table.j(ii)) + 1/table.Value(ii);
        else %j node of resistor is not grounded
            A(table.i(ii), table.i(ii)) = A(table.i(ii), table.i(ii)) + 1/table.Value(ii);
            A(table.i(ii), table.j(ii)) = A(table.i(ii), table.j(ii)) - 1/table.Value(ii);
            A(table.j(ii), table.i(ii)) = A(table.j(ii), table.i(ii)) - 1/table.Value(ii);
            A(table.j(ii), table.j(ii)) = A(table.j(ii), table.j(ii)) + 1/table.Value(ii);
        end
    elseif startsWith(table.Component{ii}, 'V') %voltage source
        b(numNodes) = table.Value(ii);
        if table.i(ii) == 0 % i is grounded
            A(numNodes, table.j(ii)) = A(numNodes, table.j(ii)) + 1;
            A(table.j(ii), numNodes) = A(table.j(ii), numNodes) + 1;
        elseif table.j(ii) == 0 %j is grounded
            A(table.i(ii), numNodes) = A(table.i(ii), numNodes) - 1;
            A(numNodes, table.i(ii)) = A(numNodes, table.i(ii)) - 1;
        else 
            A(table.j(ii), numNodes) = A(table.j(ii), numNodes) + 1;
            A(table.i(ii), numNodes) = A(table.i(ii), numNodes) - 1;
            A(numNodes, table.i(ii)) = A(numNodes, table.i(ii)) - 1;
            A(numNodes, table.j(ii)) = A(numNodes, table.j(ii)) + 1;
        end
    elseif startsWith(table.Component{ii}, 'L') %inductor
        numInd = numInd+1;
        if table.i(ii) == 0 % i is grounded
            A(numInd, table.j(ii)) = A(numInd, table.j(ii)) + 1;
            A(table.j(ii), numInd) = A(table.j(ii), numInd) + 1;
            A(numInd, numInd) = A(numInd, numInd) - j*2*pi*f*table.Value(ii);
        elseif table.j(ii) == 0 % j is grounded
            A(numInd, table.i(ii)) = A(numInd, table.i(ii)) - 1;
            A(table.i(ii), numInd) = A(table.i(ii), numInd) - 1;
            A(numInd, numInd) = A(numInd, numInd) - j*2*pi*f*table.Value(ii);
        else
            A(numInd, table.j(ii)) = A(numInd, table.j(ii)) + 1;
            A(numInd, table.i(ii)) = A(numInd, table.i(ii)) - 1;
            A(table.j(ii), numInd) = A(table.j(ii), numInd) + 1;
            A(table.i(ii), numInd) = A(table.i(ii), numInd) - 1;
            A(numInd, numInd) = A(numInd, numInd) - j*2*pi*f*table.Value(ii);
        end
    elseif startsWith(table.Component{ii}, 'C') %capacitor
       if table.i(ii) == 0
           A(table.j(ii), table.j(ii)) = A(table.j(ii), table.j(ii)) + j*2*pi*f*table.Value(ii);
       elseif table.j(ii) == 0
           A(table.i(ii), table.i(ii)) = A(table.i(ii), table.i(ii)) + j*2*pi*f*table.Value(ii);
       else
           A(table.j(ii), table.j(ii)) = A(table.j(ii), table.j(ii)) + j*2*pi*f*table.Value(ii);
           A(table.i(ii), table.i(ii)) = A(table.i(ii), table.i(ii)) + j*2*pi*f*table.Value(ii);
           A(table.i(ii), table.j(ii)) = A(table.i(ii), table.j(ii)) - j*2*pi*f*table.Value(ii);
           A(table.j(ii), table.i(ii)) = A(table.j(ii), table.i(ii)) - j*2*pi*f*table.Value(ii);
       end
    end
end


end %function

