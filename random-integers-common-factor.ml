(*
What is the probability of four random integers having a common factor?
 *)

(* implementation of the Sieve of Eratosthenese
   we use 0 to denote struck-out numbers.
   could be made more efficient by choosing to strike out multiples
   above p^2 rather than p
*)

let rec strike_nth k n l = match l with
  | [] -> []
  | h :: t ->
     if k = 0 then 0 :: strike_nth (n-1) n t
     else h :: strike_nth (k-1) n t;;
