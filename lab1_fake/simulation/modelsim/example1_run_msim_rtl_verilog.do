transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/widerw/OneDrive\ -\ Wentworth\ Institute\ of\ Technology/College/2_Junior/Semester\ 2/Advanced\ Digital\ Circuit/altera {C:/Users/widerw/OneDrive - Wentworth Institute of Technology/College/2_Junior/Semester 2/Advanced Digital Circuit/altera/example1.v}

