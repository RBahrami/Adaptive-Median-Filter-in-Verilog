# 1) Create a work directory for modelsim
vlib ./work

# 2) compile stuff in defined use order
vlog -work work *.v

# 3) use vsim to simulate verilog code without optimization 
vsim  main_tb

# 4) Open windows for viewing result
view structure

# 5) Run simulation
run -all
