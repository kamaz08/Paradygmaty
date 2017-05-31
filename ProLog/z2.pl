jednokrotnie(X,L1):- select(X,L1,L2), \+ (select(X,L2,_)).
dwukrotnie(X,L1):- select(X,L1,L2), jednokrotnie(X,L2).
