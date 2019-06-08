#' Title
#'
#' @param S0
#' @param K
#' @param mu
#' @param sigma
#' @param time
#' @param paths
#' @param ds
#'
#' @return
#' @export
#'
#' @examples
#' MCForward(100,100,0.02,0.25,1,100)
MCForward <- function(S0, K, mu, sigma, time, paths, ds=0.00001){
    z <- rnorm(paths, mean=0, sd=1)

    STB <- S0*exp((mu-sigma^2/2)*time + sigma*sqrt(time)*z)
    STA <- (S0+ds)*exp((mu-sigma^2/2)*time+sigma*sqrt(time)*z)

    PayoffB <- pmax(0, STA-K)*exp(-mu*T)
    PayoffA <- pmax(0, STB-K)*exp(-mu*T)

    EPA <- mean(PayoffB)
    EPB <- mean(PayoffA)

    delta <- (EPA-EPB)/ds

    return(delta)
}


#' Title
#'
#' @param S0
#' @param K
#' @param mu
#' @param sigma
#' @param time
#' @param paths
#' @param ds
#'
#' @return
#' @export
#'
#' @examples
#' MCCentral(100,120,0.01,0.25,1,1000)
MCCentral <- function(S0, K, mu, sigma, time, paths, ds=0.00001){
    z <- rnorm(paths, mean=0, sd=1)

    STI <- (S0+ds)*exp((mu-sigma^2/2)*time + sigma*sqrt(time)*z)
    STD <- (S0-ds)*exp((mu-sigma^2/2)*time + sigma*sqrt(time)*z)

    PayOffI <- pmax(0,STI-K)*exp(-mu*T)
    PayOffD <- pmax(0,STD-K)*exp(-mu*T)

    EPI <- mean(PayOffI)
    EPD <- mean(PayOffD)

    delta <- (EPI-EPD)/2/ds

    return(delta)
}

MCDiffGamma <- function(S0, K, mu, sigma, time, paths, ds=0.00001){
    # random generator should be the same for 3 processes below
    z <- rnorm(paths, mean=0, sd=1)

    STI <- (S0+ds)*exp((mu-sigma^2/2)*time + sigma*sqrt(time)*z)
    STD <- (S0-ds)*exp((mu-sigma^2/2)*time + sigma*sqrt(time)*z)
    STC <- (S0)*exp((mu-sigma^2/2)*time + sigma*sqrt(time)*z)

    PayOffI <- pmax(0,STI-K)*exp(-mu*T)
    PayOffD <- pmax(0,STD-K)*exp(-mu*T)
    PayOffC <- pmax(0,STC-K)*exp(-mu*T)

    EPI <- mean(PayOffI)
    EPD <- mean(PayOffD)
    EPC <- mean(PayOffC)

    gamma <- (EPI-2*EPC+EPD)/(ds^2)

    return(list(EPI,EPD,EPC,round(gamma,4)))
}


b <- MCDiffGamma(100, 100, 0.02, 0.25, 0.5, 10000, 0.01)
b

a <- NULL
for (t in 1:10){
    x <- MCDiffGamma(100, 100+t, 0.02, 0.25, 1, 1000, 0.01)
    a <- c(a,x[[4]])
}
a
