#' Real Part from Heston Integrand
#'
#' @param phi Integral variable
#' @param kappa Volatility mean reversion speed
#' @param theta Volatility mean reversion level
#' @param lambda risk parameter
#' @param rho correlation between 2 Brownian/Wiener Process
#' @param sigma volatility of variance in CIR pde
#' @param tau time to maturity
#' @param K strike price
#' @param S current stock price
#' @param r risk free rate
#' @param q dividend rate
#' @param v0 initial value for variance
#' @param Pnum 1 or 2 for P1 or P2 under risk-neutral measure
#'
#' @return real part of Heston integrand
#' @export
#'
#' @examples
HestonProb <- function(phi,kappa,theta,lambda,rho,sigma,tau,K,S,r,q,v0,Pnum){

    # Log of stock price
    x <- log(S)
    a <- kappa*theta

    # The formula for call option C(K) = e^x*P_1 -K*e(-rtau)*P_2
    # with e^x = e^(ln(S_t))
    if(Pnum==1){
        u <- 0.5
        b <- kappa + lambda - rho*sigma
    }else if(Pnum==2){
        u <- -0.5
        b <- kappa + lambda
    } else {
        stop("Pnum should be 1 or 2")
    }

    # temp var for Dj Ricatti equation
    d <- sqrt((rho*sigma*1i*phi-b)^2-sigma^2*(2*u*1i*phi-phi^2))
    # temp variable for the initial condition of Dj
    g <- (b-rho*sigma*1i*phi+d)/(b-rho*sigma*1i*phi-d)

    #G <- (1 - g*exp(d*tau))/(1-g);
    D <- (b-rho*sigma*1i*phi+d)/(sigma^2)*((1-exp(d*tau))/(1-g*exp(d*tau)))
    C <- (r-q)*1i*phi*tau + a/sigma^2*((b-rho*sigma*1i*phi+d)*tau - 2*log((1-g*exp(d*tau))/(1-g)))

    f <- exp(C+D*v0+1i*phi*x)
    y <- Re(exp(-1i*phi*log(K))*f/1i/phi)
    return(y)
}











