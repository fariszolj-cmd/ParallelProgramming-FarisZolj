# MPI Parallel Sum

## About
This is my assignment-7, the program uses MPI to calculate the sum of an array using multiple processes.

## How it works
- Main process creates an array with 10000 numbers.
- The array is divided between processes.
- Each process calculates its own partial sum.
- MPI_Reduce combines all partial sums.
- The final result is printed.


## Results

All tests gave the same final sum: 50005000

I tested it with  2, 4 and 8 processes and i have the screenshots provided in the repository of results and such

## Screenshots
Screenshots of the program running with different number of processes will be added here.
