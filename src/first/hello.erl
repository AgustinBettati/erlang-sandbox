%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 02. Sep 2018 2:53 PM
%%%-------------------------------------------------------------------
-module(hello).
-author("agustin").

%% API
-export([hello_world/0]).

hello_world() -> io:fwrite("Hello World").

