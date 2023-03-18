%Sweep Vs - errors here
mag = zeros(size(-60:0.01:60));
phase= zeros(size(-60:0.01:60));

filename = 'Netlist_L2F1.txt';
f = 60;
table = readtable(filename,'Format', '%s%d%d%f');
table.Properties.VariableNames = {'Component','i','j','Value'};
Vsource = -60:0.01:60;
tStart = cputime;
[~, A, b] = mappNETLIST(table, f);
for i = 1:length(Vsource)
    b(end) = Vsource(i);
    x = PLUSolver(A,b); %adjust PLUSolver so that if A matrix is unchanged, we skip right to back sub
    mag(i) = abs(x(3));
    phase(i) = angle(x(3))*180/pi;
end
tEnd = cputime - tStart;
fprintf('Runtime for PLUSolver is %.3f\n',tEnd);
%Plot these values
yyaxis left;
plot(Vsource,mag);
ylabel('Magnitude');
hold on;
yyaxis right;
plot(Vsource, phase);
ylabel('Phase (in deg)');
xlabel('Vsource');
hold off;


