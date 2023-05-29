# Language Benchmarks

This repository contains a collection of benchmarks for various programming languages. The goal is to compare the performance of different languages for the same tasks.

## Requirements

To run all of the benchmarks, you will obviously need to have all of the languages installed. You will also need a compiler for each language, as well as the `hyperfine` benchmarking tool.

Note that the assembly benchmarks are written for macOS, so you will need to modify them if you are using a different operating system.

## Running the Benchmarks

To run all of the benchmarks, run the `bench.sh` script and pass in the target folder along with the number of runs. This will compile all of the relavent language files and run them with `hyperfine`. The results will be saved in the `results` directory in the target folder.

```bash
./bench.sh /path/to/folder 100
```

## Adding Benchmarks

To add a new benchmark, create a new folder in the root directory of this repository. The folder name should be the name of the benchmark. Inside the folder, optionally create a `README.md` file that describes the goal. Then, create a file for each language that you want to benchmark. The file should be named `main.ext`, where `ext` is the file extension for the language. For example, the file for a C benchmark would be named `main.c`.

The benchmark files should be written in a way that allows them to be compiled and run from the command line. For example, a C benchmark should be able to be compiled with `gcc main.c -o main_c` and run with `./main_c`. The benchmark should also be able to be run multiple times in a row without any user input. This is so that the benchmarking script can run the benchmark multiple times and get an average execution time.

The benchmarking script will run the benchmark multiple times and get the average execution time. The number of times that the benchmark is run can be specified as the second argument to the `bench.sh` script.

The current supported languages are:

- Assembly
- C
- Go
- JavaScript
- PHP
- Python
- Rust
- Zig

## Contributing

If you would like to add a benchmark, feel free to open a pull request. If you would like to add a benchmark for a language that is not currently supported, you can also open an issue and I will try to add it.
