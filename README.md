# QT - A probabilistic-programming language

This is an attempt to learn more about probabilistic programming by creating my
own language.

The language is called QT and is based on the probabilistic programming language
called Church. For the time being I am following the Church tutorial found at http://v1.probmods.org/ and implementing the relevant functions in OCaml (see probability.ml)

# Simulations
I will also occasionally experiment with using simulations to provide answers to probability problems.

https://github.com/sachaysl/probabilistic-programming-QT/blob/master/cancer-cluster.ml  provides an answer to a problem on randomness posted by Nassim Nicholas Taleb on twitter : **You throw 8 darts uniformly randomly on a 2D map with 16 squares.
   what is the probability of getting 3 dots in a single square (any square?)**

https://github.com/sachaysl/probabilistic-programming-QT/blob/master/wilensky.ml provides an answer to a counter-intuitive problem posed by the computer scientist Uri Wilensky :  **Imagine a room full of 100 people with 100 dollars each. With every tick of the clock, every person with money gives a dollar to one randomly chosen other person. After some time progresses, how will the money be distributed?**

# Motivations
I subscribe to Ferenc Huszár's hypothesis that probabilistic programming could do for Bayesian machine learning what Theano and TensorFlow have done for neural networks.

Deep networks are all the rage right now not because they are some brilliant model,but because of the details of how we optimize them. See https://t.co/anGfjMU1F4

They are, at their core, deeply inelegant (and rather stupid) black-box solutions. In short, they don't know what they don't know. See https://www.youtube.com/watch?v=XaQu7kkQBPc and https://www.technologyreview.com/s/604087/the-dark-secret-at-the-heart-of-ai/

In contrast, **probabilistic programming uses beautiful and elegant concepts from probability theory to automate machine learning in a way that allows the user to quantify uncertainty.**

The ultimate challenge for probabilistic programming is to make markov chain monte-carlo methods as reliable as stochastic gradient descent now is for deep networks.

# Inventing the software for the computing environment of the future
Faster computers combined with speed improvements to MCMC algorithms (see Persi Diaconis' paper https://projecteuclid.org/download/pdfview_1/euclid.bj/1377612852) mean this challenge has a good chance of being met in the next 5-10 years.



# Resources (to be updated)
For more on MCMC see https://math.uchicago.edu/~shmuel/Network-course-readings/MCMCRev.pdf

For an overview probabilistic programming see https://www.youtube.com/watch?v=-8QMqSWU76Q&t=2s