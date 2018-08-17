-module(gsrv).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, start_link/1]).
-export([add/5, find/2, redis_test/0]).
%-import(server1, [rpc/2]).

%% client routines
start_link([{drop_interval, Seconds}]) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [{drop_interval, Seconds}], [])
    ,{ok,self()}
    .

redis_test() ->
    gen_server:call(?MODULE,{redis_set_value,foo,bar})
    ,io:format("settttt")
    .

find(Selector,Key) ->
    gen_server:call(?MODULE,{find,Selector,Key})
    .

add(Selector,FName,LName,Age,ExpiredTime) ->
    gen_server:call(?MODULE,{add,Selector,FName,LName,Age,ExpiredTime})
    ,ok
    .


init([{drop_interval,_MilliSeconds}]) ->
    {ok,_} = gsrv_ets:init()
    ,{ok, Pid}= gsrv_redis:init()
    ,{ok,Pid}
    .


%add(Selector,FName,SName,Age,ExpiredTime) ->
%    case Selector of
%	ets -> gsrv_ets:add(FName,SName,Age,ExpiredTime)
%	;redis -> gsrv_redis:add(FName,SName,Age,ExpiredTime)
%    end.

handle_call({add,Selector,FName,SName,Age,ExpiredTime},_From,State) ->
    Reply = case Selector of
	ets -> gsrv_ets:add(FName,SName,Age,ExpiredTime)
	;redis -> gsrv_redis:add(FName,SName,Age,ExpiredTime)
    end
    ,{reply,Reply,State}
    .

handle_cast(_Request, State)->
    {noreply,State}
    .
%add(Name, Place) -> rpc(name_server, {add, Name, Place}).
%find(Name)
%-> rpc(name_server, {find, Name}).
%% callback routines
%init() -> ets:new().
%handle({add, Name, Place}, Dict) -> {ok, dict:store(Name, Place, Dict)};
%handle({find, Name}, Dict)
%-> {dict:find(Name, Dict), Dict}.