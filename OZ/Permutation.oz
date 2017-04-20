declare
proc {Permutation L L1 L2}
   case L of nil then if L1 == nil then {Browse L2} else skip end
   [] X|Xs then  {Permutation {Append Xs L1} nil {Append L2 [X]}} {Permutation Xs X|L1 L2} 
   end
end
	 

X=[1 2 3 4]

{Permutation [0 1 2 4] nil nil}
