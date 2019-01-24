#' Generate Gauss-Laguerre Quadrature in R
#'
#' @param n
#'
#' @return
#' @export
#'
#' @examples
#' GenerateGaussLaguerreR(5)
GenerateGaussLaguerreR <- function(n){
    L <- NULL
    # Generate Laguerre polynomial
    for (k in 0:n){
        L[k+1] <- (-1)^k/factorial(k)*choose(n,k)
    }
    # Solve for Laguerre polynomial
    x <- polyroot(L)
    # Weight vector
    w <- rep(1,n)
    # deri is the derivative of Laguerre polynomial
    deri <- matrix(nrow=n,ncol=n)
    # calculate the weight
    for (j in 1:n){
        for (k in 1:n){
            deri[k,j] = (-1)^k/factorial(k-1)*choose(n,k)*x[j]^(k-1)
        }
        # note this line for references
        w[j] <- 1/x[j]/sum(deri[,j])^2
    }

    w <- as.numeric(w); x <- as.numeric(x)
    return(list(x=x,w=w))
}


# Gauss-Legendre Quadrature
#' Generate Gauss-Legendre Quadrature in R
#'
#' @param n
#'
#' @return
#' @export
#'
#' @examples
GenerateGaussLegendre <- function(n){
    m <- floor(n/2)
    L <- NULL
    for (k in 0:m){
        L[k+1] <- (1/2^n)*(-1)^k*factorial(2*n-2*k)/factorial(k)/factorial(n-k)/
            factorial(n-2*k)
    }
    P <- NULL
    for (k in 1:(n+1)){
        # Highest order always 1st position
        if (mod(k,2)==0){
            P[k] <- 0;
        } else {
            P[k] <- L[(k+1)/2]
        }
    }
    # Solve for the legendre polynomial (largest polynomial comes last)
    x <- sort(polyroot(rev(P)))
    # Weight vector
    w <- rep(1,n)
    deri <- matrix(nrow=m+1,ncol=n)
    # deri is the derivative of Legendre polynomials
    for (j in 1:n){
        for (k in 0:m){
            deri[k+1,j] <- (1/2^n)*(-1)^k*factorial(2*n-2*k)/
                factorial(k)/factorial(n-k)/factorial(n-2*k)*(n-2*k)*
                x[j]^(n-2*k-1)
        }
        w[j] <- 2/(1-x[j]^2)/sum(deri[,j])^2
    }
    return(list(x=x,w=w))

}


