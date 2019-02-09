
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fineng

The package provides routines to calculate option prices using different
closed-form solutions and simulations

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
#> [1] 100.00000  93.41985  96.18356  96.81868  96.96415  95.48042
knitr::kable(head(Path100,10))
```

|     path1 |    path2 |     path3 |    path4 |     path5 |     path6 |    path7 |     path8 |    path9 |    path10 |
| --------: | -------: | --------: | -------: | --------: | --------: | -------: | --------: | -------: | --------: |
| 100.00000 | 100.0000 | 100.00000 | 100.0000 | 100.00000 | 100.00000 | 100.0000 | 100.00000 | 100.0000 | 100.00000 |
|  96.19331 | 104.4913 |  99.18652 | 101.1312 |  95.96356 |  97.01996 | 100.9319 | 100.97981 | 100.0711 | 101.21489 |
|  94.69472 | 106.3058 | 102.32450 | 101.6464 |  91.06444 | 102.75269 | 103.2029 |  99.21527 | 100.8700 |  98.82544 |
|  99.38191 | 103.4600 |  99.67684 | 101.2766 |  90.54323 |  98.75868 | 104.6657 |  99.76454 | 100.6603 |  94.19796 |
| 102.59096 | 105.6592 |  98.76436 | 103.5950 |  89.32847 |  98.61576 | 104.0166 | 100.28244 | 103.1335 |  93.19057 |
| 101.93010 | 105.2799 |  99.51088 | 108.3976 |  89.98726 |  99.32266 | 101.1323 |  96.70746 | 103.3998 |  90.58159 |
| 104.80041 | 111.2833 | 101.67089 | 104.3657 |  94.01227 |  96.61167 | 102.3036 |  95.18108 | 104.3520 |  83.98584 |
| 101.70698 | 100.9409 |  99.74928 | 100.2088 |  94.25133 |  97.78480 | 101.6565 |  95.46501 | 103.5440 |  83.35984 |
| 105.40823 | 106.6780 | 103.86169 | 105.6465 |  95.86444 | 101.34460 | 104.3776 |  97.13878 | 103.9828 |  82.08305 |
| 104.42082 | 113.8731 | 106.32331 | 103.4101 |  87.84965 |  98.23863 | 101.1071 |  99.08435 | 101.8472 |  77.73228 |

``` r
knitr::kable(Path100Terminal)
```

|        |         x |
| ------ | --------: |
| path1  | 189.15720 |
| path2  |  54.84353 |
| path3  | 117.02810 |
| path4  | 118.99677 |
| path5  | 187.20881 |
| path6  | 163.03503 |
| path7  |  91.53301 |
| path8  |  80.59166 |
| path9  |  60.29002 |
| path10 | 123.51754 |

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
result <- HestonPriceMP(PutCall, S, K, tau, r, q, kappa, theta, sigma, lambda, v0, rho, N, a, b)
print(result)
#> [1] 4.92679

### Comparison with Black-Scholes model

BLresult <- BlackScholes("Call",S = 100, K = 100, tau = 0.5, r = 0.03, q = 0.02, sigma = 0.25)
print(BLresult)
#> [1] 7.194322
```

## Citation

  - Glasserman, Paul. Monte Carlo methods in financial engineering. Vol.
    53. Springer Science & Business Media, 2013.
  - Jäckel, Peter. Monte Carlo methods in finance. J. Wiley, 2002.
  - Heston, Steven L. “A closed-form solution for options with
    stochastic volatility with applications to bond and currency
    options.” The review of financial studies 6.2 (1993): 327-343.
