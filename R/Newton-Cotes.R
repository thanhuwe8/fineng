#' Mid-point Rule for Integration
#'
#' @param N
#' @param a
#' @param b
#'
#' @return
#' @export
#'
#' @examples
#' MidPoint(N=1000,a=0.0001,b=100)

MidPoint <- function(N,a,b){
    h <- (b-a)/(N-1)
    phi <- seq(from=a,to=b,by=h)
    mid <- NULL
    for (k in 1:(N-1)){
        mid[k] <- (phi[k]+phi[k+1])/2
    }
    weight <- h*rep(1,N-1)
    return(list(weight=weight,x=mid))
}

length(MidPoint(N=1000,a=0.0001,b=100)$weight)

#' Trapezoidal Rule for Integration
#'
#' @param N
#' @param a
#' @param b
#'
#' @return
#' @export
#'
#' @examples
#' Trapz(N=1000,a=0.0001,b=100)
Trapz <- function(N,a,b){
    h <- (b-a)/(N-1)
    phi <- h*c(1/2,1:(N-2),1/2)
    return(list(weight=phi,x=seq(from=a,to=b,by=h)))
}

