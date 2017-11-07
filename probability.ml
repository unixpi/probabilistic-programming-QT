let bernoulli p =
  let flip = Random.float 1.0 in
  if flip < p then 1 else 0

let rec geometric p =
  match bernoulli p with
  | 1 -> 1
  | 0 -> 1 + geometric p

let flip = Random.bool
	
(* 
Leva - 1992 - A fast normal random number generator
http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.544.5806&rep=rep1&type=pdf
*)
let rec gaussian u s =
  let u = Random.float 1.0 in
  let v = Random.float 1.0 in
  let v = 1.7156 *. (v -. 0.5) in (* this scales v to be uniform in -+sqrt(2/3) *)
  let x = u -. 0.449871 in
  let y = abs_float(v) +. 0.386595 in
  let q = x *. x +. y *. (0.196 *. y -. 0.25472 *. x) in
  if q >= 0.27597 && ( q > 0.27846 || v *. v > -4.0 *. u *. u *. log(u)) then
    gaussian u s
  else
    u +. s *. v /. u;;     

let rec repeat n x =
  match n with
  | 0 -> []
  | _ -> x() :: repeat (n-1) x

let twoGaussians = (fun ()-> (gaussian 0.0 1.0) *. (gaussian 0.0 1.0));;
  
let power a b =
  match b with
  | 0 -> 1
  | _ -> a * power a (b-1)

let fairCoin = (fun() -> ( if (flip ()) then "h" else "t"))
let trickCoin = (fun() -> ( if (bernoulli 0.95 = 1) then "h" else "t"))

let makeCoin w = (fun() -> (if (bernoulli w = 1) then "h" else "t"))

(* Prediction, Simulation, and Probabilities *)

let randomPair = (fun()-> [flip(); flip()]);;

(* stochastic recursion *)
let rec length lst =
  match lst with
  | [] -> 0
  | h :: t -> 1 + length t

let rec nth lst n =
  match lst, n with
  | h::t, 0 -> h
  | h::t, n -> nth t (n-1)

let uniformDraw lst =
  let draw = Random.int (length lst) in nth lst draw;;

let eyeColor person = uniformDraw ["blue";"green";"brown"];;

(* List.assoc "three" [("one", 1); ("two",2); ("three",3)];; *)  

let mem f =
  let m = ref [] in
  fun x ->
    try
      List.assoc x !m
    with
      Not_found ->
        let y = f x in
          m := (x, y) :: !m ;
          y

(* n.b. There is a problem with the above mem if f is recursive. Once memo calls f to compute f x, any recursive calls made by f will not be intercepted by mem. *)

let eyeColorMem = mem(fun person -> uniformDraw ["blue";"green";"brown"])

(*
This type of modeling is called random world style (McAllester, Milch, & Goodman, 2008). Note that we don’t have to specify ahead of time the people whose eye color we will ask about: the distribution on eye colors is implicitly defined over the infinite set of possible people, but only constructed “lazily” when needed. Memoizing stochastic functions thus provides a powerful toolkit to represent and reason about an unbounded set of properties of an unbounded set of objects.
*)


    
    
    
    
  
  
