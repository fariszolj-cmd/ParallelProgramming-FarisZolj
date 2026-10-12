
CC = gcc
CFLAGS = -Wall -Wextra -g -std=c99
TARGET = program
SOURCE = main.c
ARGS = 5

.PHONY: all run valgrind valgrind-simple clean

all: $(TARGET)

$(TARGET): $(SOURCE)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCE)

run: $(TARGET)
	./$(TARGET) $(ARGS)

valgrind: $(TARGET)
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./$(TARGET) $(ARGS)

valgrind-simple: $(TARGET)
	valgrind --tool=memcheck --leak-check=yes ./$(TARGET) $(ARGS)

clean:
	rm -f $(TARGET)
