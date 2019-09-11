################################################
## This file contains code to produce the
## pictures of p_l as a function of l
## The pictures are done in three number fields:
## the cyclotomic number field of conductor 32
## the cyclotomic number field of conductor 100
## and a "random" number field of degree 32
## It runs in time roughly 45 minutes on a
## personal laptop
#################################################

load("shared_functions.sage")

############################################
## Parameters
############################################

list_alpha = list(arange(0.001,0.011,0.001)) + list(arange(0.01,0.11,0.01)) + list(arange(0.1,1.1,0.1))
var('a,b,c')
model(x) = a*x+b
shortReals = RealField(15)

############################################
## Test for cyclotomic number field of 
## degree 32 (and conductor 64)
############################################

print "Starting cyclotomic of degree d = 32"

K = CyclotomicField(64)

d = K.degree()
B = d
delta = RR(log(d^2*log(d^2),2))
bt = RR.random_element(-delta,delta)
B0 = Gen_Primes(K, 2^delta)
LOG_B0 = [RR(log(I.norm(),2)) for I in B0]
r = len(B0)

###### Starting tests of proportionality ######
print "starting test proportionality..."
res = proportional_interval(list_alpha,LOG_B0,B,r,bt,500000)

##### printing graph for alpha of the order of 0.001 #####
res_tmp = [res[i] for i in range(10)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.001 and 0.01: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(0.01,fit[b]+fit[a]*0.01)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('cyclotomic_32_step_0_001.pdf');


##### printing graph for alpha of the order of 0.01 #####
res_tmp = [res[i] for i in range(10,20)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.01 and 0.1: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(0.1,fit[b]+fit[a]*0.1)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('cyclotomic_32_step_0_01.pdf');


##### printing graph for alpha of the order of 0.1 #####
res_tmp = [res[i] for i in range(20,30)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.1 and 1: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(1,fit[b]+fit[a]*1)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('cyclotomic_32_step_0_1.pdf');


############################################
## Test for cyclotomic number field of 
## degree 40 (and conductor 100)
############################################

print "Starting cyclotomic of degree d = 40"

K = CyclotomicField(100)

d = K.degree()
B = d
delta = RR(log(d^2*log(d^2),2))
bt = RR.random_element(-delta,delta)
B0 = Gen_Primes(K, 2^delta)
LOG_B0 = [RR(log(I.norm(),2)) for I in B0]
r = len(B0)

###### Starting tests of proportionality ######
print "starting test proportionality..."
res = proportional_interval(list_alpha,LOG_B0,B,r,bt,500000)

##### printing graph for alpha of the order of 0.001 #####
res_tmp = [res[i] for i in range(10)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.001 and 0.01: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(0.01,fit[b]+fit[a]*0.01)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('cyclotomic_40_step_0_001.pdf');


##### printing graph for alpha of the order of 0.01 #####
res_tmp = [res[i] for i in range(10,20)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.01 and 0.1: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(0.1,fit[b]+fit[a]*0.1)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('cyclotomic_40_step_0_01.pdf');


##### printing graph for alpha of the order of 0.1 #####
res_tmp = [res[i] for i in range(20,30)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.1 and 1: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(1,fit[b]+fit[a]*1)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('cyclotomic_40_step_0_1.pdf');


############################################
## Test for a "random" number field of 
## degree 32
############################################

print "Starting random number field of degree d = 32"

PP.<T> = PolynomialRing(QQ)
tt = sum( [ randint(-4,4)*T^i for i in xrange(1,32) ] ) #generate some random poly with small coeffs
K.<z> = NumberField(T^32+ tt +1) #to get a "random" number field

d = K.degree()
B = d
delta = RR(log(d^2*log(d^2),2))
bt = RR.random_element(-delta,delta)
B0 = Gen_Primes(K, 2^delta)
LOG_B0 = [RR(log(I.norm(),2)) for I in B0]
r = len(B0)

###### Starting tests of proportionality ######
print "starting test proportionality..."
res = proportional_interval(list_alpha,LOG_B0,B,r,bt,500000)

##### printing graph for alpha of the order of 0.001 #####
res_tmp = [res[i] for i in range(10)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.001 and 0.01: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(0.01,fit[b]+fit[a]*0.01)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 27);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('random_32_step_0_001.pdf');


##### printing graph for alpha of the order of 0.01 #####
res_tmp = [res[i] for i in range(10,20)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.01 and 0.1: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(0.1,fit[b]+fit[a]*0.1)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('random_32_step_0_01.pdf');


##### printing graph for alpha of the order of 0.1 #####
res_tmp = [res[i] for i in range(20,30)]
graph = Graphics()
for pt in res_tmp:
   graph += point(pt, size = 60)

fit = find_fit(res_tmp, model, solution_dict = True)
print "Between 0.1 and 1: \n  Slope = ", fit[a], "\n  Value in zero = ", fit[b]
graph += line([(0,fit[b]),(1,fit[b]+fit[a]*1)], color = 'gray')
graph += text("y = "+str(shortReals(fit[a]))+"x+"+str(shortReals(fit[b])), [res_tmp[4][0],res_tmp[-1][1]], color = 'black', fontsize = 28);
graph.fontsize(25)

g_pdf = graph.plot();
g_pdf.save('random_32_step_0_1.pdf');





