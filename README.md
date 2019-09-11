# code_module_LLL

This is the code that was used to produce the experimental results of 
the article ``An LLL Algorithm for Module Lattices''. In repository 'test_norm'
you will find the code used for the experiments of Appendix A.1 and in
repository 'full_heuristic' you will find the code used for the experiments of
Appendix A.2.

In both code, the random seed has been fixed to allow reproducibility of
the results. This can be undone by commenting the corresponding line in
the corresponding files.

Experiments of Appendix A.1
---------------------------
To run this code, one should have Sage installed (http://www.sagemath.org/).

To unfix the random seed, comment the corresponding line in 'shared_functions.sage'


To create the pictures showing p_l as q function of l, go to the repository 
'test_norm' and run in a terminal

       sage different_length_interval.sage

This will save the pictures in .pdf format.


To create the picture showing 1/c as a function of B * delta and the data used to 
create the values in the table, go to the repository 'test_norm' and run

       sage asymptotic_proportionality_factor.sage

This will save the picture in .pdf format and produce the code for the table in 
the terminal.


Experiments of Appendix A.2
----------------------------
To run this code, one should have Sage (http://www.sagemath.org/) and Magma 
(http://magma.maths.usyd.edu.au/magma/) installed.

Go to the repository 'full_heuristic' and run in a terminal

        bash test_heuristic.bash

This should run in roughly 1 day on a regular processor with 8 cores and 2.4GHz 
frequency. The computation time can be reduces to 1 or 2 hours by removing some
of the tests (see the comments in 'test_heuristic.bash').

The above command will create the figures degree_4.pdf, degree_6.pdf and degree_8.pdf
that were used in the article. It also creates a file 'output_heuristic.sage' containing
all the informations that were given in Table 2. More formally, the file 
'output_heuristic.sage' contains 9 lists L5, L8, L12, L7, L9, L18, L15, L16, L24.
Each list Lm contains values corresponding to the cyclotomic number field of conductor m.
Each entry x in Lm corresponds to one choice of r, and is of the form
x = [dimension of L (in our case r+d-1), alpha_0, beta, max_i dist(t_i,L), min 'B in practice', max 'B in practice', sqrt(B)]
