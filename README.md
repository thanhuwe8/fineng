
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fineng

The package provides routines to calculate option prices using different
closed-form solutions and Monte-Carlo simulations based on different
stochastic motions

## Installation

You can install the released version of fineng with

``` r
devtools::install_github("fineng")
```

## New Updates on February 2019

  - Simulation for Contiuous and Discrete Geometric Brownian Motion
  - Finite-Difference Approximations, Pathwise derivative and Likelihood
    Ratio method for Option Greeks
  - Control Variates, Antithetic Variates and Stratified Sampling

## Plan for development

We plan to add the following features in the next releases:

  - Heston Model with Newton-Cotes and Gaussian Quadrature (only
    Mid-point rule is currently supported)
  - Simulation of symmetric random walk, scaled random walk and Jump
    Diffusion Process.
  - Brownian Bridge
  - American Option Pricing using Monte Carlo simulation
  - Rcpp for high-performance computation.

## Usage

### Geometric Brownian Motion Simulation

``` r
library(fineng)
SinglePath <- SimGBM(100,0.03,0.25,2,100,"discrete")
Path100 <- SimDGBM(100,0.03,0.25,2,100,10,"continuous")
Path100Terminal <- SimTGBM(100,0.03,0.25,2,100,10,"continuous")

head(SinglePath)
#> [1] 100.00000  99.77094  97.30455  96.73907  96.42876  93.44845
knitr::kable(head(Path100,10))
```

|    path1 |     path2 |    path3 |     path4 |    path5 |    path6 |     path7 |     path8 |    path9 |    path10 |
| -------: | --------: | -------: | --------: | -------: | -------: | --------: | --------: | -------: | --------: |
| 100.0000 | 100.00000 | 100.0000 | 100.00000 | 100.0000 | 100.0000 | 100.00000 | 100.00000 | 100.0000 | 100.00000 |
| 104.8057 | 102.01612 | 100.9655 |  98.46847 | 102.0476 | 104.3276 |  99.46464 |  99.40269 | 100.1546 |  97.71822 |
| 109.0810 | 102.56758 | 103.2136 |  99.11126 | 103.3167 | 103.7642 |  99.76942 | 100.72699 | 102.6213 |  99.39007 |
| 107.1664 |  98.70321 | 101.8388 | 103.43335 | 106.0049 | 102.1577 |  99.82029 | 106.91456 | 101.7146 |  95.72621 |
| 108.1781 |  99.18351 | 100.2044 | 110.65496 | 107.1868 | 103.9883 | 107.66740 | 110.76410 | 102.3578 |  93.47661 |
| 111.8222 |  98.35826 | 108.1750 | 113.38822 | 102.2459 | 106.5146 | 112.02468 | 108.95061 | 100.7211 |  90.24090 |
| 111.5003 |  99.48199 | 111.2556 | 109.55319 | 103.1345 | 109.1162 | 109.94397 | 106.87393 | 107.2631 |  97.56729 |
| 109.0544 | 107.49470 | 108.2428 | 108.11832 | 105.6024 | 110.9253 | 105.79359 | 100.77374 | 109.0869 |  92.87945 |
| 109.5999 | 107.55060 | 109.5928 | 114.40959 | 101.1466 | 108.0965 | 115.99372 | 107.13849 | 110.2590 |  96.48881 |
| 109.7035 | 101.62153 | 115.2596 | 109.76198 | 105.5610 | 110.0980 | 113.39150 | 102.36376 | 116.0735 |  99.61564 |

``` r
knitr::kable(Path100Terminal)
```

|        |         x |
| ------ | --------: |
| path1  |  67.67787 |
| path2  | 153.26264 |
| path3  | 117.15732 |
| path4  |  88.98489 |
| path5  | 106.47578 |
| path6  |  72.94793 |
| path7  | 111.17888 |
| path8  |  83.55075 |
| path9  |  87.48348 |
| path10 |  75.71381 |

### Heston model

``` r
### Necessary Paramters
PutCall <- "Call"
# Option Properties
S = 100
K = 100
tau = 0.5
r = 0.03
q = 0.02
# Heston model Properties
kappa = 0.2
theta = 0.25
sigma = 0.3
lambda = 0
v0 = 0.02
rho = -0.8
# Mid-point Properties
N = 1000
a = 1e-5
b = 100

### Heston Price using Mid-point integration rule
HestonPriceMP(PutCall, S, K, tau, r, q, kappa, theta, sigma, lambda, v0, rho, N, a, b)
#> [1] 4.92679

### Comparison with Black-Scholes model

BlackScholes("Call",S = 100, K = 100, tau = 0.5, r = 0.03, q = 0.02, sigma = 0.3)
#> [1] 8.582082
```

## Citation

  - Glasserman, Paul. Monte Carlo methods in financial engineering. Vol.
    53. Springer Science & Business Media, 2013.
  - Jäckel, Peter. Monte Carlo methods in finance. J. Wiley, 2002.
  - Heston, Steven L. “A closed-form solution for options with
    stochastic volatility with applications to bond and currency
    options.” The review of financial studies 6.2 (1993): 327-343.
