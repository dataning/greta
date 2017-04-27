greta: probabilistic modelling with TensorFlow
==============================================

greta lets you write probabilistic models interactively in native R code, then sample from them efficiently using Hamiltonian Monte Carlo.

The computational heavy lifting is done by [TensorFlow](https://www.tensorflow.org/), Google's automatic differentiation library. greta is particularly fast where the model contains lots of linear algebra, and greta models can be easily set up to run across CPUs or GPUs, just by installing the relevant version of TensorFlow.

This package is in the early stages of development, so expect it to be buggy for a while. *It is not yet ready for use in serious analysis*.

Releases in the near future will implement more distributions and functions. Later releases will implement [different samplers](http://www.stat.columbia.edu/~gelman/research/published/nuts.pdf) and may enable fitting models with fast [approximate inference schemes](http://andrewgelman.com/2015/02/18/vb-stan-black-box-black-box-variational-bayes/) and running computations across a [distributed network](https://www.tensorflow.org/versions/r0.11/how_tos/distributed/index.html).

Example
-------

Here's an example of a Bayesian linear regression model applied to the iris data.

``` r
library(greta)

alpha = normal(0, 3)
beta = normal(0, 3, dim = 3)
sigma = lognormal(0, 3)

z <- alpha + iris[, 2:4] %*% beta
likelihood(iris[, 1]) = normal(z, sigma)
```

With the model defined, we can draw samples of the parameters we care about. This takes around 45 seconds on my laptop.

``` r
model <- define_model(alpha, beta, sigma)

draws <- mcmc(model,
              method = 'hmc',
              n_samples = 2000)
```

`draws` is an `mcmc.list` from the `coda` package, so you can plot and summarise the samples using your favourite MCMC visualisation software

``` r
library(MCMCvis)

MCMCtrace(draws, params = c('alpha', 'beta1', 'sigma'))
MCMCplot(draws)
```

<img src="README_files/figure-markdown_github/unnamed-chunk-3-1.png" width="400px" /><img src="README_files/figure-markdown_github/unnamed-chunk-3-2.png" width="400px" />

### How fast is it?

For small to medium size (a few hundred data points) problems, STAN is likely to be faster than greta. Where the model involves thousands of datapoints and large linear algebra operations (e.g. multiplication of big matrices), greta is likely to be faster than STAN. That's because TensorFlow is heavily optimised for linear algebra operations.

For example, while the code above takes around 100 seconds to run with the 150-row iris data, if you run the same model and sampler on a dataset of 150,000 rows, it still only takes around 200 seconds. That's not bad. Not bad at all.

Those numbers are on a laptop. Since TensorFlow can be run across large numbers of CPUs, or on GPUs, greta models can be made to scale to massive datasets. When greta is a bit more mature, I'll put together some benchmarks to give a clearer idea of how it compares with other modelling software.

### Installation

greta can be installed from GitHub using the devtools package

``` r
devtools::install_github('goldingn/greta')
```

however greta depends on TensorFlow which will need to be successfully installed before greta will work. See [here](https://www.tensorflow.org/install/) for instructions on installing TensorFlow

Why 'greta'?
------------

There's a recent convention of naming probabilistic modelling software after pioneers in the field (e.g. [STAN](https://en.wikipedia.org/wiki/Stanislaw_Ulam) and [Edward](https://en.wikipedia.org/wiki/George_E._P._Box)).

[Grete Hermann](https://en.wikipedia.org/wiki/Grete_Hermann) wasn't a probabilist, but she wrote [the first algorithms](http://dl.acm.org/citation.cfm?id=307342&coll=portal&dl=ACM) for computer algebra; in the 1920s, well before the first electronic computer was built. This work laid the foundations for computer algebra libraries (like TensorFlow) that enable modern probabilistic modelling.

In case that's not enough reason to admire her, Grete Hermann also [disproved a popular theorem in quantum theory](https://arxiv.org/pdf/0812.3986.pdf) and was part of the German resistance against the Nazi regime prior to World War Two.

Grete (usually said *Greh*•tuh, like its alternate spelling *Greta*) is pretty confusing for most non-German speakers pronounce, so I've taken the liberty of naming the package greta instead. You can call it whatever you like.
