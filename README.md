Valgrind task sta je pisalo u terminalu.

Faris@DESKTOP-DD9C7RS:/mnt/d/valgrind-task$ make valgrind

valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./program 5
==2639== Memcheck, a memory error detector
==2639== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
==2639== Using Valgrind-3.26.0 and LibVEX; rerun with -h for copyright info
==2639== Command: ./program 5
==2639==
Value 5 found at index 5.
==2639==
==2639== HEAP SUMMARY:
==2639==     in use at exit: 0 bytes in 0 blocks
==2639==   total heap usage: 2 allocs, 2 frees, 1,064 bytes allocated
==2639==
==2639== All heap blocks were freed -- no leaks are possible
==2639==
==2639== For lists of detected and suppressed errors, rerun with: -s
==2639== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
Faris@DESKTOP-DD9C7RS:/mnt/d/valgrind-task$



























