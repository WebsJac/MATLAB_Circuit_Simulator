%frequency response
filename = 'Netlist_L2F2.txt'; %F2 or F3
table = readtable(filename,'Format', '%s%d%d%f');
table.Properties.VariableNames = {'Component','i','j','Value'};
H = zeros(1,10001);

for i = 1:10001
    f = (i-1)*100; %get freq value from index
    [~, A, b] = mappNETLIST(table, f);
    x = GaussElimPivot(A,b);
    Vout = x(2); %vout is x(2) for F2, x(3) for F3
    Vin = x(1);
    H(i) = 20*log10(abs(Vout/Vin));
end
finiteIndices = isfinite(H); %it is screwed up by the -infinity at H(0)
f = 0:100:1000000; %for plotting
semilogx(f, H); %for decade plot
xlabel('Frequency (Hz)');
ylabel('Transfer Function in dB');

threedB = interp1(H(finiteIndices), f(finiteIndices), -3, 'nearest'); %-3dB freq
fprintf('3dB frequency of %s is %.2fHz\n', filename, threedB);
