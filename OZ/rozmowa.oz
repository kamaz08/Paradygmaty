declare
proc {ParseResponce In Proc Interlokutor}
   case In
   of H|T then
      {Delay 1000}
      {Browse H}
      {Send Interlokutor {Proc H}}
      {ParseResponce T Proc Interlokutor}
   end
end
declare
fun {Rozmowca Proc Interlokutor}
   Data in
   thread {ParseResponce Data Proc Interlokutor} end
   {NewPort Data}
end

declare R1 R2 in
R1={Rozmowca fun {$ X} X+1 end R2}
R2={Rozmowca fun {$ X} X-1 end R1}

{Send R1 0}