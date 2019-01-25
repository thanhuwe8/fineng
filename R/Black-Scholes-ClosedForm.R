#' Title
#'
#' @param PutCall
#' @param S
#' @param K
#' @param tau
#' @param r
#' @param q
#' @param sigma
#'
#' @return
#' @export
#'
#' @examples
BlackScholes <- function(PutCall, S, K,tau,r,q,sigma){
    d1 <- (log(S/K) + (r+sigma^2/2)*tau)/(sigma*sqrt(tau))
    d2 <- d1 - sigma*sqrt(tau)
    Call <- S*exp(-q*tau)*pnorm(d1) - K*exp(-r*tau)*pnorm(d2)
    Put  <- Call - S*exp(-q*tau) + K*exp(-r*tau)
    switch(PutCall,
           Call = {
               Price <- Call
           },
           Put = {
               Price <- Put

           })
    return(Price)
}
