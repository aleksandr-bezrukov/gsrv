-module(gsrv_ets).
-export([init/0, add/4, find/1, update/5, delete/1]).
%-import(server1, [rpc/2]).

-define(ETSNAME, ?MODULE).

%% client routines
%add(Name, Place) -> rpc(name_server, {add, Name, Place}).
%find(Name)-> rpc(name_server, {find, Name}).
%% callback routines
init() -> {ok,ets:new(?ETSNAME,[named_table,public])}.
add(FName,SName,Age,ExpirationTime) -> ets:insert(?ETSNAME,{FName,SName,Age,ExpirationTime}).
find(Key) -> ets:lookup(?ETSNAME,Key).
update(Key,FName,SName,Age,ExpirationTime) -> 
    ets:delete(?ETSNAME,Key),
    add(FName,SName,Age,ExpirationTime).
delete(Key) -> 
    ets:delete(?ETSNAME,Key).

%handle({add, Name, Place}, Dict) -> {ok, dict:store(Name, Place, Dict)};
%handle({find, Name}, Dict)-> {dict:find(Name, Dict), Dict}.