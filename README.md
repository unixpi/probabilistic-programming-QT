# QT - A probabilistic-programming language

This is an attempt to learn more about probabilistic programming by creating my
own language.

The language is called QT and is based on the probabilistic programming language
called Church. For the time being I am following the Church tutorial found at http://v1.probmods.org/ and implementing the relevant functions in OCaml (see probability.ml)

# Simulations
I will also experiment with using simulations to provide answers to probability problems.

cancer-cluster.ml provides an answer to a problem on randomness posted by Nassim Nicholas Taleb on twitter.

wilensky.ml provides an answer to a counter-intuitive problem posed by the computer scientist Uri Wilensky.

# Motivations
I subscribe to the hypothesis that probabilistic programming could do for Bayesian machine learning what Theano and TensorFlow have done for neural networks.

Deep networks are all the rage right now not because they are some brilliant model,but because of the details of how we optimize them. See https://t.co/anGfjMU1F4

They are, at their core, deeply inelegant (and rather stupid) black-box solutions. In short, they don't know what they don't know.

In contrast, probabilistic programming uses beautiful and elegant methods from probability theory to automate machine learning in a way that allows the user to quantify uncertainty.

The challenge for probabilistic programming is to make Markov Chain Monte-Carlo methods as reliable as stochastic gradient descent now is for deep networks.

Faster computers combined with speed improvements to MCMC algorithms (see Persi Diaconis' paper https://projecteuclid.org/download/pdfview_1/euclid.bj/1377612852) mean thischallenge will likely be solved in the next 5-10 years.

# Resources (to be updated)
For more on MCMC see https://math.uchicago.edu/~shmuel/Network-course-readings/MCMCRev.pdf

For more on probabilistic programming see :