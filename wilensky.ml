(*
Imagine a room full of 100 people with 100 dollars each. With every tick of the clock, every person with money gives a dollar to one randomly chosen other person. After some time progresses, how will the money be distributed?

To Run -> List.sort compare (simulate_result 20000)
*)

let simulate_result = (fun n -> repeat (generate 100 100) n);;
      
let rec repeat people n =
  match n with
  | 0 -> people
  | _ -> repeat (tick people 99) (n-1)

let rec generate n m =
  match n with
  | 0 -> []
  | n -> m :: generate (n-1) m


let rec tick people n =
  match n with
  | -1 -> people
  | _ -> if (nth people n) > 0 then
	   tick (update_plus (update_minus people n) (Random.int 100)) (n-1)
	 else
	   tick people (n-1)	     

let rec nth lst n =
  match lst, n with
  | h :: t, 0 -> h
  | h :: t, _ -> nth t (n-1)
       
let update_plus lst pos = List.mapi (fun i x -> if i = pos then x + 1 else x) lst
let update_minus lst pos = List.mapi (fun i x -> if i = pos && x > 0 then x - 1 else x) lst				    
  
				
  


