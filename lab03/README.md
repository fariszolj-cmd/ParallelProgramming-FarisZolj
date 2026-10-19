# Lab 03 — Performance Limits and Profiling

## Environment
- Operating system: Ubuntu under WSL
- CPU reported by LIKWID: AMD Ryzen 5 3400G with Radeon Vega Graphics
- Hardware topology: 4 cores, 8 logical processors
- LIKWID version: 5.4.1

## 1. Hardware Topology — hwloc
The hardware topology was inspected using hwloc. The WSL environment reported one package, 4 cores and 8 logical processors.

Results are stored in `results/hardware-topology.txt` and `results/hardware-topology-console.txt`.

## 2. Memory Bandwidth — STREAM
STREAM completed successfully and validated its results.

| Kernel | Best bandwidth (MB/s) |
|---|---:|
| Copy | 26542.0 |
| Scale | 14786.2 |
| Add | 17565.6 |
| Triad | 17307.1 |

The test used 10,000,000 elements and 8 threads. Results are stored in `results/stream-results.txt`.

Measurements were collected inside WSL and may differ from native Linux performance.

## 3. Roofline Toolkit
The Empirical Roofline Toolkit benchmark ran with 1, 2 and 4 OpenMP threads. Results and logs are stored in `results/roofline/`.

Graph generation failed because the generated gnuplot script used an unsupported `set clabel` option. The benchmark results and logs were retained.

## 4. Callgrind Profiling — CloverLeaf Serial
CloverLeaf Serial was compiled with GNU compiler flags and run using the `clover_bm16_short.in` input.

Profiling was manually interrupted at step 20 because Callgrind instrumentation made the simulation very slow. The resulting profile is partial, not a complete benchmark.

Recorded instruction shares included:
- `advec_mom_kernel`: 28.93%
- `advec_cell_kernel`: 18.68%
- `PdV_kernel`: 17.56%
- `accelerate_kernel`: 9.33%
- `viscosity_kernel`: 7.54%

These percentages represent recorded instruction counts, not wall-clock execution time.

## 5. LIKWID Hardware Counters
LIKWID 5.4.1 was installed and its performance-counter groups were listed. However, the test command failed with `Cannot get access to MSRs`. Hardware-counter measurements could not be collected in this WSL environment.

The output is stored in `results/likwid/likwid-status.txt`.

## Limitations
- Measurements were collected inside WSL.
- Roofline graph generation failed because of a gnuplot compatibility issue.
- Callgrind profiling was interrupted and is incomplete.
- LIKWID hardware-counter access was denied.
