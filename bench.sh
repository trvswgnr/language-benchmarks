#!/usr/bin/env bash

# This script will run the benchmark for the given folder

# files:
# - main.asm
# - main.c
# - main.go
# - main.js
# - main.php
# - main.py
# - main.rs
# - main.zig

# get the first argument, which will be the folder name
folder=$1
if [ -z "$folder" ]; then
    echo "Please provide a folder name"
    exit 1
fi

# get the second argument, which will be the number of times to run the benchmark
times=$2
if [ -z "$times" ]; then
    times=1
fi

benches_to_run=()

# compile any files that need to be compiled

cd $folder

to_delete=(
    "./main_c"
    "./main_c_opt0"
    "./main_c_opt1"
    "./main_c_opt2"
    "./main_c_opt3"
    "./main_zig"
    "./main_zig_small"
    "./main_zig_fast"
    "./main_zig_safe"
    "./main_go"
    "./main_go_no_opt"
    "./main_go_some_opt"
    "./main_go_full_opt"
    "./main_rs"
    "./main_rs_opt0"
    "./main_rs_opt1"
    "./main_rs_opt2"
    "./main_rs_opt3"
    "./main_asm"
)

# also delete any .o files
to_delete+=($(find . -name "*.o"))

# clean up
rm -rf "${to_delete[@]}"

exit 0

# c
if [ -f "main.c" ]; then
    echo "Compiling C..."

    # normal build
    gcc main.c -o main_c
    # no optimizations
    gcc main.c -o main_c_opt0 -O0
    # minimal optimizations
    gcc main.c -o main_c_opt1 -O1
    # more optimizations
    gcc main.c -o main_c_opt2 -O2
    # full optimizations
    gcc main.c -o main_c_opt3 -O3

    benches_to_run+=("./main_c")
    # benches_to_run+=("./main_c_opt0")
    # benches_to_run+=("./main_c_opt1")
    # benches_to_run+=("./main_c_opt2")
    # benches_to_run+=("./main_c_opt3")

    echo "Finished compiling C"
fi

# zig
if [ -f "main.zig" ]; then
    echo "Compiling Zig..."

    # normal
    zig build-exe main.zig --name main_zig

    # small
    zig build-exe main.zig -Drelease-small --name main_zig_small

    # fast
    zig build-exe main.zig -Drelease-fast --name main_zig_fast

    # safe
    zig build-exe main.zig -Drelease-safe --name main_zig_safe

    benches_to_run+=("./main_zig")
    # benches_to_run+=("./main_zig_small")
    # benches_to_run+=("./main_zig_fast")
    # benches_to_run+=("./main_zig_safe")

    echo "Finished compiling Zig"
fi

# go
if [ -f "main.go" ]; then
    echo "Compiling Go..."

    # normal build
    go build -o main_go main.go
    # no optimizations
    go build -gcflags '-N -l' -o main_go_no_opt main.go
    # minimal optimizations
    go build -gcflags '-l' -o main_go_some_opt main.go
    # full optimizations
    go build -ldflags "-s -w" -o main_go_full_opt main.go

    benches_to_run+=("./main_go")
    # benches_to_run+=("./main_go_no_opt")
    # benches_to_run+=("./main_go_some_opt")
    # benches_to_run+=("./main_go_full_opt")

    echo "Finished compiling Go"
fi

# rust
if [ -f "main.rs" ]; then
    echo "Compiling Rust..."

    # normal build
    rustc main.rs -o main_rs
    # no optimizations
    rustc -C opt-level=0 main.rs -o main_rs_opt0
    # minimal optimizations
    rustc -C opt-level=1 main.rs -o main_rs_opt1
    # more optimizations
    rustc -C opt-level=2 main.rs -o main_rs_opt2
    # full optimizations
    rustc -C opt-level=3 main.rs -o main_rs_opt3

    benches_to_run+=("./main_rs")
    # benches_to_run+=("./main_rs_opt0")
    # benches_to_run+=("./main_rs_opt1")
    # benches_to_run+=("./main_rs_opt2")
    # benches_to_run+=("./main_rs_opt3")

    echo "Finished compiling Rust"
fi

# asm
if [ -f "main.asm" ]; then
    echo "Compiling Assembly..."

    os_type=$(uname -s)
    if [ "$os_type" = "Darwin" ]; then
        # mac
        nasm -f macho64 main.asm -o main_asm.o
        ld main_asm.o -o main_asm -macosx_version_min 11.0 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem
    else
        # linux
        nasm -f elf64 main.asm -o main_asm.o
        ld main_asm.o -o main_asm
    fi

    benches_to_run+=("./main_asm")

    echo "Finished compiling Assembly"
fi

# add the rest of the benches
benches_to_run+=("node ./main.js")
benches_to_run+=("php ./main.php")
benches_to_run+=("python3 ./main.py")

# run the benchmarks using hyperfine
echo "Running benchmarks..."

# if the "results" folder doesn't exist, create it
if [ ! -d "results" ]; then
    mkdir results
fi

hyperfine --export-markdown results/benchmarks.md --export-csv results/benchmarks.csv --export-json results/benchmarks.json --warmup 3 --runs $times "${benches_to_run[@]}"

to_delete+=($(find . -name "*.o"))

# clean up
rm -rf "${to_delete[@]}"

cd ..

echo "Done!"
