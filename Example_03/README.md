# Example_03 - Vectorization Notes

Quick README for Example_03 testing out vectorization improvements on timestep.c.

## Benchmark Results

Tested on AMD Ryzen 5 3400G with 256-bit vector width (`-mprefer-vector-width=256`) in WSL2.

- run_base - timestep.c - **0.7146s** - No 
- run_opt1 - timestep_opt1.c - **0.7298s** - Partial (32-byte vectors, sqrt` missed)
- run_opt2 - timestep_opt2.c - **0.6433s** - Partial (Fastest run)
- run_opt3_base - timestep_opt3.c normal - **0.7158s** - Partial 
- run_opt3_fas` - timestep_opt3.c  - **0.7410s** - **Fully vectorized**





## Compiler Feedback & Notes

* **Base code (timestep.c):** Didn't vectorize at all GCC threw unsupported control flow 
* **opt1 & opt2:** Got partial SIMD using 32-byte (256-bit AVX2) vectors once the if check was removed. sqrt() still blocked full loop vectorization but opt2 ended up with the fastest run time.
* **`opt3_fast`:** Adding -fno-trapping-math and -fno-math-errno finally vectorized the whole thing. It tells GCC sqrt() won't mess with `errno`, so it used actual AVX2 `VSQRTD` vector instructions.


- **Fully vectorized?** Only run_opt3_fast managed to fully vectorize without issues
- **Vector length used?** 256-bit / 32-byte AVX2 vectors.
- **Which run was best?** `run_opt2` was the fastest at 0.6433s.

