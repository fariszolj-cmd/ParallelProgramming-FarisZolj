
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>

#define ARRAY_SIZE 10

int main(int argc, char *argv[])
{
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <integer>\n", argv[0]);
        return EXIT_FAILURE;
    }

    char *endptr;
    errno = 0;
    long value = strtol(argv[1], &endptr, 10);

    if (errno != 0 || endptr == argv[1] ||
        *endptr != '\0' || value < 0 || value > 9) {
        fprintf(stderr, "Error: enter an integer from 0 to 9.\n");
        return EXIT_FAILURE;
        }

    int *iarray = malloc(ARRAY_SIZE * sizeof *iarray);

    if (iarray == NULL) {
        fprintf(stderr, "Error: memory allocation failed.\n");
        return EXIT_FAILURE;
    }

    for (int i = 0; i < ARRAY_SIZE; i++) {
        iarray[i] = i;
    }

    int ipos = -1;
    int ival = (int)value;

    for (int i = 0; i < ARRAY_SIZE; i++) {
        if (ival == iarray[i]) {
            ipos = i;
            break;
        }
    }

    if (ipos != -1) {
        printf("Value %d found at index %d.\n", ival, ipos);
    } else {
        printf("Value not found.\n");
    }

    free(iarray);
    return EXIT_SUCCESS;
}
