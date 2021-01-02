%%% -------------------------------------------------------------------
%%% @author : joqerlang
%%% @doc : ets dbase for master service to manage app info , catalog  
%%%
%%% -------------------------------------------------------------------
-module(schedule).
  

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------
%% --------------------------------------------------------------------
%% Definition
-define(Cookie,"abc").
%% --------------------------------------------------------------------


%-compile(export_all).
-export([
	 active/0,
	 missing/0,
	 depricated/0
	]).

%% ====================================================================
%% External functions
%% ====================================================================

active()->
     rpc:call(node(),db_sd,active_apps,[]).
%% --------------------------------------------------------------------
%% Function:create(ServiceId,Vsn,HostId,VmId)
%% Description: Starts vm and deploys services 
%% Returns: ok |{error,Err}
%% --------------------------------------------------------------------
missing()->
    MissingApps=deployment:missing_apps(),
    %% Start master nodes first and add 
    MissingAppSpecsInfo=[{AppSpec,db_app_spec:read(AppSpec)}||AppSpec<-MissingApps],
    MissingMasters=[XAppSpec||
		       {XAppSpec,{_AppId,_AppVsn,Type,_Directives,_Services}}<-MissingAppSpecsInfo,
		       Type==master],
    MissingWorkers=[XAppSpec||
		       {XAppSpec,{_AppId,_AppVsn,Type,_Directives,_Services}}<-MissingAppSpecsInfo,
		       Type==worker],
    
    
			      
    
    


  %  [spawn(fun()->
%		   deployment: create_application(AppSpec) end)||AppSpec<-MissingApps],
    
    {MissingMasters,MissingWorkers}.
    
    
%% --------------------------------------------------------------------
%% Function:create(ServiceId,Vsn,HostId,VmId)
%% Description: Starts vm and deploys services 
%% Returns: ok |{error,Err}
%% --------------------------------------------------------------------
depricated()->
    DepricatedApps=deployment:depricated_apps(),
 %   [spawn(fun()->
%	       deployment:delete_application(AppSpec) end)||AppSpec<-DepricatedApps],
    DepricatedApps.
    
%% -------------------------------------------------------------------
%% Function:create(ServiceId,Vsn,HostId,VmId)
%% Description: Starts vm and deploys services 
%% Returns: ok |{error,Err}
%% --------------------------------------------------------------------

