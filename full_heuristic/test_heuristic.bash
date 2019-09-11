##########################################
## Script to run the magma code to 
## create the matrix of the article and
## then run the Sage code to compute
## the distance of target vectors to 
## the lattice.
## The output is stored in lists in the
## file output_heuristic.sage
## and the script also run this code
## to produce the figures of the article
##
## The full computations as below should
## run in 1 day on a regular computer
## (with 8 cores).
## One can reduce this computation time 
## to 1 or 2 hours by removing the values
## 170 up to 200 for r for number fields
## of degree 4 (for the other number 
## fields, this is relatively fast).
## The 3 codes for degree 4, 6 and 8 are
## the same expect for the values of m
## and the values of r
##########################################


echo " " > output_heuristic.sage

echo "Computing the distance between target vectors of a specific form and our lattice L"

#################################
## Number fields of degree 4
#################################

for m in 5 8 12
do
  echo "L$m = [" >> output_heuristic.sage
  for r in 20 40 60 80 90 100 110 120 130 140 150 160 170 180 190 200 ### Remove here `170 180 190 200' and the code should run in 1 or 2 hours
  do
    echo "starting m = $m with r = $r"
    magma -b input:="$m $r" test_heuristic.magma > tmp_input_heuristic.sage
    echo "lattice computed"
    sage test_heuristic.sage >> output_heuristic.sage
  done
  echo "]" >> output_heuristic.sage
done

echo "L_moyenne = [[(L5[i][j]+L8[i][j]+L12[i][j])/3 for j in range(len(L5[0]))] for i in range(len(L5))]" >> output_heuristic.sage
echo "g = Graphics()" >> output_heuristic.sage
echo "for x in L_moyenne:" >> output_heuristic.sage
echo "   g += point([x[0],x[3]])" >> output_heuristic.sage
echo "   g += point([x[0],x[-1]], color = 'red')" >> output_heuristic.sage
echo "g += line([(x[0],x[3]) for x in L_moyenne])" >> output_heuristic.sage
echo "g += line([(x[0],x[-1]) for x in L_moyenne], color = 'red')" >> output_heuristic.sage
echo "g.fontsize(25)" >> output_heuristic.sage
echo "g_pdf = g.plot();" >> output_heuristic.sage
echo "g_pdf.save('degree_4.pdf');" >> output_heuristic.sage


#################################
## Number fields of degree 6
#################################

for m in 7 9 18
do
  echo "L$m = [" >> output_heuristic.sage
  for r in 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200
  do
    echo "starting m = $m with r = $r"
    magma -b input:="$m $r" test_heuristic.magma > tmp_input_heuristic.sage
    echo "lattice computed"
    sage test_heuristic.sage >> output_heuristic.sage
  done
  echo "]" >> output_heuristic.sage
done

echo "L_moyenne = [[(L7[i][j]+L9[i][j]+L18[i][j])/3 for j in range(len(L5[0]))] for i in range(len(L5))]" >> output_heuristic.sage
echo "g = Graphics()" >> output_heuristic.sage
echo "for x in L_moyenne:" >> output_heuristic.sage
echo "   g += point([x[0],x[3]])" >> output_heuristic.sage
echo "   g += point([x[0],x[-1]], color = 'red')" >> output_heuristic.sage
echo "g += line([(x[0],x[3]) for x in L_moyenne])" >> output_heuristic.sage
echo "g += line([(x[0],x[-1]) for x in L_moyenne], color = 'red')" >> output_heuristic.sage
echo "g.fontsize(25)" >> output_heuristic.sage
echo "g_pdf = g.plot();" >> output_heuristic.sage
echo "g_pdf.save('degree_6.pdf');" >> output_heuristic.sage


#################################
## Number fields of degree 8
#################################

for m in 15 16 24
do
  echo "L$m = [" >> output_heuristic.sage
  for r in 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200
  do
    echo "starting m = $m with r = $r"
    magma -b input:="$m $r" test_heuristic.magma > tmp_input_heuristic.sage
    echo "lattice computed"
    sage test_heuristic.sage >> output_heuristic.sage
  done
  echo "]" >> output_heuristic.sage
done

echo "L_moyenne = [[(L15[i][j]+L16[i][j]+L24[i][j])/3 for j in range(len(L5[0]))] for i in range(len(L5))]" >> output_heuristic.sage
echo "g = Graphics()" >> output_heuristic.sage
echo "for x in L_moyenne:" >> output_heuristic.sage
echo "   g += point([x[0],x[3]])" >> output_heuristic.sage
echo "   g += point([x[0],x[-1]], color = 'red')" >> output_heuristic.sage
echo "g += line([(x[0],x[3]) for x in L_moyenne])" >> output_heuristic.sage
echo "g += line([(x[0],x[-1]) for x in L_moyenne], color = 'red')" >> output_heuristic.sage
echo "g.fontsize(25)" >> output_heuristic.sage
echo "g_pdf = g.plot();" >> output_heuristic.sage
echo "g_pdf.save('degree_8.pdf');" >> output_heuristic.sage


####################################
## Plotting the curves with sage
####################################

sage output_heuristic.sage

