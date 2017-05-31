k(a, b). k(a, d). k(b, c). k(b, e). k(c, f). k(d, e). k(d, g). k(e, f). k(e, h). k(f, i). k(g, h). k(h, i).

is_path(X, Y) :- path(X, Y, []).

path(X, X, _).

path(X, Y, _) :- k(X, Y).

path(X,Y,Path) :- 	k(X, Z),
		  			\+ member(Z, Path),
		  			path(Z, Y, [X | Path]).


