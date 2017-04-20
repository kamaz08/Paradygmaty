declare
fun {FoldAppend L1 L2}
   {FoldR L1 fun {$ A B} A|B end L2}
end
declare
fun {FoldReverse L}
   {FoldL L fun {$ A B} B|A end nil} 
end

X=[1 2]
Y=[3 4]
{Browse {FoldReverse {FoldAppend X Y}}}