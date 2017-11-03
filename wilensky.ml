(*
Imagine a room full of 100 people with 100 dollars each. With every tick of the clock, every person with money gives a dollar to one randomly chosen other person. After some time progresses, how will the money be distributed?
*)

let rec generate n m =
  match n with
  | 0 -> []
  | n -> m :: generate (n-1) m


(* fix this --> need to backwards in list before giving money *)		       
let rec tick people =
  match people with
  | [] -> []
  | h :: t -> if h > 0 then (h-1) :: tick (add1 people (Random.int 100))
	      else h :: tick t
		
let rec add1 people i =
  match i, people with
  | 0, h :: t -> (h+1) :: t
  | _, h :: t -> h :: add1 t (i-1)
  
  
				
  


