declare
fun {Reverse L}
   case L
   of nil then nil
   [] X|Xs then {Append{Reverse Xs}|[X]}
   end
end
X = {Reverse [1 2 3 4 5 6]}
{Browse X}
