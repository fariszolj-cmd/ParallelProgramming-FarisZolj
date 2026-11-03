## Lab 05: Parallel Global Sum
how i did the assignment 

I used globalsums.c from the GlobalSums repository. It sums an array where half the numbers are 0.1 and half are tiny (about 1e-10), so the tiny ones get lost. I compared 5 methods (double, long double, pairwise, Kahan, Knuth) against an accurate reference sum.

## How I ran it
cd GlobalSums
mkdir build && cd build
cmake .. -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS="-march=native" -DCMAKE_CXX_FLAGS="-march=native"
make
./globalsums > ../results_full.txt

I didn’t use -ffast-math because it gave me errors , I also had to fix the CMake file for GCC 15, turn off do_knuth_sum_gcc_v8 (it crashed), and stop at 2^24 numbers because 2^30 didn't work for some reason.

Results (2^24 numbers)

Reference sum: 838860.8008388608

Method	Absolute error	Relative error	Time (s)
Double	1.42e-05	1.692e-11	0.014383
Long double	-5.38e-08	-6.413e-14	0.022958
Pairwise	0	0	0.063130
Kahan	0	0	0.049736
Knuth	0	0	0.081939
##(i have all of this data in the google sheet below)

This is one run so times can change a bit

## Google Sheet: https://docs.google.com/spreadsheets/d/18eTI33TrntqgW036IPai2YIgMvrJeYPuBnU2B1cquQM/edit?usp=sharing

terminal output
Why some are more accurate

A double only has 53 bits so when the sum is big tiny numbers get rounded, After millions of additions the error is large. Long double has more bits so the error is smaller but not 0. Pairwise adds numbers of similar size Kahan saves the lost part and adds it back later. Knuth calculates the exact error of every addition and adds them all at the end. The accurate methods were about 3.5 to 6 times slower than plain double.

## Parallelization

A global sum means adding a whole array into one number, With floating-point numbers, the order you add them in can change the answer a little. So (a + b) + c is not always the same as a + (b + c).

When the sum runs in parallel, each processor adds its own part and then the parts get added together. The order is different depending on how many processors you use, so you can get a slightly different answer each time

One fix is to sort the numbers first, but that is slow, in my oppinion a better fix is to use Kahan or pairwise, because then the order barely matters. That way the sum can still run in parallel and the answer stays almost the same
