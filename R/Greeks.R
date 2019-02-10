
GBMPrice <- function(S0, sigma, mu, dt, z){
    ST <- S0*exp((mu-sigma^2/2)*dt + sigma*sqrt(dt)*z)
    return(ST)
}

# a <- GBMPrice(100,0.25,0.03,0.1,0.5)
# a
#
# S0 <- 100
# K <- 100
# sigma <- 0.25
# mu <- 0.03
# dt <- 0.5
# n <- 100
#
# PayOff <- ST-K
# pmax(PayOff,0)
# PayOff[PayOff<0] <- 0

FiniteDiffDelta <- function(S0, K, sigma, mu, dt, n, r, type, h=1/10000){
    type <- match.arg(type, c("forward", "backward", "central"))
    z <- rnorm(n,mean=0,sd=1)

    ST <- GBMPrice(S0, sigma, mu, dt, z)
    STplusH <- GBMPrice(S0+h, sigma, mu, dt, z)
    STminusH <- GBMPrice(S0-h, sigma, mu, dt, z)

    PayOff <- pmax(ST - K,0)
    PayOffPlus <- pmax(STplusH - K,0)
    PayOfffMinus <- pmax(STminusH - K,0)

    # Calculate expected discounted payoff
    if (type=="forward"){
        delta <- mean(exp(-r*dt)*(PayOffPlus - PayOff)/h)
    } else if (type=="backward"){
        delta <- mean(exp(-r*dt)*(PayOff - PayOffMinus)/h)
    } else {
        delta <- mean(exp(-r*dt)*(PayOffPlus - PayOffMinus)/2/h)
    }

    return(delta)
}

x <- FiniteDiffDelta(100,150,0.25,0.03,0.5,100,0.01,"forward")
x
