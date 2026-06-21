## -----------------------------------------------------------------------------
## RELOJ Y VOLTAJES
## -----------------------------------------------------------------------------
set_property PACKAGE_PIN W5 [get_ports Clk]					
	set_property IOSTANDARD LVCMOS33 [get_ports Clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports Clk]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

## -----------------------------------------------------------------------------
## RESET Y SELECCIÓN (per)
## -----------------------------------------------------------------------------
set_property PACKAGE_PIN U18 [get_ports Reset]					
	set_property IOSTANDARD LVCMOS33 [get_ports Reset]

set_property PACKAGE_PIN V17 [get_ports {per[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {per[0]}]
set_property PACKAGE_PIN V16 [get_ports {per[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {per[1]}]

## -----------------------------------------------------------------------------
## LEDS (led_raw) - Mapeados a los 8 LEDs de la derecha (LD0 a LD7)
## -----------------------------------------------------------------------------
set_property PACKAGE_PIN U16 [get_ports {led_raw[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[0]}]
set_property PACKAGE_PIN E19 [get_ports {led_raw[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[1]}]
set_property PACKAGE_PIN U19 [get_ports {led_raw[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[2]}]
set_property PACKAGE_PIN V19 [get_ports {led_raw[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[3]}]
set_property PACKAGE_PIN W18 [get_ports {led_raw[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[4]}]
set_property PACKAGE_PIN V18 [get_ports {led_raw[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[5]}]
set_property PACKAGE_PIN U15 [get_ports {led_raw[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[6]}]
set_property PACKAGE_PIN U14 [get_ports {led_raw[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_raw[7]}]

## -----------------------------------------------------------------------------
## DAC (dac_filt) - Mapeado al PMOD JA (Para el R2R)
## -----------------------------------------------------------------------------
set_property PACKAGE_PIN J1 [get_ports {dac_filt[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[0]}]
set_property PACKAGE_PIN L2 [get_ports {dac_filt[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[1]}]
set_property PACKAGE_PIN J2 [get_ports {dac_filt[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[2]}]
set_property PACKAGE_PIN G2 [get_ports {dac_filt[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[3]}]
set_property PACKAGE_PIN H1 [get_ports {dac_filt[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[4]}]
set_property PACKAGE_PIN K2 [get_ports {dac_filt[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[5]}]
set_property PACKAGE_PIN H2 [get_ports {dac_filt[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[6]}]
set_property PACKAGE_PIN G3 [get_ports {dac_filt[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {dac_filt[7]}]