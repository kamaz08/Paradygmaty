declare 
proc {NewPortObjects ?AddPortObject ?Call}
   Sin P={NewPort Sin}
   proc {MsgLoop S1 Procs}
      case S1
      of msg(I M)|S2 then
	 try {Procs.I M} catch _ then skip end
	 {MsgLoop S2 Procs}
      [] add(I Proc Sync)|S2 then Procs2 in
	 Procs2={AdjoinAt Procs I Proc}
	 Sync=unit
	 {MsgLoop S2 Procs2}
      [] nil then skip end
   end
in
   proc{AddPortObject I Proc}
   Sync in
      {Send P add(I Proc Sync)}
      {Wait Sync}
   end
   proc {Call I M}
      {Send P msg(I M)}
   end
   thread {MsgLoop Sin procs} end
end


declare 
fun {NewPortObject Init Fun}
   proc {MsgLoop S1 State}
      case S1 of Msg|S2 then
	 {MsgLoop S2 {Fun Msg State}}
      [] nil then skip end
   end
   Sin
in
   thread {MsgLoop Sin Init} end
   {NewPort Sin}
end

declare 
fun {NewPortObject2 Proc}
Sin in
   thread for Msg in Sin do {Proc Msg} end end
   {NewPort Sin}
end

declare AddPortObject Call
{NewPortObjects AddPortObject Call}

fun {Timer}
   {NewPortObject2
    proc {$ Msg}
       case Msg of starttimer(T Pid) then
	  thread {Delay T} {Send Pid stoptimer} end
       end
    end}
end
declare
fun {Controller Init}
   Tid={Timer}
   Cid={NewPortObject Init
	fun {$ Msg state(Motor F Lid)}
	   case Motor
	   of running then
	      case Msg
	      of stoptimer then
		 {Send Lid 'at'(F)}
		 state(stopped F Lid)
	      end
	   [] stopped then
	      case Msg
	      of step(Dest) then
		 if F==Dest then
		    state(stopped F Lid)
		 elseif F<Dest then
		    {Send Tid starttimer(5000 Cid)}
		    state(running F+1 Lid)
		 else % F>Dest
		    {Send Tid starttimer(5000 Cid)}
		    state(running F-1 Lid)
		 end
	      end
	   end
	end}
in Cid end
fun {Floor Num Init Lifts}
   Tid={Timer}
   Fid={NewPortObject Init
	fun {$ Msg state(Called)}
	   case Called
	   of notcalled then Lran in
	      case Msg
	      of arrive(Ack) then
		 {Browse 'Lift at floor '#Num#': open doors'}
		 {Send Tid starttimer(5000 Fid)}
		 state(doorsopen(Ack))
	      [] call then
		 {Browse 'Flor '#Num#' calls a lift!'}
		 Lran=Lifts.(1+{OS.rand} mod {Width Lifts})
		 {Send Lran call(Num)}
		 state(called)
	      end
	   [] called then
	      case Msg
	      of arrive(Ack) then
		 {Browse 'Lift at floor '#Num#': open doors'}
		 {Send Tid starttimer(5000 Fid)}
		 state(doorsopen(Ack))
	      [] call then
		 state(called)
	      end
	   []  doorsopen(Ack) then
	      case Msg
	      of stoptimer then
		 {Browse 'Lift at flot '#Num#': close doors'}
		 Ack=unit
		 state(notcalled)
	      [] arrive(A) then
		 A = Ack
		 state(doorsopen(Ack))
	      [] call then
		 state(doorsopen(Ack))
	      end
	   end
	end}
in Fid end

declare
fun {ScheduleLast L N}
   if L\=nil andthen {List.last L}==N then L
   else {Append L [N]} end
end

declare 
fun {Lift Num Init Cid Floors}
   {NewPortObject Init
    fun {$ Msg state(Pos Sched Moving)}
       case Msg
       of call(N) then
	  {Browse 'Lift '#Num#' needed at floor '#N}
	  if N ==Pos andthen {Not Moving} then 
	     {Wait {Send Floors.Pos arrive($)}}
	     state(Pos Sched false)
	  else  Sched2 in
	     Sched2={ScheduleLast Sched N}
	     if {Not Moving} then
		{Send Cid step(N)} end
	     state(Pos Sched2 true)
	  end
       []  'at'(NewPos) then
	  {Browse 'Lift'#Num#' at floor '#NewPos}
	  case Sched
	  of S|Sched2 then
	     if NewPos==S then
		{Wait {Send Floors.S arrive($)}}
		if Sched2==nil then
		   state(NewPos nil false)
		else
		   {Send Cid step(Sched2.1)}
		   state(NewPos Sched2 true)
		end
	     else
		{Send Cid step(S)}
		state(NewPos Sched Moving)
	     end
	  end
       end
    end}
end
declare 
fun {LiftShaft I state(F S M) Floors}
   Cid={Controller state(stopped F Lid)}
   Lid={Lift I state(F S M) Cid Floors}
in Lid end
declare 
proc {Building FN LN ?Floors ?Lifts}
   Lifts={MakeTuple lifts LN}
   for I in 1..LN do Cid in
       Lifts.I=  {LiftShaft I state(1 nil false) Floors}
   end
   Floors={MakeTuple floors FN}
   for I in 1..FN do
      Floors.I={Floor I state(notcalled) Lifts}
   end
end

declare F L in
{Building 20 1 F L}
{Send F.20 call}
{Send F.4 call}
{Send F.10 call}
{Send F.15 call}

