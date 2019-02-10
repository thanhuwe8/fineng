# Assumption:
# s0 = 100
# sigma = 0.30
# r = 0.05
# T = 0.1 or T = 0.5
# K = 90, 100, 110


#' Single Path Stock Price Simulation for Geometric Brownian Motion
#'
#' @param S0 Initial Stock Price
#' @param mu Annualized return in decimal format
#' @param sigma Annualized standard deviation in decimal format
#' @param time Time index (eg: 1,2,3,etc)
#' @param steps steps per Time Index (eg: 100, 200)
#' @param type "Continuous or Discrete"
#'
#' @return a vector of stock price based
#' @export
#'
#' @examples
#' SimGBM(100,0.03,0.25,2,100,"discrete")
SimGBM <- function(S0, mu, sigma, time, steps, type){

    type <- match.arg(type, c("continuous", "discrete"))

    dt <- time/steps
    ST <- rep(0,steps+1)
    ST[1] <- S0

    if (type=="continuous"){
        # continuous method suggested by Paul Glasserman
        z <- rnorm(steps, mean=0, sd=1)
        ST[2:length(ST)] <- exp((mu-sigma^2/2)*dt + sigma*sqrt(dt)*z)
        ST <- cumprod(ST)
    } else {
        # discrete method suggested by John C Hull
        for (i in 2:length(ST)){
            # Cannot pre-initialize due to dependence on ST
            # We use for-loop here, note for potential structural improvement
            ST[i] <- ST[i-1]*mu*dt + ST[i-1]*sigma*sqrt(dt)*rnorm(n=1, mean=0, sd=1)
            ST[i] <- ST[i] + ST[i-1]
        }
    }
    return(ST)
}

#' Multiple Paths Stock Price Simulation for Geometric Brownian Motion
#'
#' @param S0 Initial Stock Price
#' @param mu Annualized return in decimal format
#' @param sigma Annualized standard deviation in decimal format
#' @param time Time index (eg: 1,2,3,etc)
#' @param steps steps per Time Index (eg: 100, 200)
#' @param paths Number of Paths in Simulation
#' @param type "Continuous or Discrete"
#'
#' @return data.frame for multiple path Geometric Brownian Motion
#' @export
#'
#' @examples
#' SimDGBM(100,0.03,0.25,2,100,10,"continuous")
SimDGBM <- function(S0, mu, sigma, time, steps, paths, type){
    Final <- NULL
    for (j in 1:paths){
        result <- SimGBM(S0, mu, sigma, time, steps, type)
        Final <- cbind(Final, result)
    }
    colnames(Final) <- paste0("path", 1:paths)
    return(Final)
}


#' Multiple Paths Terminal Stock Price Simulation for Geometric Brownian Motion
#'
#' @param S0 Initial Stock Price
#' @param mu Annualized return in decimal format
#' @param sigma Annualized standard deviation in decimal format
#' @param time Time index (eg: 1,2,3,etc)
#' @param steps steps per Time Index (eg: 100, 200)
#' @param paths Number of Paths in Simulation
#' @param type "Continuous or Discrete"
#'
#' @return
#' @export
#'
#' @examples
#' SimTGBM(100,0.03,0.25,2,100,10,"continuous")
SimTGBM <- function(S0, mu, sigma, time, steps, paths, type){
    result <- SimDGBM(S0, mu, sigma, time, steps, paths, type)
    result <- result[nrow(result),]
    return(result)
}




