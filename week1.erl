-module(week1).
-export([bits/1, perimeter/1, area/1, enclose/1]).

bits(N) ->
  bits(N, 0).

bits(0, S) ->
  S;
bits(N, S) when N rem 2 == 0 ->
  bits(N div 2, S);
bits(N, S) ->
  bits(N - 1, S + 1).
%% > bits(8)
%% 1 (100)
%% > bits(15)
%% 4 (1111)

perimeter({circle, _Center, R}) ->
  2 * math:pi() * R;
perimeter({rectangle, _Center, H, W}) ->
  2 * (H + W);
perimeter({triangle, P1, P2, P3}) -> % where P1, P2, P3 are coordinates
  distance(P1, P2) + distance(P2, P3) + distance(P3, P1).
%% > perimeter({triangle, {0,0}, {4, 0}, {0, 3}}).
%% 12.0 (Pythagoras tells us the final side is length 5, so this checks out)

area({triangle, {X1, Y1}, {X2, Y2}, {X3, Y3}}) ->
  abs((X1 - X3) * (Y2 - Y1) - (X1 - X2) * (Y3 - Y1)) / 2. % shoelace formula

enclose({rectangle, Center, H, W}) ->
  {rectangle, Center, H, W};
enclose({circle, Center, R}) ->
  Side = 2 * R,
  {rectangle, Center, Side, Side};
%% > enclose({circle, {0, 0}, 1})
%% {rectangle,{0,0},2,2}

enclose({triangle, {X1, Y1}, {X2, Y2}, {X3, Y3}}) ->
  Top = max(max(Y1, Y2), Y3),
  Right = max(max(X1, X2), X3),
  Bottom = min(min(Y1, Y2), Y3),
  Left = min(min(X1, X2), X3),
  Center = {(Right + Left) / 2, (Top + Bottom) / 2},
  {rectangle, Center, Top - Bottom, Right - Left}.
%% > enclose({triangle, {0, 0}, {3, 0}, {0, 3}}).
%% {rectangle,{1.5,1.5},3,3}
%% > enclose({triangle, {0, 0}, {5, 1}, {3, 6}}).
%% {rectangle,{2.5,3.0},6,5}
%% > enclose({triangle, {1, 0}, {5, 1}, {3, 6}}).
%% {rectangle,{3.0,3.0},6,4}

distance({X1, Y1}, {X2, Y2}) ->
  math:sqrt(math:pow(X2 - X1, 2) + math:pow(Y2 - Y1, 2)).
