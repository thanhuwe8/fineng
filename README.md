
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fineng

The package provides routines to calculate option prices using different
closed-form solutions and simulations

## Installation

You can install the released version of fineng with

``` r
devtools::install_github("fineng")
```

## Plan for development

We plan to add the following features in the next releases:

  - Heston Model with Newton-Cotes and Gaussian Quadrature (only
    Mid-point rule is currently supported)
  - Simulation of symmetric random walk, scaled random walk, Brownian
    motion and Jump Diffusion Process.
  - Brownian Bridge
  - American Option Pricing using Monte Carlo simulation

## Usage

``` r
### Load library
library(fineng)

### Necessary Paramters
PutCall<- "Call"
S=100
K=100
tau=0.5
r=0.03
q=0.02
kappa=0.2
theta=0.25
sigma=0.3
lambda=0
v0=0.02
rho=-0.8
N=1000
a=1e-5
b=100

### Heston Price using Mid-point integration rule

result <- HestonPriceMP(PutCall,S,K,tau,r,q,kappa,theta,sigma,lambda,v0,rho,N,a,b)
print(result)
#> [1] 4.92679
```

``` r
### Comparison with Black-Scholes model

BLresult <- BlackScholes("Call",S=100, K=100,tau=0.5,0.03,0.02,0.25)
print(BLresult)
#> [1] 7.194322
```
