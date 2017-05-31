-module(tree_traversal).
-export([left_rotation/1]).
-export([tnode/0, tnode/1, tnode/3]).
-export([example/0]).
-export([x/1]).
-export([v/1]).
-export([r/1]).
-export([l/1]).

tnode() -> {}.
tnode(V) -> {node,V, {}, {}}.
tnode(V,L,R) -> {node,V, L, R}.

v({node, V, _, _}) -> V.
r({node, _, _, R}) -> R.
l({node, _, L, _}) -> L.

left_rotation({node, V , L, R}) ->  [tnode(v(R),tnode(V, L, l(R)), r(R)) || R /= {}].


example() -> x(tnode(1,tnode(2),tnode(3))).

x(X) -> [X, left_rotation(X)].
