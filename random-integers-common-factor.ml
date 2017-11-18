(*
What is the probability of four random integers having a common factor?
 *)

(* implementation of the Sieve of Eratosthenese
   we use 0 to denote struck-out numbers.
   could be made much more efficient
   but remember, premature efficiency is the root of all evil!
*)


let rec filter f lst =
  match lst with
  | [] -> []
  | h :: t -> if f h  then h :: filter f t else filter f t

let rec map f lst =
  match lst with
  | [] -> []
  | h :: t -> f h :: map f t
			 
let primes n =
  let limit = truncate(sqrt(float n)) in
  let rec range a b = if a > b then [] else a :: range (a+1) b in
  let rec sieve_primes l = match l with
    | [] -> []
    | 0 :: t -> sieve_primes t
    | h :: t -> if h > limit then l else
		  h :: sieve_primes (map (fun x -> if x mod h = 0 then 0 else x) t) in
  sieve_primes (range 2 n);;
						       
