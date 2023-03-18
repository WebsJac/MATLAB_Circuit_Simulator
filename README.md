<h1> MATLAB Circuit Simulator </h1>

<h3> Description </h3>
<p> This is a MATLAB-based circuit simulator developed as part of ELEC372 Numerical Methods and Optimization. It uses a user-provided netlist to simulate voltage sources, current sources, resistors, inductors and capacitors. The simulator uses component stamps to organize values into matrices and solves numerically for their node voltages and currents. Additional functions have been added to perform voltage sweep analysis and frequency response calculations </p>

<h3> Dependencies </h3>
<li> MATLAB must be installed </li>

<h3> File Descriptions </h3>
<li> mappNETLIST.m : this is the file used to map the components in the netlist to their respective places in the A and b matrices using their corresponding stamps </li>
<li> GaussElimPivot.m : functions that solves for x (node voltages and currents) using Gaussian Elimination with partial pivoting. This method performs row operations to arrange the Ab matrix in such a way that it can be solved using back-substitution (solving for one value then using that value to solve for the next and so on) </li>
<li> PLUSolver.m : function that solve for x (node voltages and currents) using PLU decomposition. This method performs row operations to seperate the A matrix into Lower and Upper matrices that can be solved using two iterations of back-substitution. It allows for much quicker computation time when the b matrix is changing (voltage
  sweeps or AC analysis) </li>
<li> solveValues.m : this file employs the mappNETLIST.m, GaussElimPivot.m and PLUSolver.m function to display the node voltages and currents computed using both methods
  at frequencies of 0Hz (DC) and 60Hz </li>
<li> sweepVoltag.m : this file will perform a voltage sweep and plot the magnitude and phase as the voltage changes from -60V to 60V. PLUSolver.m is used since it
  drastically improves runtime </li>
<li> freqResponse.m : this file creates a bode plot of the gain vs. frequency. It also outputs the cutoff frequency (-3dB) </li>
<h3> Usage </h3>
<ol> 
  <li> Open MATLAB and download all provided MATLAB functions </li>
  <li> Create a netlist for the circuit you wish to simulate - an example netlist and it's corresponding circuit have been provided </li>
  <li> Open the function you wish to perform (ie. freq response, solve node values, 
  <li> Change filename in the MATLAB code to your correspond .txt file </li>
  <li> If desired, swap GaussElimPivot(A,b) with PLUSolver(A,b) depending on which method of linear equation solver you wish to use </li>
  <li> Click Run </li>
</ol>

