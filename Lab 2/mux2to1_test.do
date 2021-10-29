vlib work

vlog part2.v

vsim mux2to1

log {/*}
add wave {/*}

force {x} 0
force {y} 1
force {s} 0
run 10ns


force {x} 0
force {y} 1
force {s} 1
run 10ns

force {x} 1
force {y} 0
force {s} 0
run 10ns


force {x} 1
force {y} 0
force {s} 1
run 10ns