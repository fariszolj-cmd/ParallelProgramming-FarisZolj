
# Parallel Programming - assignment 03

## Overview

* Example 1, Example_2: matrix allocation using fragmented and contiguous memory
* Example 3: AoSoA benchmark measuring initialization time for different vector lengths and dataset sizes
* CSV files: benchmark results
* Makefile: compiled and executed tests

## Benchmark Results

Tested dataset sizes: 1K, 10K, 100K, 1M, 10M, 100M elements.

Tested vector lengths: 2, 4, 8, 16, 32, 64, 128, 256.

Results were entered into Google Sheets with the link provided below

## Performance Graph

my googleSheets link : https://docs.google.com/spreadsheets/d/1PE2p01hkIJb2Pg7J35xIy7wkUlcBLEhfGFOpycxdYtY/edit?usp=sharing


## Explanation

when N gets 10 times bigger, the program takes about 10 times longer to run. This means the time grows linearly. The vector size V does not change the time much. The small changes are probably just random. The program writes data in order, so the memory use stays almost the same for every V. Most of the time is probably spent on rand() and writing data to memory

