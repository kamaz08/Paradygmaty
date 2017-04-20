declare
fun {NSort2 F L}
   case L of nil then [F]
   [] H|T then
      if F < H then F|L
      else H|{NSort2 F T}
      end
   end
end
declare
fun {NSort L Result}
   case L of nil then Result
   [] H|T then {NSort T {NSort2 H Result}}
   end
end

X=[2  4 1 6  2 90 23 ]
{Browse {NSort X nil}}