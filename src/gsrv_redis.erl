-module(gsrv_redis).
-export([init/0, add/5, add/4, find/2]).
%-import(server1, [rpc/2]).

-define(ETSNAME, ?MODULE).

%-record(redis_pid,{Pid}).

%% client routines
%add(Name, Place) -> rpc(name_server, {add, Name, Place}).
%find(Name)-> rpc(name_server, {find, Name}).
%% callback routines
init() ->
    {ok, Pid} = eredis:start_link()
    ,{ok,Pid}
    .

add(FName,SName,Age,ExpirationTime) -> 
    {ok, <<"OK">>} = eredis:q(pid, ["SET", FName, {SName,Age,ExpirationTime}])
%    ,{ok, <<"bar">>} = eredis:q(Pid, ["GET", Key])
    ,{ok, <<"OK">>}
    .

add(Pid,FName,SName,Age,ExpirationTime) -> 
    {ok, <<"OK">>} = eredis:q(Pid, ["SET", FName, {SName,Age,ExpirationTime}])
%    ,{ok, <<"bar">>} = eredis:q(Pid, ["GET", Key])
    ,{ok, <<"OK">>}
    .


find(Pid,FName) -> 
    {ok, Result} = eredis:q(Pid, ["GET", FName])
    ,{ok, Result}
    .
%update(Key,FName,SName,Age,ExpirationTime) -> 
%    ets:delete(?ETSNAME,Key),
%    add(FName,SName,Age,ExpirationTime).
%delete(Key) -> 
%    ets:delete(?ETSNAME,Key).

%handle({add, Name, Place}, Dict) -> {ok, dict:store(Name, Place, Dict)};
%handle({find, Name}, Dict)-> {dict:find(Name, Dict), Dict}.