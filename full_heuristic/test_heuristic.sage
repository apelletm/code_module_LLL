#############################################################
## This code load the matrix computed by the magma code and
## compute the distance of our specific target vectors to
## the lattice for 90 randomly chosen targets (of the
## desired shape)
#############################################################

## Load the matrix
load("tmp_input_heuristic.sage")

import fpylll
import subprocess
import multiprocessing


## Fixing the seed for reproductibility of results
set_random_seed(17);

## Define the number of threads for parallelization.
## For reproducibility of results, we fix nb_threads to 7
## For better performances, you may want to use all
## cores available on your machine (minus 1)
## (uncomment the second line for that)
nb_threads = 7
# nb_threads = multiprocessing.cpu_count()-1

precision = 2^31;
## Create the matrix of the lattice and reduce it
## (to reduce the time complexity of the multiple cvp calls)
B_init = Matrix(ZZ,[[Integer(floor(precision*x)) for x in row] for row in list_L]);
B_L = B_init.BKZ(block_size = B_init.nrows())


## CVP solver
def call_fplll(M, v):
        temp = fpylll.IntegerMatrix(M.nrows(),M.transpose().nrows())
        for i in range(M.nrows()):
                for j in range(M.transpose().nrows()):
                        temp[i,j]=M[i,j]
        return fpylll.fplll.svpcvp.CVP.closest_vector(temp,v)


## Generate a target vector of the desired shape (whith small w component)
## and in the span of L
def target_generate(M):
        total_norm = 0 ## should be 0 for the vector to be in Span(L)
        target_vector = vector(RR, M.ncols())
        ## generate the last r coordinates small enough
        for i in range(r):
                target_vector[r1+r2+d+r0+i]=(RR.random_element(0,1))/100*B/r
                total_norm += target_vector[r1+r2+d+r0+i] * log_norm[r0+i]
        for i in range(r0):
                target_vector[r1+r2+d+i]=(RR.random_element(0,d^3)) ## this bound should be much larger than the coefficients of the matrix
                total_norm += target_vector[r1+r2+d+i] * log_norm[i]
        for i in range(r1+r2):
                target_vector[i]=(RR.random_element(-3.14,3.14))
        if r2 != 0:
                for i in range(r1):
                        target_vector[r1+r2+i]=(RR.random_element(0,d^3)) ## this bound should be much larger than the coefficients of the matrix
                        total_norm -= target_vector[r1+r2+i]/beta
                for i in range(r2-1):
                        target_vector[2*r1+r2+i]=(RR.random_element(0,d^3)) ## this bound should be much larger than the coefficients of the matrix
                        target_vector[2*r1+2*r2+i] = target_vector[2*r1+r2+i]
                        total_norm -= 2*target_vector[2*r1+r2+i]/beta
                target_vector[2*r1+2*r2-1] = beta*total_norm/2
                target_vector[2*r1+3*r2-1] = beta*total_norm/2
        else:
                for i in range(r1-1):
                        target_vector[r1+r2+i]=(RR.random_element(0,d^3)) ## this bound should be much larger than the coefficients of the matrix
                        total_norm -= target_vector[r1+r2+i]/beta
                target_vector[2*r1-1] = beta*total_norm
        return vector(ZZ,[Integer(floor(precision*x)) for x in target_vector])

## Compute an approximation of the distance of vectors of a specific form to the lattice,
## by taking nb_tests random targets sampled using target_generate
## (everything is multiplied by the precision to work with integers)
## and computing a closest vector.
## The output distance is the max of the distance obtained for the different targets
## At the same time, we also compute the number of ideals needed to create this closest
## vectors, i.e., the l_1 norm of the last r coordinates of the closest vector.
## Output an interval containing all these numbers for all the target vectors tested.

@parallel(nb_threads)
def approx_covering_radius(B_L,nb_tests, seed_randomness):
   temp_vec = vector(ZZ,B_L.transpose().nrows())
   set_random_seed(seed_randomness); ## change the randomness for the different processes
   max_dist = 0
   max_nb_ideals = 0
   min_nb_ideals = r
   for test in range(nb_tests):
      t = target_generate(B_init)
      v = call_fplll(B_L,t)
      for j in range(B_L.ncols()):
          temp_vec[j]= v[j]-t[j]
      max_dist = max(max_dist,RR((temp_vec).norm(2)/precision))
      max_nb_ideals = max(max_nb_ideals,sum([abs(v[len(v)-1-i]/precision) for i in range(r)]))
      min_nb_ideals = min(min_nb_ideals,sum([abs(v[len(v)-1-i]/precision) for i in range(r)]))
   return (max_dist, max_nb_ideals, min_nb_ideals)

## Change here the value of iteration if you want to perform more tests
## Or change the value 3 in `approx_covering_radius(B_L,3,17+j)' below
iteration=30
list_max_dist = [0]*iteration
for j in range(iteration):
    list_max_dist[j]=approx_covering_radius(B_L,3,17+j)


max_dist = max([x[0] for x in list_max_dist])
max_nb_ideals = max([x[1] for x in list_max_dist])
min_nb_ideals = min([x[2] for x in list_max_dist])




RRout = RealField(13)
print "[", B_L.nrows(), ", ", RRout(alpha), ", ", RRout(beta), ", ", RRout(max_dist), ", ", RRout(min_nb_ideals), ", ", RRout(max_nb_ideals), ", ", RRout(sqrt(B)), "],"

