filename = 'Netlist_L2F1.txt';
%Print results for 0Hz Frequency
f = 0;
table = readtable(filename,'Format', '%s%d%d%f');
table.Properties.VariableNames = {'Component','i','j','Value'};
[~, A, b] = mappNETLIST(table, f);
fprintf('At frequency 0Hz,\n');
count = length(b);
fprintf('Using Gauss Elimination\n');
xg = GaussElimPivot(A,b);
xp = PLUSolver(A,b);
for i = 1:count
    mag = abs(xg(i));
    phase = angle(xg(i));
    fprintf('x%d = %.4f < %.4fdeg\n', i, mag, phase*180/pi);
end
fprintf('Using PLU Decomposition\n');
for i = 1:count

    mag = abs(xp(i));
    phase = angle(xp(i));
    fprintf('x%d = %.4f < %.4fdeg\n', i, mag, phase*180/pi);
end
%Print results for 60Hz Frequency
f = 60;
[~, A, b] = mappNETLIST(table,f);
xg = GaussElimPivot(A,b);
xp = PLUSolver(A,b);
fprintf('At frequency 60Hz,\n');
count = length(b);
fprintf('Using Gauss Elimination\n');
for i = 1:count
    mag = abs(xg(i));
    phase = angle(xg(i));
    fprintf('x%d = %.4f < %.4fdeg\n', i, mag, phase*180/pi);
end
fprintf('Using PLU Decomposition\n');
for i = 1:count
    mag = abs(xp(i));
    phase = angle(xp(i));
    fprintf('x%d = %.4f < %.4fdeg\n', i, mag, phase*180/pi);
end




