%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Create1d : 10 dec 2012
%%% -------------------------------------------------------------------
-module(dbase_test). 
    
%% --------------------------------------------------------------------
%% Include files

-include_lib("eunit/include/eunit.hrl").
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Definitions
-define(ServiceSpecsDir,"service_specs").
-define(AppSpecsDir,"app_specs").
-define(GitUser,"joq62").
-define(GitPassWd,"20Qazxsw20").
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% External exports
-export([start/0]).

%% ====================================================================
%% External functions
%% ====================================================================

%% --------------------------------------------------------------------
%% Function:tes cases
%% Description: List of test cases 
%% Returns: non
%% --------------------------------------------------------------------
start()->
    ?debugMsg("Start setup"),
    ?assertEqual(ok,setup()),
    ?debugMsg("stop setup"),

    ?debugMsg("Start read_app_specs"),
    ?assertEqual(ok,read_app_specs()),
    ?debugMsg("stop read_app_specs"),

    ?debugMsg("Start read_service_specs"),
    ?assertEqual(ok,read_service_specs()),
    ?debugMsg("stop read_service_specs"),

    ?debugMsg("Start read_cluster_config"),
    ?assertEqual(ok, read_cluster_config()),
    ?debugMsg("stop  read_cluster_config"),

    ?assertEqual(ok,cleanup()),

    ?debugMsg("------>"++atom_to_list(?MODULE)++" ENDED SUCCESSFUL ---------"),
    ok.


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

setup()->

    ok.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
read_cluster_config()->
    ?assertMatch([{"c2",_,_,"192.168.0.202",22,not_available},
		  {"c1",_,_,"192.168.0.201",22,not_available},
		  {"c0",_,_,"192.168.0.200",22,not_available}],
		 if_db:call(db_server,read_all,[])),

    ok.
    
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
read_app_specs()->
    ?assertMatch([{"calc_100.app_spec","1.0.0",_,_},
		  {"server_c_100.app_spec","1.0.0",_,_},
		  {"server_a_100.app_spec","1.0.0",_,_},
		  {"server_b_100.app_spec","1.0.0",_,_},
		  {"test1_100.app_spec","1.0.0",_,_}],
		   if_db:call(db_app_spec,read_all,[])),   
    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
read_service_specs()->
    ?assertMatch([{"multi_100.service_spec","multi_service","1.0.0",_,_},
		  {"server_100.service_spec","server","1.0.0",_,_},
		  {"adder_100.service_spec","adder_service","1.0.0",_,_},
		  {"divi_100.service_spec","divi_service","1.0.0",_,_},
		  {"common_100.service_spec","common","1.0.0",_,_},
		  {"dbase_100.service_spec","dbase","1.0.0",_,_}],
		 if_db:call(db_service_def,read_all,[])),

    ok.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------

cleanup()->

    ok.
