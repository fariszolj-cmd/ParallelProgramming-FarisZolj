
CC = gcc
CFLAGS = -Wall -Wextra -Wpedantic -std=c11 -g
TARGET = program
SRC = main.c
ARGS = 5

.PHONY: all run valgrind clean

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

run: $(TARGET)
	./$(TARGET) $(ARGS)

valgrind: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET) $(ARGS)

clean:
	rm -f $(TARGET)
