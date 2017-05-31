-module(z1).
-export([pythag/1]).

pythag(D) ->
	[ 	{A, B, C} ||
	 	A <- lists:seq(1, D div 2),
		B <- lists:seq(1, A),
		C <- lists:seq(trunc(math:sqrt(A * A + B * B)), trunc(math:sqrt(A * A + B * B))),
		A + B + C == D,
		A * A + B * B == C * C
	].

