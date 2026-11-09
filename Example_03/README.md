# Example_03 - Optimizacija i SIMD Vektorizacija

Ovaj izvještaj dokumentuje korake optimizacije, izvještaje GCC kompajlera i LIKWID mjerenja performansi za `timestep` kod.

## 1. Mjerenja performansi (LIKWID & RDTSC)

Testiranje je izvršeno na AMD Ryzen 5 3400G procesoru unutar WSL2 okruženja (AVX2, 256-bitna širina SIMD registara).

| Izvršni fajl | Izvorni kod / Zastavice | Runtime (RDTSC) [s] | Vektorizacijski status (GCC) |
|---|---|---|---|
| `run_base` | `timestep.c` | **0.7146 s** | Nije vektorizovano (`if` uslov & `sqrt` memory clobber) |
| `run_opt1` | `timestep_opt1.c` | **0.7298 s** | Djelomična SIMD (32-byte vectors, `sqrt` blokiran) |
| `run_opt2` | `timestep_opt2.c` | **0.6433 s** | Djelomična SIMD (spojene petlje) |
| `run_opt3_base` | `timestep_opt3.c` (Standard) | **0.7158 s** | Djelomična SIMD (`sqrt` blokira memoriju) |
| `run_opt3_fast` | `timestep_opt3.c` (`-fno-trapping-math -fno-math-errno`) | **0.7410 s** | **Potpuna AVX2 SIMD vektorizacija** |

> **Napomena za WSL2:** U WSL2 okruženju, Windows hipervizor blokira direktan pristup AMD hardverskim PMU brojačima, pa LIKWID vraća nule za `DP MFLOP/s`. Stoga je primarni metrik poređenja realno vrijeme izvršavanja procesora `Runtime (RDTSC) [s]`.

---

## 2. Analiza izvještaja kompajlera (`-fopt-info-vec`)

### Bazna verzija (`timestep.c`)
- **Izvještaj:** `missed: not vectorized: unsupported control flow in loop.`
- **Izvještaj:** `missed: statement clobbers memory: wavespeed_46 = sqrt (_8);`
- **Uzrok:** Unutrašnje `if` grananje onemogućava vektorsko izvršavanje. Standardni `sqrt()` poziv iz `<math.h>` piše u globalnu varijablu `errno`, što kompajler tretira kao memorijsku nuspojavu (*memory clobber*) koja spriječava SIMD paralelizam.

### Verzije `opt1` i `opt2`
- **Izvještaj:** `optimized: loop vectorized using 32 byte vectors`
- **Izvještaj:** `missed: statement clobbers memory: wavespeed_58 = sqrt (_26);`
- **Uzrok:** Uklanjanjem `if` uslova i spajanjem petlji, osnovne operacije se vektorizuju na AVX2 (256-bit / 32-byte), ali poziv `sqrt()` i dalje spriječava potpunu SIMD transformaciju čitave petlje.

### Verzija `opt3_fast` (SA `-fno-trapping-math -fno-math-errno`)
- **Izvještaj:** `optimized: loop vectorized using 32 byte vectors` (za sve petlje, bez `missed` poruka).
- **Uzrok:** Zastavica `-fno-math-errno` govori kompajleru da `sqrt` neće postavljati `errno`, a `-fno-trapping-math` pretpostavlja da neće biti floating-point prekida. Ovo omogućava kompajleru zamjenu `sqrt` poziva direktnom AVX2 `VSQRTD` SIMD instrukcijom i ostvarivanje potpune vektorizacije.

---

## 3. Komande za kompajliranje i pokretanje

```bash
# Bazna kompilacija
gcc -O3 -march=znver1 -mprefer-vector-width=256 -fopenmp-simd -fopt-info-vec-optimized -fopt-info-vec-missed -c timestep.c -o timestep.o
gcc main.c timestep.o -o run_base -lm

# Opt3 sa potpunom vektorizacijom
gcc -O3 -march=znver1 -mprefer-vector-width=256 -fopenmp-simd -fopt-info-vec-optimized -fopt-info-vec-missed -fno-trapping-math -fno-math-errno -c timestep_opt3.c -o timestep_opt3_fast.o
gcc main.c timestep_opt3_fast.o -o run_opt3_fast -lm

# Pokretanje LIKWID-a
likwid-perfctr -C 0 -g FLOPS_DP ./run_opt3_fast
