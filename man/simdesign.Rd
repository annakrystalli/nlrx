% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/class_constr.R
\name{simdesign}
\alias{simdesign}
\title{Construct a new simdesign object}
\usage{
simdesign(simmethod = character(), siminput = tibble(),
  simobject = list(), simseeds = NA_integer_, simoutput = tibble(), ...)
}
\arguments{
\item{simmethod}{character string defining the method of the simulation design}

\item{siminput}{tibble providing input parameterisations for the NetLogo model (cols=parameter, rows=runs)}

\item{simobject}{used for some methods to store additional information (sobol, morris, eFast)}

\item{simseeds}{a vector or model random seeds}

\item{simoutput}{tibble contatining model results}

\item{...}{...}
}
\value{
simdesign S4 class object
}
\description{
Construct a new experiment object
}
\details{
The simulation design class holds information on the input parameter design of model simulations.
It also stores information that is needed to run method specific analysis functions.
The simseeds can be used to run all model simulations that are defined within the siminput tibble several times with changing random-seeds.
While it is possible to add simdesign directly with this function, we suggest to use our predefined simdesign functions.
nlrx provides a bunch of different simulation designs, such as full-factorial, latin-hypercube, sobol, morris and eFast.
A simulation design is attached to a nl object by using on of these simdesign functions (see examples).
}
\examples{
\dontrun{
# Example for Wolf Sheep Predation model from NetLogo models library:

nl@simdesign <- simdesign_simple(nl = nl,
                                 nseeds = 3)

nl@simdesign <- simdesign_ff(nl = nl,
                             nseeds = 3)


nl@simdesign <- simdesign_lhs(nl=nl,
                              samples=100,
                              nseeds=3,
                              precision=3)

nl@simdesign <- simdesign_sobol(nl=nl,
                                samples=200,
                                sobolorder=2,
                                sobolnboot=20,
                                sobolconf=0.95,
                                nseeds=3,
                                precision=3)

nl@simdesign <- simdesign_sobol2007(nl=nl,
                                    samples=200,
                                    sobolnboot=20,
                                    sobolconf=0.95,
                                    nseeds=3,
                                    precision=3)

nl@simdesign <- simdesign_soboljansen(nl=nl,
                                      samples=200,
                                      sobolnboot=20,
                                      sobolconf=0.95,
                                      nseeds=3,
                                      precision=3)

nl@simdesign <- simdesign_morris(nl=nl,
                                 morristype="oat",
                                 morrislevels=4,
                                 morrisr=100,
                                 morrisgridjump=2,
                                 nseeds=3)

nl@simdesign <- simdesign_eFast(nl=nl,
                                samples=100,
                                nseeds=3)

}

}
