onbreak {resume}

# create library
if [file exists work] {
    vdel -all
}
vlib work

# compile source files
vlog arbiter_tb.sv arbiter.sv fixedpriority.sv onehotdecoder.sv rotator.sv 

# start and run simulation
vsim -voptargs=+acc work.testbench

view list
view wave

-- display input and output signals as hexidecimal values
# Diplays All Signals recursively
add wave -hex -r /testbench/*
# add wave -noupdate -divider -height 32 "Datapath"
# add wave -hex /tb/dut/part1/*
# add wave -noupdate -divider -height 32 "Control"
# add wave -hex /tb/dut/part2/*
# add wave -noupdate -divider -height 32 "Note for Speaker"
# add wave -hex /tb/dut/part1/note1/*
# add wave -hex /tb/dut/part1/note2/*
# add wave -hex /tb/dut/part1/note3/*
# add wave -hex /tb/dut/part1/note4/*

add list -hex -r /testbench/*
add log -r /*

-- Set Wave Output Items 
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

-- Run the Simulation
run 150 ns
