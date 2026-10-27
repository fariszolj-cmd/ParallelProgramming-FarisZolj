CC = gcc
CFLAGS = -O2 -Wall -std=c17
TARGET = array_of_structures
SOURCE = array_of_structures.c
N ?= 10000000

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE) -lm

run: $(TARGET)
	./$(TARGET) $(N)

clean:
	rm -f $(TARGET)

.PHONY: all run clean
