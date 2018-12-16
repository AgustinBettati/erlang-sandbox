
-module(recursion).
-author("agustin").

%% API
-export([length/1]).
-export([factorial/1]).
-export([reverse_list/1]).


length(List) -> length(List, 0).

length([], Accum) -> Accum;
length([_|Tail], Accum) -> length(Tail, Accum + 1).


factorial(Number) -> factorial(Number, 1).

factorial(0, Accum) -> Accum;
factorial(Number, Accum) -> factorial(Number - 1, Accum * Number).


reverse_list(List) -> reverse_list(List, []).

reverse_list([], List ) -> List;
reverse_list([Head | Tail], List) -> reverse_list(Tail, [Head | List]).


