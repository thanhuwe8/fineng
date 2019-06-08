MCPathwiseDelta <- function(S0, K, mu, sigma, time, paths){
    z <- rnorm(paths,mean=0,sd=1)
}

m <- matrix(nrow=10, ncol=10)
m
m[,2:dim(m)[2]] <- matrix(rnorm(90), nrow=10, ncol=9)


MCLeastSquare <- function(S0, K, r, vol, mat, nstepst, npaths){
    deltat <- mat/nstepst
    t <- deltat*seq(from=0,to=nstepst+1)
    smatrix <- matrix(nrow=npaths, ncol=nstepst+1)
    xmatrix <- matrix(0,nrow=npaths, ncol=nstepst+1)
    optvmatrix <- matrix(nrow=npaths, ncol=nstepst+1)

    xmatrix[,2:(dim(xmatrix)[2])] <- matrix(rnorm(npaths*(nstepst-1), nrow=))
}
