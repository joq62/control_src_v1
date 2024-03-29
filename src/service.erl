%%% -------------------------------------------------------------------
%%% @author : joqerlang
%%% @doc : ets dbase for master service to manage app info , catalog  
%%%
%%% -------------------------------------------------------------------
-module(service).
 

%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%-compile(export_all).
-export([create/3
	]).

create(ServiceSpecId,VmDir,Vm)->
    Result=case rpc:call(node(),db_service_def,read,[ServiceSpecId]) of
	       []->
		   rpc:multicall(misc_oam:masters(),
				 master_log,ticket,
				 [[{error,[eexists,ServiceSpecId]}],node(),
				  ?MODULE,?LINE]);
	       [{ServiceSpecId,ServiceId,ServiceVsn,StartCmd,GitPath}]->
		   case create(ServiceId,ServiceVsn,Vm,VmDir,StartCmd,GitPath) of
		       {ok,ServiceId,ServiceVsn}->
			   rpc:multicall(misc_oam:masters(),
					 master_log,log,
					 [[{service_created,ServiceId,ServiceVsn}],
					  node(),?MODULE,?LINE]),
			   ok;
		       {error,[Reason,?MODULE,?LINE]}->
			   rpc:multicall(misc_oam:masters(),
					 master_log,ticket,
					 [[{error,[Reason,?MODULE,?LINE]}],
					  node(),?MODULE,?LINE]),
			   {error,[Reason,?MODULE,?LINE]}
		   end
	   end,
    Result.

create(ServiceId,ServiceVsn,Vm,VmDir,{application,start,A},GitPath)->
    ServiceDir=string:concat(ServiceId,misc_cmn:vsn_to_string(ServiceVsn)),
    GitDest=filename:join(VmDir,ServiceDir),
    CodePath=filename:join([VmDir,ServiceDir,"ebin"]),
    [ServiceModule]=A,
    true=vm:vm_started(Vm),
    rpc:call(Vm,file,del_dir_r,[GitDest],3000),
    rpc:call(Vm,os,cmd,["git clone "++GitPath++" "++GitDest],10*1000),
    true=rpc:call(Vm,code,add_patha,[CodePath],3000),
    Result=case rpc:call(Vm,application,start,A,3000) of
	       ok->
		   case rpc:call(Vm,ServiceModule,ping,[],3000) of
		       {pong,_,ServiceModule}->
			   {ok,ServiceId,ServiceVsn};
		       Reason->
			   {error,[Reason,?MODULE,?LINE]}
		   end;
	       Reason->
		   {error,[Reason,?MODULE,?LINE]}
	   end,
    Result.

%% ====================================================================
%% External functions
%% ====================================================================


%% --------------------------------------------------------------------
%% 
%%
%% --------------------------------------------------------------------

