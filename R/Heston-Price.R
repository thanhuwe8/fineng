#' Title
#'
#' @param PutCall
#' @param S
#' @param K
#' @param tau
#' @param r
#' @param q
#' @param kappa
#' @param theta
#' @param sigma
#' @param lambda
#' @param v0
#' @param rho
#' @param N
#' @param a
#' @param b
#'
#' @return
#' @export
#'
#' @examples
HestonPriceMP <- function(PutCall,S,K,tau,r,q,kappa,theta,sigma,lambda,v0,rho,N,a,b){

    MP <- MidPoint(N,a,b)
    wt <- MP$weight
    phi <- MP$x

    int1 <- int2 <- NULL
    # Calculate integral of Heston integrand by Mid-Point rule
    for (k in 1:(N-1)){
        # function(phi,kappa,theta,lambda,rho,sigma,tau,K,S,r,q,v0,Pnum)
        int1[k] <- wt[k]*HestonProb(phi[k],kappa,theta,lambda,rho,sigma,tau,K,
                                    S,r,q,v0,1)
        int2[k] <- wt[k]*HestonProb(phi[k],kappa,theta,lambda,rho,sigma,tau,K,
                                    S,r,q,v0,2)
    }
    I1 <- sum(int1)
    I2 <- sum(int2)

    P1 <- 1/2 + 1/pi*I1
    P2 <- 1/2 + 1/pi*I2

    HestonCall <- S*exp(-q*tau)*P1-K*exp(-r*tau)*P2
    HestonPut <- HestonCall - S*exp(-q*tau) + K*exp(-r*tau)

    switch (PutCall,
        Call = {
            y <- HestonCall
        },
        Put  = {
            y <- HestonPut
        }
    )
    return(y)
}







