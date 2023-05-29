fn count_to_billion() {
    for _ in 0..1_000_000_000 {}
}

fn main() {
    count_to_billion();
}

/*
normal build:
rustc main.rs -o main_rust

no optimizations:
rustc -C opt-level=0 main.rs -o main_rust_no_opt

optimized slightly:
rustc -C opt-level=1 main.rs -o main_rust_opt1

optimized most:
rustc -C opt-level=3 main.rs -o main_rust_opt3
*/
