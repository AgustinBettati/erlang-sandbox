%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Sep 2018 4:36 PM
%%%-------------------------------------------------------------------
-module(records).
-author("agustin").

%% API
-compile(export_all).

-record(person, {name, age}).

first_person() ->
  #person{name = "Juan", age = 25}.

edad(#person{age = 0}) ->  "Recien nacido";
edad(#person{age = A}) -> A.

