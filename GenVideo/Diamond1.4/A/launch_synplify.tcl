#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file /home/diamond/SharedFolder/Diamond1.4/A/launch_synplify.tcl
#-- Written on Thu Jan 21 21:19:31 2021

project -close
set filename "/home/diamond/SharedFolder/Diamond1.4/A/A_syn.prj"
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
set_option -package FN672C
set_option -speed_grade -8

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
add_file -vhdl "/usr/local/diamond/3.11_x64/cae_library/synthesis/vhdl/ecp3.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/TestVideoTop.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/I2cMasterCommands.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/I2CMasterDevice.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Forth120719/VHDL/ep32Tss.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Forth120719/VHDL/Forth.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Forth120719/VHDL/Rx.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Forth120719/VHDL/Tx.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Forth120719/VHDL/UartTss.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/SeqBlk1204.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/IpxLpc/Pll125to100x50.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Dvi410/Dvi410Cnt.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Dvi410/Dvi410Conf.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Dvi410/Dvi410Main.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Dvi410/Dv i410Request.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Dvi410/Dvi410Sync.vhd"
add_file -vhdl -lib "work" "/home/diamond/SharedFolder/VHDL/Dvi410/Dvi410Timing.vhd"
#-- top module name
set_option -top_module {TestVideoTop}
project -result_file {/home/diamond/SharedFolder/Diamond1.4/A/A.edi}
project -save "$filename"
