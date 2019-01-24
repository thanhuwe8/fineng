HestonProb <- function(phi,kappa,theta,lambda,rho,sigma,tau,K,S,r,q,v0,Pnum,Trap){
    # kappa: volatility mean reversion speed parameter
    # theta: volatility mean reversion level parameter
    # lambda: risk parameter
    # rho: correlation between two Brownian motions
    # sigma: volatility of the variance
    # v: initial variance

    # phi: integration variable
    # Pnum = 1 or 2 (for the probabilities)

    # PutCall= "C" or "P"
    # K = strike price
    # S = spot price
    # r = risk free rate
    # q = dividend yield
    # Trap = 1 "Little Trap", 0 "Original Heston Formulation"

    # Log of stock price
    x <- log(S)
    a <- kappa*theta

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
    y <- Re(exp(-i*phi*log(K))*f/1i/phi)
}
