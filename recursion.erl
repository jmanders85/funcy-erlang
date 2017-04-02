-module(recursion).
-export([fib/1, pieces/1, sumtorial/1, perfect/1]).

fib(X) ->
  fib(X, 0, 1).

pieces(0) ->
  1;
pieces(X) when X > 0 ->
  X + pieces(X-1).

sumtorial(X) ->
  sumtorial(X, 0).

sumtorial(0, S) ->
  S;
sumtorial(N, S) ->
  sumtorial(N-1, S+N).

fib(1, F, _) ->
  F;
fib(X, F, S) when X > 1 ->
  fib(X-1, S, F+S).

perfect(N) when N > 1 ->
  perfect(N, N-1, 0).

perfect(N, 0, S) ->
  N == S;
perfect(N, D, S) when N rem D == 0 ->
  perfect(N, D-1, S+D);
perfect(N, D, S) ->
  perfect(N, D-1, S).
