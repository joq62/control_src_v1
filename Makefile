all:
	erlc -o ebin src/*.erl;
	rm -rf ebin/* src/*.beam *.beam;
	rm -rf app_specs service_specs cluster_con*;
	rm -rf  *~ */*~  erl_cra*;
	echo Done
doc_gen:
	echo glurk not implemented
log_terminal:
	rm -rf 1_ebin/* src/*.beam *.beam;
	rm -rf  *~ */*~  erl_cra*;
#	common
	erlc -o 1_ebin ../common_src/src/*.erl;
#	application terminal
	erlc -o 1_ebin ../terminal_src/src/*.erl;
	cp ../../applications/terminal_application/src/*.app 1_ebin;
	erlc -o 1_ebin ../../applications/terminal_application/src/*.erl;
	erl -pa 1_ebin -run terminal boot_app -sname log_terminal -setcookie abc
alert_ticket_terminal:
#	rm -rf 1_ebin/* src/*.beam *.beam;
#	rm -rf  *~ */*~  erl_cra*;
#	common
	erlc -o 1_ebin ../common_src/src/*.erl;
#	application terminal
	erlc -o 1_ebin ../terminal_src/src/*.erl;
	cp ../../applications/terminal_application/src/*.app 1_ebin;
	erlc -o 1_ebin ../../applications/terminal_application/src/*.erl;
	erl -pa 1_ebin -run terminal boot_app -sname alert_ticket_terminal -setcookie abc
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
