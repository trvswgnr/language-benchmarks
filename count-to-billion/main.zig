const std = @import("std");

fn count_to_billion() void {
    for (0..1000000000) |_| {}
}

pub fn main() void {
    count_to_billion();
}

// zig build-exe main.zig --name main_zig
// zig build-exe main.zig -Drelease-fast --name main_zig_fast
// zig build-exe main.zig -Drelease-safe --name main_zig_safe
// zig build-exe main.zig -Drelease-small --name main_zig_small
