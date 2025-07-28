vlib work
vlog  reg_mux_48.v reg_mux_1bit.v reg_mux_8.v reg_mux.v reg_mux_36.v design.v test_bench.v 
vsim -voptargs=+acc work.test 
add wave *
run -all
#quit -sim