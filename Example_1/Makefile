CC = gcc
CFLAGS = -O2 -Wall -std=c17
FRAG_TARGET = fragmented_matrix
FRAG_SOURCE = fragmented_matrix.c
CONT_TARGET = contiguous_matrix
CONT_SOURCE = contiguous_matrix.c
ROWS ?= 10000
COLS ?= 10000

all: $(FRAG_TARGET) $(CONT_TARGET)

$(FRAG_TARGET): $(FRAG_SOURCE)
	$(CC) $(CFLAGS) -o $(FRAG_TARGET) $(FRAG_SOURCE) -lm

$(CONT_TARGET): $(CONT_SOURCE)
	$(CC) $(CFLAGS) -o $(CONT_TARGET) $(CONT_SOURCE) -lm

run: run-fragmented run-contiguous

run-fragmented: $(FRAG_TARGET)
	./$(FRAG_TARGET) $(ROWS) $(COLS)

run-contiguous: $(CONT_TARGET)
	./$(CONT_TARGET) $(ROWS) $(COLS)

clean:
	rm -f $(FRAG_TARGET) $(CONT_TARGET)

.PHONY: all run run-fragmented run-contiguous clean
