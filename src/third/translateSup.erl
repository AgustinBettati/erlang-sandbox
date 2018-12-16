-module(translateSup).

-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
  supervisor:start_link(translateSup, []).

init(_Args) ->
  SupFlags = #{
    strategy => one_for_one, intensity => 1, period => 5
  },
  ChildSpecs = [
    #{id => translate,
%%      como hacer para lanzar translate
    start => {translate, start_link, []},
%%      hay que relanzar sea como murio
    restart => permanent,
%%      cuando se hace shutdown, como matar a los hijos
    shutdown => brutal_kill,
%%      puede ser worker o supervisor
    type => worker,
    modules => [translate]}],
  {ok, {SupFlags, ChildSpecs}}.
