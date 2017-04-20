declare
fun {Merges L1 L2}
   case L1 of nil then L2
   [] H1|T1 then 
      case L2 of nil then nil  
      [] H2|T2 then
	 if H1 < H2 then H1|{Merges T1 L2}
	 else H2|{Merges T2 L1} end 
      end
   end
end

declare
fun {Merge L1 L2 L3}
   {Merges L1 {Merges L2 L3}}
end

X=[1 8 10]
Y=[4 5 11]
Z=[2 6 9]

{Browse {Merge X Y Z }}