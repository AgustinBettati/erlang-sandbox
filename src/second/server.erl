%%%-------------------------------------------------------------------
%%% @author agustin
%%% @copyright (C) 2018, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. Sep 2018 4:38 PM
%%%-------------------------------------------------------------------
-module(server).
-compile(export_all).
-author("agustin").
%%Todo esto que hacemos ahora lo hace erlang solo, es un server generico, que maneja transacciones

start(Name, Module) ->
%%  Esto es clave porque con Name tengo referencia al actor
  register(Name, spawn(fun() -> loop(Name, Module, Module:init()) end)).

%%nombre del actor, el modulo al que pertenece la funcionalidad
%%con name no queda sujeto a la direccion de un actor, sino un nombre por el cual pueden ir pasando muchos actores
loop(Name, Module, State) ->
  receive
%%    se puede mandar un mensaje que cambia el modulo, es decir puedo cambiar las funciones
%%    le esta pidiendo al actor que mute su comportamiento, manteniendo su estado
    {From, {swap_code, NewModule}} ->
      From ! {Name, ok, success},
      loop(Name, NewModule, State);

%%    recibo cierto request
    {From, Request} ->
%%      El module que me pasan como parametro tiene que tener definido handle que recibe un request y da un response
%%        va a tener implementado muchas veces a handle con distintos requests como {reset}, {translate, Palabra}}
      try Module:handle(Request, State) of
%%        el handle puede responder bien, o tirar un excepcion.
        {Response, NewState} ->
        From ! {Name, ok, Response},
        loop(Name, Module, NewState)
      catch
%%      mato al que me mando el mensaje que me rompio algo
        _: Why ->
          From ! {Name, crash, Why},
          loop(Name, Module, State)
      end


  end.
%%cambiar el modulo con el cual manejo mis requests
swap_code(Name, Module) ->
  call(Name, {swap_code, Module}).

%%abstrae el hecho de agregar el self a un request (no hay que agregar quien mando el mensaje, solo a donde lo mando)
call(Name, Request) ->
  Name ! { self(), Request },
  receive
    {Name, ok, Response} -> Response;
    {Name, crash, Why} -> exit(Why)
  end.