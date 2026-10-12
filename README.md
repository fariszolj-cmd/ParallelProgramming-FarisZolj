Sta je valgrind ispisao


Faris@DESKTOP-DD9C7RS:/mnt/d/valgrind-task$ make valgrind
valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./program 5
==3196== Memcheck, a memory error detector
==3196== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
==3196== Using Valgrind-3.26.0 and LibVEX; rerun with -h for copyright info
==3196== Command: ./program 5
==3196==
==3196==
==3196== HEAP SUMMARY:
==3196==     in use at exit: 0 bytes in 0 blocks
==3196==   total heap usage: 1 allocs, 1 frees, 40 bytes allocated
==3196==
==3196== All heap blocks were freed -- no leaks are possible
==3196==
==3196== For lists of detected and suppressed errors, rerun with: -s
==3196== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)
Faris@DESKTOP-DD9C7RS:/mnt/d/valgrind-task$

