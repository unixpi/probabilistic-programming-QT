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


(*
flip = Random.bool

Below we define a function flipN that encodes the outcome of the nth flip of a particular coin. There are a countably infinite number of such flips, each independent of all the others. The outcome of each, once determined, will always have the same value.
*)
		     
let flipN = mem(fun n -> flip ());;    
    
(*
In computer science memoization is an important technique for optimizing programs by avoiding repeated work. In the probabilistic setting, memoization actually affects the meaning of the memoized function.
*)

(* Bayesian Tug of War *)

let strength = mem(fun person -> gaussian 0.0 1.0)
let lazyy = (fun person -> bernoulli 0.25)

let pulling person =
     if (lazyy person = 1) then (strength person) /. 2.0 else strength person;;	      

let rec map f lst =
  match lst with
  | [] -> []
  | h :: t -> f h :: map f t

let rec sum lst =
  match lst with
  | [] -> 0.0
  | h :: t -> h +. sum t

let totalPulling team = sum (map pulling team);;

let winner team1 team2 =
  if totalPulling team1 < totalPulling team2 then team2 else team1

(* winner ["alice";"bob"] ["ted";"tom"];; *)
(* Notice that strength is memoized because this is a property of a person true across many matches, while lazy isn’t. Each time you run this program, however, a new “random world” will be created: people’s strengths will be randomly re-generated, then used in all the matches. *)							       

(* Cognition and conditioning *)							       
(* Generative models also enable reasoning in other directions. For instance, if we have a generative model in which X is the output of a process that depends on Y

we may ask: “assuming I have observed X, how must Y have been?” That is we can reason backward from outcomes to initial conditions. 

 In its most basic form, causal attribution is conditional inference: given some observed effects, what were the likely causes? Predictions are conditional inferences in the opposite direction: given that I have observed some known cause, what are its likely effects? These inferences can be described by conditioning a probabilistic program that expresses a causal model, or understanding of how effects depend on causes.
 *)

(* Hypothetical Reasoning with query *)							

let rec takeSample = (fun () ->
  let a = (if flip () then 1 else 0) in
  let b = (if flip () then 1 else 0) in
  let c = (if flip () then 1 else 0) in
  let d = a + b + c in
  if (d >= 2) then a else takeSample ()
  )

let rec fold_left f acc lst =
  match lst with
  | [] -> acc
  | h :: t -> fold_left f (f acc h) t

let percentage0 lst =
  float_of_int(fold_left (fun acc x -> if x = 0 then acc + 1 else acc) 0 lst) /. float_of_int(length lst)

let percentage1 lst = 1.0 -. (percentage0 lst)
(* percentage0 (repeat 100 takeSample) *)

(* Notice that we have used a stochastic recursion to sample the definitions repeatedly until we get d >= 2, and we then return A: we generate and test until the condition is satisfied. This process is known as rejection sampling; *)			       

let realData = 1 (* true *)

let prior = (fun () -> bernoulli 0.5)

let observe h = if h = 1 then bernoulli 0.9 else bernoulli 0.1

(* probability of hypothesis given observedData = data
   Another way of thinking of this (computationally):
   0) generate hypothesis
   1) generate data under current hypothesis
   2) check if this generated data is equal to observed data
   3) if so return current hypothesis value (success! current hypothesis managed to
      generate data indistinguishable from the real data)
   4) otherwise repeat (i.e generate a new hypothesis, and test it with real data)

   5) repeat the above process, 100s of times, storing all the return values
   --> this will give you the probability of each hypothesis tested being correct
*)			       

let takeSample = (fun () ->
    let hypothesis = prior () in
    let generatedDataUnderHypothesis = observe hypothesis in
    if generatedDataUnderHypothesis = realData then hypothesis else takeSample () )
		   
(* implementations of query 
   --much of the difficulty of implementing probabilistic languages / models
     is finding useful ways to do conditional inference - i.e to sample efficiently
*)

