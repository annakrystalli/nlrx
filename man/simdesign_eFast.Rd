% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simdesign_helper.R
\name{simdesign_eFast}
\alias{simdesign_eFast}
\title{Add an eFast simdesign to a nl object}
\usage{
simdesign_eFast(nl, samples, nseeds)
}
\arguments{
\item{nl}{nl object with a defined experiment}

\item{samples}{number of samples for the eFast sensitivity analysis}

\item{nseeds}{number of seeds for this simulation design}
}
\value{
simdesign S4 class object
}
\description{
Add an eFast simdesign to a nl object
}
\details{
This function creates a simdesign S4 class which can be added to a nl object.

Variables in the experiment variable list need to provide a numeric distribution with min, max and qfun (e.g. list(min=1, max=4, qfun="qunif")).

The eFast simdesign uses the sensitivity package to set up a fast99 elementary effects sensitivity analysis, including a simobject of class fast99 and a input tibble for simulations.
For details on method specific sensitivity analysis function parameters see ?fast99
Finally, the function reports a simdesign object.
}
\examples{
\dontrun{
# Example for Wolf Sheep Predation model from NetLogo models library:
nl@simdesign <- simdesign_eFast(nl=nl,
                                 samples=100,
                                 nseeds=1)
}

}
