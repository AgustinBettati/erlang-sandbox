
-module(bolsa).

%% API
-compile(export_all).

%% API
-export([loop/0]).

loop() -> loop(dict:new()).

loop(Dict) ->

  receive

    {From, {crear_accion,Company, Value} } ->
      case dict:find(Company, Dict) of
        {ok, Value} ->
          From ! user_present,
          loop(Dict);
        error ->
          From ! {ok, Company},
          loop(dict:store(Company, Value, Dict))
      end;


    {From, {consultar_valor, Company} } ->
      case dict:find(Company, Dict) of
        {ok, [Head|_]} ->
          From ! {ok, Head};
        error ->
          From ! {notfound, Company}
      end,
      loop(Dict);


    {From, {cambiar_cotizacion, Company, Value}} ->
      case dict:find(Company, Dict) of
        {ok, List} ->
          From ! {ok},
          loop(dict:store(Company, [Value|List], Dict));
        error ->
          From ! {notfound, Company},
          loop(Dict)
      end;


    {From, {consultar_historia, Company} } ->
      case dict:find(Company, Dict) of
        {ok, List} ->
          From ! {ok, List };
        error ->
          From ! {notfound, Company}
      end

  end.


