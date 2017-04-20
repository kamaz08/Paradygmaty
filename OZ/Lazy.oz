declare
fun lazy {Times N H}
   case H of X|H2 then N*X|{Times N H2} end
end
fun lazy {Merge Xs Ys}
   case Xs#Ys of (X|Xr)#(Y|Yr) then
      if X<Y then X|{Merge Xr Ys}
      elseif X>Y then Y|{Merge Xs Yr}
      else X|{Merge Xr Yr}
      end
   end
end

proc {Touch N H}
   if N>0 then {Touch N-1 H.2} else skip end
end


fun {Test K H}
   case K of nil then {Times 2 H} 
   []H1|T then {Merge {Times H1 H} {Test T H}}
   end
end


/*H=1|{Merge {Times 2 H} {Merge {Times 3 H} {Times 5 H}}}
{Touch 20 H}
*/

fun {Sieve Xs N W}
   if N == 0 then W else
   case Xs of nil then nil
   [] X|Xr then Ys in
      thread Ys = {Filter Xr fun {$ Y} Y mod X \= 0 end} end
       {Sieve Ys N-1 X|W}
   end
   end
end

fun lazy {Generate S}
   S|{Generate S+1}
end

proc {Touch2 N H}
   if N>0 then {Touch2 N-1 H.2} else skip end
end


{Browse {Sieve {Generate 2} 4 nil}}
H = 1| {Test {Sieve {Generate 2} 1 nil} H}
{Browse H}
{Touch 200 H}


 