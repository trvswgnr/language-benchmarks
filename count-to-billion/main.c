void count_to_billion() {
    for (int i = 0; i < 1000000000; i++) {}
}

int main() {
    count_to_billion();
    return 0;
}

/*
normal build:
gcc main.c -o main_c

no optimizations:
gcc main.c -o main_c_no_opt -O0

optimized slightly:
gcc main.c -o main_c_opt1 -O1

optimized most:
gcc main.c -o main_c_opt3 -O3
*/
