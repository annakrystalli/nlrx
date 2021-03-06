#' nlrx: A package for running NetLogo simulations from R.
#'
#' The nlrx package provides tools to setup NetLogo simulations in R.
#' It uses a similar structure as NetLogos Behavior Space but offers more flexibility and additional tools for running sensitivity analyses.
#'
#'
#' @details
#'
#' The nlrx package uses S4 classes to store basic information on NetLogo, the model experiment and the simulation design.
#' Experiment and simulation design class objects are stored within the nl class object.
#' This allows to have a complete simulation setup within one single R object.
#'
#' The following steps guide you trough the process on how to setup, run and analyze NetLogo model simulations with nlrx
#'
#' Step 1: Create a nl object:
#'
#' The nl object holds all information on the NetLogo version, a path to the NetLogo directory with the defined version, a path to the model file, and the desired memory for the java virtual machine.
#'
#' \code{
#' nl <- nl(nlversion = "6.0.3",
#' nlpath = "C:/Program Files/NetLogo 6.0.3/",
#' modelpath = "C:/Program Files/NetLogo 6.0.3/app/models/
#' Sample Models/Biology/Wolf Sheep Predation.nlogo",
#' jvmmem = 1024)
#' }
#'
#' Step 2: Attach an experiment
#'
#' The experiment object is organized in a similar fashion as NetLogo BehaviorSpace experiments.
#' It holds information on model variables, constants, metrics, runtime, ...
#'
#' \code{
#' nl@@experiment <- experiment(expname="wolf-sheep",
#' outpath="C:/out/",
#' repetition=1,
#' tickmetrics="true",
#' idsetup="setup",
#' idgo="go",
#' idfinal=NA_character_,
#' idrunnum=NA_character_,
#' runtime=50,
#' evalticks=seq(40,50),
#' metrics=c("count sheep", "count wolves", "count patches with [pcolor = green]"),
#' variables = list('initial-number-sheep' = list(min=50, max=150, step=10, qfun="qunif"),
#'                  'initial-number-wolves' = list(min=50, max=150, step=10, qfun="qunif")),
#' constants = list("model-version" = "\"sheep-wolves-grass\"",
#'                  "grass-regrowth-time" = 30,
#'                  "sheep-gain-from-food" = 4,
#'                  "wolf-gain-from-food" = 20,
#'                  "sheep-reproduce" = 4,
#'                  "wolf-reproduce" = 5,
#'                  "show-energy?" = "false"))
#'
#' }
#'
#' Step 3: Attach a simulation design
#'
#' While the experiment defines the variables and specifications of the model, the simulation design creates a parameter input table based on these model specifications and the chosen simulation design method.
#' nlrx provides a bunch of different simulation designs, such as full-factorial, latin-hypercube, sobol, morris and eFast.
#' A simulation design is attached to a nl object by using on of these simdesign functions:
#'
#' \code{
#' nl@simdesign <- simdesign_lhs(nl=nl,
#' samples=100,
#' nseeds=3,
#' precision=3)
#' }
#'
#' Step 4: Run simulations
#'
#' All information that is needed to run the simulations is now stored within the nl object.
#' The \code{run_nl_one} function allows to run one specific simulation from the siminput parameter table.
#' The \code{run_nl_all} function runs a loop over all simseeds and rows of the parameter input table siminput
#' The loops are created by calling furr::future_map_dfr which allows running the function either locally or on remote HPC machines.
#'
#' \code{
#' future::plan(multisession)
#'
#' results %<-% run_nl_all(nl = nl,
#'                         cleanup = "all")
#'
#' }
#'
#' Step 5: Attach results to nl and run analysis
#'
#' nlrx provides method specific analysis functions for each simulation design.
#' Depending on the chosen design, the function reports a tibble with aggregated results or sensitivity indices.
#' In order to run the \code{analyze_nl()} function, the simulation output has to be attached to the nl object first.
#' After attaching the simulation results, these can also be written to the defined outpath of the experiment object.
#'
#' \code{
#' # Attach results to nl object:
#' setsim(nl, "simoutput") <- results
#' # Write output to outpath of experiment within nl
#' write_simoutput(nl)
#' # Do further analysis:
#' analyze_nl(nl)
#' }
#'
#'
#' @docType package
#' @name nlrx-package
#' @author Jan Salecker \email{jsaleck@gwdg.de}
#' @keywords package
"_PACKAGE"

globalVariables(c(".",
                  "[run number]",
                  "[step]",
                  "funs",
                  "group_by",
                  "metrics",
                  "random-seed",
                  "vars",
                  "siminputrow",
                  "seed",
                  "maps",
                  "x",
                  "y",
                  "X",
                  "Y",
                  "group",
                  "var",
                  "dist.missing",
                  "values.missing"))


