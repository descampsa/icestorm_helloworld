
function(add_simulation_target target)
	add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}.sim
		COMMAND iverilog -o ${CMAKE_CURRENT_BINARY_DIR}/${target}.sim ${ARGN}
		DEPENDS ${ARGN})
	add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}.vcd
		COMMAND vvp ${CMAKE_CURRENT_BINARY_DIR}/${target}.sim
		DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}.sim)
	add_custom_target(${target}_simulation
		COMMAND gtkwave ${CMAKE_CURRENT_BINARY_DIR}/${target}.vcd
		DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}.vcd)
endfunction(add_simulation_target)

function(add_synthesis_target target pcf_file)
	add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}.blif
		COMMAND yosys -q -p "synth_ice40 -blif ${CMAKE_CURRENT_BINARY_DIR}/${target}.blif" ${ARGN}
		DEPENDS ${ARGN})
	add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}.pnr
		COMMAND arachne-pnr -p ${pcf_file} ${CMAKE_CURRENT_BINARY_DIR}/${target}.blif -o ${CMAKE_CURRENT_BINARY_DIR}/${target}.pnr
		DEPENDS ${pcf_file} ${CMAKE_CURRENT_BINARY_DIR}/${target}.blif)
	add_custom_command(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${target}.bin
		COMMAND icepack ${CMAKE_CURRENT_BINARY_DIR}/${target}.pnr ${CMAKE_CURRENT_BINARY_DIR}/${target}.bin
		DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}.pnr)
	add_custom_target(${target}_synthesis
		DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/${target}.bin)
	add_custom_target(${target}_upload
		COMMAND iceprog ${CMAKE_CURRENT_BINARY_DIR}/${target}.bin
		DEPENDS ${target}_synthesis)
endfunction(add_synthesis_target)


