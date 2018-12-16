-module(translate).
%% no esta bueno el export all. la idea es que solo se llame a
-compile(export_all).
%%es como una clase abs tracta, se tiene que definir cietas funciones, pero tambien tiene cierto comportamiento que vos heredas
-behavior(gen_server).

%%-type word() :: string().
%%-spec translate(word()) -> word().

translate(Word) ->
  gen_server:call(global:whereis_name(translate), {translate, Word}).

stats() ->
  gen_server:call(global:whereis_name(translate), {stats}).

reset() ->
%%  cast no esta funcionando
  gen_server:cast(global:whereis_name(translate), {reset}).


start_link() ->
%%  lo registra local, no global
  gen_server:start_link({global, translate}, translate, [],[]).

%%con underscore aclaro que no la voy a usar, podria poner solo _ pero de esta forma queda mas claro que es lo que no estoy usando
init(_Args) -> {ok,[]}.


handle_call( {translate,"hola"}, _From, History) ->
  {reply, "hello", ["hola" | History]};

handle_call( {translate,"mundo"}, _From, History) ->
  {reply,"world", ["mundo" | History]};

handle_call( {stats}, _From, History) ->
  {reply, History, History}.

handle_cast( {reset}, _History) ->
  {norelpy, []}.

code_change(_Old, State, _Extra) ->
  {ok, State}.

terminate(_Reason, _State) ->
  ok.

