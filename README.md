
# Parallel Programming - assignment 03

## Overview

* Example_1, Example_2: matrix allocation using fragmented and contiguous memory.
* Example_3: AoSoA benchmark measuring initialization time for different vector lengths and dataset sizes.
* CSV files: benchmark results.
* Makefile: compilation and execution of the tests (`make test_1K`, `make test_10K`, ...).

## Benchmark Results

Tested dataset sizes: 1K, 10K, 100K, 1M, 10M, 100M elements.

Tested vector lengths: 2, 4, 8, 16, 32, 64, 128, 256.

Results were imported into Google Sheets to create a chart.

## Performance Graph

my googleSheets link : https://docs.google.com/spreadsheets/d/1DAl0LwwIfYXH_c5AT32XdsfBQkR4tF_rbYCn8ZC9QxA/edit?usp=sharing


## Explanation

The time grows about 10 times when N grows 10 times, so it is linear. The vector length V barely changes the time, and the small differences look like noise. The program only writes data in order, so memory use is the same for every V, and most of the time probably goes on `rand()` and on touching new memory.
EOF
head -8 README.md