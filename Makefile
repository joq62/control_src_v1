all:
	rm -rf ebin/* src/*.beam *.beam;
	rm -rf app_specs service_specs cluster_con*;
	rm -rf  *~ */*~  erl_cra*;
	echo Done
doc_gen:
	echo glurk not implemented
test:
	rm -rf ebin/* src/*.beam *.beam;
	rm -rf  *~ */*~  erl_cra*;
	rm -rf app_specs service_specs cluster_con*;
	erlc -o ebin src/*.erl;
#	Start Dependencies
#	common
	erlc -o ebin ../common_src/src/*.erl;
#	dbase
	erlc -o ebin ../dbase_src/src/*.erl;
#	End Dependencies
	erl -pa ebin -s control_unit_tests start -sname control -setcookie test
