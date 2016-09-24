file(GLOB src_files ${CMAKE_CURRENT_SOURCE_DIR}/../src/*.v)
file(GLOB synth_files ${CMAKE_CURRENT_SOURCE_DIR}/*.pcf)

foreach(synth ${synth_files})
	get_filename_component(target ${synth} NAME_WE)
	add_synthesis_target(${target} ${synth} ${src_files})
endforeach(synth)
