%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. Sep 2018 5:18 PM
%%%-------------------------------------------------------------------
-module(list).
-author("agustin").

%% API
-export([loop/0]).

loop() -> loop([]).

loop(List) ->
  receive
    {From, {store,Item} } ->
      From ! {added, Item},
      loop([Item | List]);

    {From, {take, Item} } ->
      case lists:member(Item, List) of
        true ->
          From ! {deleted, Item},
          loop(lists:delete(Item, List));
        false ->
          From ! {notfound, Item},
          loop(List)
      end;

    {From, {list} } ->
      From ! {ok, List},
      loop(List)

  end.


