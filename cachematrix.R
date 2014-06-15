## Memoizes the inverse of a matrix. Handy when 
## we want to remember the inverse of a matrix for 
## later uses.
## To use, create a special matrix using makeCacheMatrix
## and get the (possibly cached) inverse using cacheSolve

## Create the cacheMatrix object 

makeCacheMatrix <- function(x = matrix()) {
    inverse <- NULL
    set <- function(y) {
        x <<- y
        inverse <<- NULL
    }
    get <- function() x
    setInverse <- function(i) inverse <<- i
    getInverse <- function() inverse
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}


## Invert the cacheMatrix object, if the inverse is already
## computed, return, else compute, cache and return.

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    inv = x$getInverse()
    if (!is.null(inv)) {
        message("Getting cached inverse")
        return(inv)
    }
    data <- x$get()
    inv <- solve(data, ...)
    x$setInverse(inv)
    inv
}
