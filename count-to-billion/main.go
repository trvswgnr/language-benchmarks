package main

func countToBillion() {
	for i := 0; i < 1000000000; i++ {}
}

func main() {
	countToBillion()
}

/*
normal build:
go build -o main_go main.go

no optimizations:
go build -gcflags "-N -l" -o main_go_no_opt main.go

optimized:
go build -ldflags "-s -w" -o main_go_opt main.go

* note that the Go's optimized build doesn't optimize performance, but it does reduce the size of the binary by stripping out debug information, symbol table, etc...
*/