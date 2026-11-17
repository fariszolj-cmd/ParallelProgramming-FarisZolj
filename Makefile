CC = gcc
CFLAGS = -fopenmp -Wall -std=c11 -march=native -O2
LDFLAGS = -lm

# Stencil source files (main programs)
SOURCES = stencil_opt2.c stencil_opt4.c stencil_opt6.c


# Generate executable names
EXECUTABLES = $(SOURCES:.c=)

# Utility object files
UTILS = timer.o malloc2D.o

# Default target: build all executables
all: $(EXECUTABLES)
	@echo "All stencil executables built successfully!"

# Generic rule: compile any stencil .c file into executable
# Each depends on its .c file and utility objects
%: %.c $(UTILS)
	@echo "Building $@..."
	$(CC) $(CFLAGS) $< $(UTILS) -o $@ $(LDFLAGS)

# Compile timer utility
timer.o: timer.c timer.h
	@echo "Compiling timer..."
	$(CC) $(CFLAGS) -c timer.c -o $@

# Compile malloc2D utility
malloc2D.o: malloc2D.c malloc2D.h
	@echo "Compiling malloc2D..."
	$(CC) $(CFLAGS) -c malloc2D.c -o $@

# Run targets (for convenience)
run-opt2: stencil_opt2
	@echo "Running stencil_opt2..."
	./stencil_opt2

run-opt4: stencil_opt4
	@echo "Running stencil_opt4..."
	./stencil_opt4

run-opt6: stencil_opt6
	@echo "Running stencil_opt6..."
	./stencil_opt6

# Run all three examples one after another and save the output in results.txt
run-all: all
	@{ \
	echo "CPU: $$(grep -m1 'model name' /proc/cpuinfo | cut -d: -f2 | sed 's/^ //')"; \
	echo "Hardware threads (nproc): $$(nproc)"; \
	echo "OMP_NUM_THREADS: $${OMP_NUM_THREADS:-<unset, OpenMP default>}"; \
	echo ""; \
	for p in $(EXECUTABLES); do \
	  echo "===== Running $$p ====="; \
	  ./$$p; \
	  echo ""; \
	done; \
	} 2>&1 | tee results.txt


# Clean up
clean:
	@echo "Cleaning up..."
	rm -f $(EXECUTABLES) $(UTILS) results.txt

# Clean and rebuild
rebuild: clean all

.PHONY: all clean rebuild run-opt2 run-opt4 run-opt6 run-all