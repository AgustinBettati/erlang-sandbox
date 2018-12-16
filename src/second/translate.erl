%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Sep 2018 5:40 PM
%%%-------------------------------------------------------------------
-module(translate).
-compile(export_all).
-author("agustin").

init() -> [].

handle( {translate,"hola"}, History) ->
  {"hello", ["hola" | History]};


handle( {translate,"mundo"}, History) ->
  {"world", ["mundo" | History]};

handle( {stats}, History) ->
  {History, History};

handle( {reset}, History) ->
  {History, []}.


