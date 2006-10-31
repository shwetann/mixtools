\name{multmixmodel.sel}
\title{Model Selection Mixtures of Multinomials}
\alias{multmixmodel.sel}
\usage{
multmixmodel.sel(y, comps = NULL, ...)
}

\description{
  Assess the number of components in a mixture of multinomials model using the Akaike's information
  criterion (AIC), Schwartz's Bayesian information criterion (BIC), Bozdogan's consistent AIC (CAIC),
  and Integrated Completed Likelihood (ICL).
}
\arguments{
  \item{y}{A matrix of multinomial counts. An nxp matrix, where n is the sample
    size and p is the number of bins.}
  \item{comps}{Vector containing the numbers of components to consider.
    If NULL, this is set to be 1:(max possible), where (max possible) is
    floor((m+1)/2) and m is the minimum row sum of y.}
  \item{...}{Additional arguments passed to \code{multmixEM}.}
}
\value{
  \code{multmixmodel.sel} returns a table summarizing the AIC, BIC, CAIC, ICL, and log-likelihood
  values along with the winner (the number with the lowest aforementioned values).
}
 
\seealso{
\code{\link{compCDF}}, \code{\link{makemultdata}}, \code{\link{multmixEM}}
}
\examples{
##Data generated using the multinomial cutpoint method.

x<-matrix(rpois(70, 6), 10, 7) 
x.new<-makemultdata(x, cuts = 5)
multmixmodel.sel(x.new$y, comps = c(1,2))

}

\keyword{file}
