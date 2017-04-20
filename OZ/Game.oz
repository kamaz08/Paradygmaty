declare
fun {Player Name Entry DT}
   case Entry
   of H|T then
      {Delay DT}
      {Browse Name#H}
      if H=='pong' then 'ping'|{Player Name T DT}
      elseif H=='ping' then 'pong'|{Player Name T DT } end
   end
end

declare
proc {Game Pl1 Pl2}
   local P1 P2 in
      thread P1 = {Player Pl1 P2 100} end 
      thread P2 = 'pong'|{Player Pl2 P1 1000} end
   end
end

{Game 'ziom' 'niezxiom'}