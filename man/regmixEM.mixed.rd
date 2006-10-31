\name{regmixEM.mixed}
\title{EM Algorithm for Mixtures of Regressions with Random Effects}
\alias{regmixEM.mixed}
\usage{
regmixEM.mixed(y, x, w = NULL, sigma = NULL, arb.sigma = TRUE,
               alpha = NULL, lambda = NULL, mu = NULL, R = NULL, 
               arb.R = TRUE, k = 2, mixed = FALSE, 
               addintercept.fixed = FALSE, 
               addintercept.random = TRUE, epsilon = 1e-08, 
               maxit = 10000, verb = FALSE)
}

\description{
  Returns EM algorithm output for mixtures of multiple regressions with random effects
  and an option to incorporate mixed effects.
}
\arguments{
  \item{y}{A list of N response trajectories with (possibly) varying dimensions of
  length $n_i$.}
  \item{x}{A list of N design matrices of dimensions $(n_i)\times p$.  Each trajectory in y has
  it's own design matrix.}
  \item{w}{A list of N known explanatory variables having dimensions $(n_i)\times q$. If \code{mixed} = FALSE,
  then \code{w} is replaced by a list of N zeros.}
  \item{sigma}{A vector of standard deviations.  If NULL, then 1/\code{s}$^2$ has
    random standard exponential entries according to a binning method done on the data.}
  \item{arb.sigma}{If TRUE, then \code{sigma} is k-dimensional. Else a common standard deviation is assumed.}
  \item{alpha}{A q-vector of unknown regression parameters for the fixed effects.  If NULL and \code{mixed} = TRUE, then \code{alpha} is 
  random from a normal distribution with mean and variance according to a binning method done
  on the data. If \code{mixed} = FALSE, then \code{alpha} = 0.}
  \item{lambda}{Initial value of mixing proportions for the assumed mixture structure on the regression coefficients.
  Entries should sum to 1.  This determines number of components.  If NULL, then \code{lambda} is
   random from uniform Dirichlet and the number of components is determined by \code{mu}.}
  \item{mu}{A pxk matrix of the mean for the mixture components of the random regression coefficients. If NULL, then the columns
  of \code{mu} are random from a multivariate normal distribution with mean and variance determined by a binning method
  done on the data.}
  \item{R}{A list of N pxp covariance matrices for the mixture components of the random regression coefficients. If NULL, then
  each matrix is random from a standard Wishart distribution according to a binning method done on the data.}
  \item{arb.R}{If TRUE, then \code{R} is a list of N pxp covariance matrices.  Else, one common covariance matrix is assumed.}
  \item{k}{Number of components.  Ignored unless \code{lambda} is NULL.}
  \item{mixed}{If TRUE, then fixed effects are incorporated.  If FALSE, then only random effect are incorporated.}
  \item{addintercept.fixed}{If TRUE, a column of ones is appended to the matrices in w.}
  \item{addintercept.random}{If TRUE, a column of ones is appended to the matrices in x before p is calculated.}
  \item{epsilon}{The convergence criterion.}
  \item{maxit}{The maximum number of iterations.} 
  \item{verb}{If TRUE, then various updates are printed during each iteration of the algorithm.} 
}
\value{
  \code{regmixEM} returns a list of class \code{mixEM} with items:
  \item{x}{The predictor values.}
  \item{y}{The response values.}
  \item{lambda}{The final mixing proportions.}
  \item{mu}{The final mean vectors.}
  \item{R}{The final covariance matrices.}
  \item{sigma}{The final component error variances.}
  \item{alpha}{The final regression coefficients for the fixed effects.}
  \item{loglik}{The final log-likelihood.}
  \item{posterior.z}{An Nxk matrix of posterior membership probabilities.}
  \item{posterior.beta}{A list of N pxk matrices giving the posterior regression coefficient values.} 
  \item{all.loglik}{A vector of each iteration's log-likelihood.}
  \item{ft}{A character vector giving the name of the function.}
}
\seealso{
\code{\link{regmixEM}}, \code{\link{post.beta}}
}
\references{
  Xu, W. and Hedeker, D. (2001) A Random-Effects Mixture Model for Classifying Treatment Response in
  Longitudinal Clinical Trials, \emph{Journal of Biopharmaceutical Statistics}, \bold{11(4)}, 253--273.
}
\examples{
## EM output for simulated data from 2-component mixture of random effects.

data(RanEffdata)
x<-lapply(1:length(RanEffdata), function(i) 
          matrix(RanEffdata[[i]][, 2:3], ncol = 2))
x<-x[1:20]
y<-lapply(1:length(RanEffdata), function(i) 
          matrix(RanEffdata[[i]][, 1], ncol = 1))
y<-y[1:20]
lambda<-c(0.45, 0.55)
mu<-matrix(c(0, 4, 100, 12), 2, 2)
sigma<-2
R<-list(diag(1, 2), diag(1, 2))
em.out<-regmixEM.mixed(y, x, sigma = sigma, arb.sigma = FALSE,
                       lambda = lambda, mu = mu, R = R,
                       addintercept.random = FALSE,
                       epsilon = 1e-02, verb = TRUE)
em.out[3:8]

}

\keyword{file}
