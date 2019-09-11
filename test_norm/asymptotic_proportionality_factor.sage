############################################
## This file contains code to test the
## asymptotic behavior of the proportinality
## factor c.
## Changing plot_points to True in compute_slopes
## will print p_l as a function of l for each 
## number fiels tested.
## It runs in roughly 45 minutes on a
## personal laptop
############################################

load("shared_functions.sage")

############################################
## Parameters
############################################

list_alpha = list(arange(0.1,1.1,0.1))
var('a,b,c')
model_linear(x) = a*x
model_affine(x) = a*x+b

############################################
## Compute the slope for cyclotomic fields
## of increasing degrees
############################################

def compute_slopes(list_conductors, nb_points, list_alpha, plot_points = False):
   ## compute the value of c for cyclotomic fields of conductors in list_conductors
   ## nb_points is the number of sampled used to compute the empirical probaility p_l
   ## list_alpha contains the values of l used to compute the slope
   ## if plot_points = True, then creates a file for each number fiels with the values
   ## pl as a function of l (so that one can check that this is indeed linear)
   res = []
   for m in list_conductors:
      
      #generate the number fields and the ideals
      K = CyclotomicField(m)
      d = K.degree()
      B = d
      delta = RR(log(d^2*log(d^2),2))
      bt = RR.random_element(-delta,delta)
      print "Starting cyclotomic of degree d = ", d
      B0 = Gen_Primes(K, 2^delta)
      LOG_B0 = [RR(log(I.norm(),2)) for I in B0]
      r = len(B0)

      #compute the points and the slope
      print "computing the slope..."
      list_points = proportional_interval(list_alpha,LOG_B0,B,r,bt,nb_points)
      fit = find_fit(list_points, model_linear, solution_dict = True)
      res += [(d,B*delta,fit[a],m)]

      #print the graphes of the slopes if plot_points = True
      if plot_points == True:
         graph = Graphics()
         for pt in list_points:
            graph += point(pt)
         graph += line([(0,0),(1,fit[a]*1)], color = 'gray')
         g_pdf = graph.plot();
         g_pdf.save('cyclo_'+str(d)+'_'+str(m)+'.pdf');

   return res

############ Compute c for different cyclotomic fields of increasing degree #########################
### changing plot_points to True will print p_l as a function of l for each number fiels tested

res = compute_slopes([16,32,44,35,64,57,100,69,65,81,87,99,128,67,71],10000,list_alpha, plot_points = True)
pts_to_plot = [(x[1],1/x[2]) for x in res]
fit = find_fit(pts_to_plot, model_affine, solution_dict = True)

####### Plot the inverse of the slope as a function of B*delta ##########
graph = Graphics()
for pt in pts_to_plot:
   graph += point(pt, size = 40)
graph += line([(0,fit[b]),(pts_to_plot[-1][0],fit[b]+fit[a]*pts_to_plot[-1][0])], color = 'gray')
graph.fontsize(20)
g_pdf = graph.plot();
g_pdf.save('inserve_slope_as_function_B_delta.pdf');

######### Print the data used for the table ############
print "\\hline  \n$n$ ",
for x in res:
   print  "&", x[0],
print "\\\\ \n\\hline"
print "$m$ ",
for x in res:
   print "&", x[3],
print "\\\\ \n\\hline"
print "$B \cdot \delta$ ",
for x in res:
   print "&", round(x[1]),
print "\\\\ \n\\hline"
print "$1/c$ ",
for x in res:
   print "&", round(RR(1/x[2])),
print "\\\\ \n\\hline"
