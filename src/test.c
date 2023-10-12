/* quest.c */

#include <curses.h>
#include <stdlib.h>


int main(void)
{
    /* initialize curses */

    initscr();
    start_color();

    /* initialize colors */

    if (has_colors() == FALSE) {
        endwin();
        printf("Your terminal does not support color\n");
        exit(1);
        return 1;
    }
    endwin();
    printf("your terminal does have color\n");
    return 0;
}
