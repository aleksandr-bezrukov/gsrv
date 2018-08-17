-module(gsrv_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

init([]) ->
    Procs = [{gsrv, {gsrv, start_link, [[{drop_interval,30}]]}
    ,permanent, 5000, worker, [gsrv]}]
    ,{ok, {{one_for_one, 10, 10}, Procs}}
    .

start_link() ->
	supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%init([]) ->
%	Procs = [],
%	{ok, {{one_for_one, 1, 5}, Procs}}.
