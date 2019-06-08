
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
#> [1] 100.00000 101.28530 101.27799  98.89855  99.27722  97.31816
knitr::kable(head(Path100,10))
```

|     path1 |     path2 |     path3 |     path4 |     path5 |     path6 |     path7 |    path8 |     path9 |    path10 |
| --------: | --------: | --------: | --------: | --------: | --------: | --------: | -------: | --------: | --------: |
| 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.00000 | 100.0000 | 100.00000 | 100.00000 |
|  96.29663 |  99.42534 |  94.13160 | 101.54419 |  98.40329 | 104.63166 |  97.16100 | 100.0716 | 103.12666 |  99.20133 |
|  92.21547 |  97.85912 |  97.65704 |  99.31980 | 100.88840 | 103.08846 | 101.48596 | 106.5623 | 104.12503 | 101.77384 |
|  91.27924 |  96.94309 |  98.28728 |  97.13502 | 100.14344 | 105.61552 | 100.86194 | 116.8408 |  99.68115 | 100.45551 |
|  93.43147 | 102.23515 |  95.32894 |  99.41128 |  98.47941 | 104.13266 |  93.03570 | 116.9082 |  99.43701 | 105.20229 |
|  92.09561 |  99.73503 |  98.25180 | 103.42019 |  94.87310 | 102.62783 |  90.09111 | 111.0743 |  95.96988 | 105.93811 |
|  96.40398 |  99.49458 |  99.64422 | 109.19116 | 101.78678 |  94.81191 |  86.06863 | 107.7198 |  95.37261 | 105.54326 |
|  93.15126 | 101.00149 |  99.36599 | 111.00723 |  99.15677 |  86.97683 |  85.12907 | 111.2482 |  92.78822 | 107.28712 |
|  99.25390 | 105.62658 |  96.95822 | 109.90547 | 100.60062 |  87.78285 |  86.16681 | 116.2061 |  95.69383 | 112.97068 |
| 104.28692 | 107.48194 |  98.33510 | 108.13056 |  98.47853 |  87.37106 |  80.07122 | 110.5495 |  94.05884 | 108.14635 |

``` r
knitr::kable(Path100Terminal)
```

|        |         x |
| ------ | --------: |
| path1  | 265.63570 |
| path2  | 116.49457 |
| path3  |  83.07854 |
| path4  |  67.96923 |
| path5  |  72.54115 |
| path6  | 104.51031 |
| path7  | 154.80156 |
| path8  | 135.12695 |
| path9  |  98.19967 |
| path10 | 179.37457 |

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

This project is licensed under the GPL3 License
