%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Sep 2018 5:26 PM
%%%-------------------------------------------------------------------
-module(errors).
-author("agustin").
-compile(export_all).

%% API
%%
%%f(1) -> throw(a);
%%f(2) -> erlang:error(b);
%%f(3) -> exit(c).

f(N) ->
  timer:sleep(2500),
  io:format("Running step ~p~n", [N]),
  10/N,
  f(N - 1).

on_exit(Pid, Fun) ->
  spawn(fun() ->
%%    si me llega un mensaje del tipo exit, enves de morir, lo veo como un mensaje
    process_flag(trap_exit, true),
%%   como se linkea Pid, voy a recibir el exit de su actor
    link(Pid),
    receive
%%      Fun(Why) va ser el keepalive pero lo recibo al metodo como un parametro
      { 'EXIT', Pid, Why} -> Fun(Why)
    end
  end).

keep_alive(Name, Fun) ->
%%  register es un mapa
  register(Name, Pid = spawn(Fun)),
  on_exit(Pid, fun(_Why) -> keep_alive(Name, Fun) end).

% errors:keep_alive(divider, fun() -> errors:f(5) end). 
