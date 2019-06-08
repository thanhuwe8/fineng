
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
#> [1] 100.00000 101.46285  99.23115  96.40964  97.50985  94.35140
knitr::kable(head(Path100,10))
```

|     path1 |    path2 |     path3 |     path4 |     path5 |     path6 |     path7 |     path8 |    path9 |    path10 |
| --------: | -------: | --------: | --------: | --------: | --------: | --------: | --------: | -------: | --------: |
| 100.00000 | 100.0000 | 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.0000 | 100.00000 |
|  97.20882 | 101.3153 | 101.81134 | 100.82097 |  98.88181 |  97.27842 |  99.05897 |  99.92529 | 105.8130 |  99.17678 |
|  96.61402 |  99.6909 | 102.75702 | 102.67128 |  94.33503 | 101.59420 | 101.78785 |  98.16221 | 113.9906 | 100.62739 |
|  99.92706 | 101.5911 |  96.06443 | 102.06301 |  90.82164 | 104.79206 |  99.51293 |  92.85462 | 108.1960 | 100.74814 |
|  97.26076 | 100.5079 | 101.40123 | 106.78207 |  91.06393 | 108.65457 | 103.21806 |  95.41177 | 111.4782 | 100.01623 |
|  94.67870 | 101.0188 | 104.71646 | 107.89879 |  92.88828 | 109.36269 |  99.16786 |  92.36198 | 105.6355 |  98.06686 |
|  90.79961 | 104.5467 | 104.32567 | 102.51939 |  94.88985 | 114.59288 |  94.56244 |  91.41442 | 105.6164 |  95.67748 |
|  86.68484 | 109.0609 | 102.35646 |  98.19254 |  93.36013 | 119.80777 |  97.67334 |  87.99997 | 105.1425 | 101.93094 |
|  94.32117 | 108.7304 | 107.21975 | 100.43676 |  98.27238 | 118.63984 |  98.21168 |  88.26490 | 105.4838 | 104.41411 |
|  94.02495 | 106.9422 | 115.15461 |  96.47669 | 104.56560 | 116.41379 |  91.57951 |  89.51063 | 101.9723 | 109.50796 |

``` r
knitr::kable(Path100Terminal)
```

|        |         x |
| ------ | --------: |
| path1  | 114.00677 |
| path2  |  41.34848 |
| path3  | 120.27406 |
| path4  |  75.45667 |
| path5  |  83.48243 |
| path6  | 122.67708 |
| path7  | 131.99039 |
| path8  |  76.74352 |
| path9  | 116.79825 |
| path10 |  41.82158 |

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

## License

This project is licensed unnder the GPL3 License
