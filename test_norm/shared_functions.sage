#########################################################
## This file contains codes of functions that
## will be used in both 'different_length_interval.sage'
## and 'asymptotic_proportionality_factor.Sage'
## It also fix the random seed, for reproducibility
## of the results
#########################################################


## Fixing the seed for reproductibility of results
## Comment this line to stop fixing it
set_random_seed(12);

from numpy import arange

###############################################
## Useful functions
###############################################

def x_vec(r,B):

    ## Generates the x_i's: vector of length r with B 
    ## entries equal to +/- 1 (rest is 0).

    x = [0]*r
    cont = B
    while cont > 0:
        i = randint(0,len(x)-1)
        if x[i]==0:
            x[i] = (-1)^randint(0,1)
            cont -=1
    return x

def Gen_Primes(K, BOUND):

    ## Returns the list of all prime ideals of the number 
    ## field K that have norms bounded by BOUND

    LIST_PRIMES = []
    p=1
 
    print "Generating primes..."
    while p < BOUND:
        p = p.next_prime()
        pR = ideal(K(p))
        pR_fact = pR.factor()
        
        for I in pR_fact:
            if I[0].norm() < BOUND:
                LIST_PRIMES += [I[0]]
    return LIST_PRIMES
    

def proportional_interval(list_alpha,LOG_B0,B,r,bt,nb_tests):

   ## Compute the probability to find an element at distance
   ## alpha from bt, for different values of alpha.
   ## The probability is empirically computed over nb_tests
   ## randomly sampled elements, and the probability for
   ## all alphas is computed with the same set of sampled elements

   res = [0]*len(list_alpha)
   for _ in range(nb_tests):
      w = x_vec(r, B)
      Sum_real = RR(sum( [ w[i]*LOG_B0[i] for i in xrange(r) ] ) )
      for i in xrange(len(list_alpha)):
         alpha = list_alpha[i]
         if abs(Sum_real-bt) < alpha:
            res[i] += 1
   return [(list_alpha[i],RR(res[i]/nb_tests)) for i in xrange(len(list_alpha))]




