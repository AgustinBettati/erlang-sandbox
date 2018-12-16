%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 06. Sep 2018 4:41 PM
%%%-------------------------------------------------------------------
-module(translate).
-author("agustin").

%% API
-export([loop/0]).

loop() -> loop([]).

loop(History) ->
  receive
    { From, {translate,"hola"} } ->
      From ! {ok, "hello"},
      loop(["hola" | History ]);

    { From, {translate,"mundo"} } ->
      From ! {ok, "world"},
      loop(["mundo" | History ]);

    { From, {stats}} ->
      From ! {ok, History},
      loop(History);

    { From, {reset}} ->
      From ! {ok, History},
      loop([]);

    { From, _} ->
      From ! {invalid, "No match"},
      loop(History)
  end.

% Translator = spawn(fun translate:loop/0).
% Translator ! {self(), {translate, "hola"}}.
% flush().



