declare
fun {FindAll T}
   case T of
      leaf then nil
   [] tree(Key Val L R) then
      {Append {FindAll L} Key#Val|{FindAll R}}
   end
end

S=tree(250 top tree(150 left tree(100 lastleft leaf leaf) leaf) tree(300 right leaf leaf))
{Browse {FindAll S}}