# Week 7 - Example_06: stencil comparison

I compared three versions of the stencil code: stencil_opt2.c (from Example_06), stencil_opt4.c and stencil_opt6.c. They all do the same calculation, only the way OpenMP is used is different. I changed the Makefile a bit so "make run-all" runs all three and saves the output in results.txt.

the results are in the picture i provided and the results notepad file

Total times: opt2 107.36 s, opt4 103.78 s, opt6 104.76 s.

## Difference between the 3 versions

- **opt2:** every loop has its own parallel for, so threads are created and joined again and again (twice every iteration) and there is a barrier after every loop.
- **opt4:** one parallel region for the whole iteration loop, so threads are created only once. The flush loop has nowait so it has no barrier. Thread 0 does the timers, the swap and the print.
- **opt6:** no omp for. Every thread works out its own rows from its thread id and has explicit barriers. The initialization is in the same parallel region, so every thread touches its own data first (first touch).

 Results:

opt4 and opt6 are a little bit faster than opt2 (about 3% and 2%) because there is less creating of threads and less waiting. The difference is small because the program mostly waits for memory (it moves a lot of data every iteration), so the thread overhead is not a big part of the time. opt6 is not faster than opt4, the difference is under 1% and I only ran it once so it is probably just noise. First touch doesn't help much on this CPU because it only has one memory.

 Questions:

**How many threads?** 8, I didn't set OMP_NUM_THREADS so OpenMP used all of them.

**What was improved?** opt2 to opt4: threads are created once instead of 20000 times and nowait removes a barrier. opt4 to opt6: the work is split by hand once instead of by OpenMP in every loop, and first touch.

**Explicit and implicit barriers?** A barrier means all threads wait for each other before going on. Implicit ones are added by OpenMP itself (at the end of a parallel region or an omp for), explicit ones are written by us with pragma omp barrier. opt2 and opt4 only have implicit barriers, opt6 has explicit ones (lines 60, 77 and 84).
