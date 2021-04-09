
#Begin clock constraint
define_clock -name {my_pll|CLKOK_inferred_clock} {n:my_pll|CLKOK_inferred_clock} -period 4.390 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 2.195 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {topcount|direction} {p:topcount|direction} -period 10000000.000 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 5000000.000 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {topcount|clk} {p:topcount|clk} -period 1.846 -clockgroup Autoconstr_clkgroup_2 -rise 0.000 -fall 0.923 -route 0.000 
#End clock constraint
