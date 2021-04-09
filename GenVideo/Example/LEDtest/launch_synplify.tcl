#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file /home/diamond/SharedFolder/Example/LEDtest/launch_synplify.tcl
#-- Written on Sun Jan 24 17:21:51 2021

project -close
set filename "/home/diamond/SharedFolder/Example/LEDtest/LEDtest_syn.prj"
if ([file exists "$filename"]) {
	project -load "$filename"
	project_file -remove *
} else {
	project -new "$filename"
}
set create_new 0

#device options
set_option -technology LATTICE-ECP3
set_option -part LFE3_70E
set_option -package FN484C
set_option -speed_grade -6

if {$create_new == 1} {
#-- add synthesis options
	set_option -symbolic_fsm_compiler true
	set_option -resource_sharing true
	set_option -vlog_std v2001
	set_option -frequency 200
	set_option -maxfan 1000
	set_option -auto_constrain_io 0
	set_option -disable_io_insertion false
	set_option -retiming false; set_option -pipe true
	set_option -force_gsr false
	set_option -compiler_compatible 0
	set_option -dup false
	
	set_option -default_enum_encoding default
	
	
	
	set_option -write_apr_constraint 1
	set_option -fix_gated_and_generated_clocks 1
	set_option -update_models_cp 0
	set_option -resolve_multiple_driver 0
	
	
	
}
#-- add_file options
set_option -include_path "/home/diamond/SharedFolder/Example"
add_file -verilog "/home/diamond/SharedFolder/Example/LEDtest/source/clockDivider.v"
add_file -verilog "/home/diamond/SharedFolder/Example/LEDtest/source/count4.v"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/Example/LEDtest/source/count8.vhd"
add_file -verilog "/home/diamond/SharedFolder/Example/LEDtest/source/LEDtest.v"
add_file -verilog "/home/diamond/SharedFolder/Example/LEDtest/source/topcount.v"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/Example/LEDtest/source/typepackage.vhd"
add_file -verilog "/home/diamond/SharedFolder/Example/my_pll.v"
#-- top module name
set_option -top_module {topcount}
project -result_file {/home/diamond/SharedFolder/Example/LEDtest/LEDtest.edi}
project -save "$filename"
