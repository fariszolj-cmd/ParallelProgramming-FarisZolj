Lab 05: Parallel Global Sum
What I did

I used globalsums.c from the GlobalSums repo. It sums an array where half the numbers are 0.1 and half are tiny (about 1e-10), so the tiny ones get lost. I compared 5 methods (double, long double, pairwise, Kahan, Knuth) against an accurate reference sum.

How I ran it
cd GlobalSums
mkdir build && cd build
cmake .. -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_FLAGS="-march=native" -DCMAKE_CXX_FLAGS="-march=native"
make
./globalsums > ../results_full.txt

I didn’t use -ffast-math because it can break Kahan and Knuth. I also had to fix the CMake file for GCC 15, turn off do_knuth_sum_gcc_v8 (it crashed), and stop at 2^24 numbers because 2^30 is too much memory.

Results (2^24 numbers)

Reference sum: 838860.8008388608

Method	Absolute error	Relative error	Time (s)
Double	1.42e-05	1.692e-11	0.014383
Long double	-5.38e-08	-6.413e-14	0.022958
Pairwise	0	0	0.063130
Kahan	0	0	0.049736
Knuth	0	0	0.081939

This is one run, so times can change a bit. Error 0 only means it matched the reference here.

Google Sheet: https://docs.google.com/spreadsheets/d/18eTI33TrntqgW036IPai2YIgMvrJeYPuBnU2B1cquQM/edit?usp=sharing

terminal output
Why some are more accurate

A double only has 53 bits, so when the sum is big, tiny numbers get rounded away. After millions of additions the error is large. Long double has more bits, so the error is smaller, but not 0. Pairwise adds numbers of similar size. Kahan saves the lost part and adds it back later. Knuth calculates the exact error of every addition and adds them all at the end. The accurate methods were about 3.5 to 6 times slower than plain double.

Parallelization

A global sum adds a whole array into one number. Floating-point addition is not associative, so (a + b) + c can differ from a + (b + c). In parallel, the order depends on the number of processors and on timing, so the answer can change between runs. Sorting fixes this but is slow. It’s better to use Kahan or pairwise, so the order matters less and the sum can still run in parallel.
