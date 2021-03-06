% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Hier_model.R
\name{LN_hierarchical}
\alias{LN_hierarchical}
\title{Bayesian estimation of a log - normal hierarchical model}
\usage{
LN_hierarchical(
  formula_lme,
  data_lme,
  y_transf = TRUE,
  functional = c("Subject", "Marginal", "PostPredictive"),
  data_pred = NULL,
  order_moment = 2,
  nsamp = 10000,
  par_tau = NULL,
  par_sigma = NULL,
  var_pri_beta = 10000,
  inits = list(NULL),
  verbose = TRUE,
  burnin = 0.1 * nsamp,
  n_thin = 1
)
}
\arguments{
\item{formula_lme}{A two-sided linear formula object describing
both the fixed-effects and random-effects part of the model is required. For details see \code{\link{lmer}}.}

\item{data_lme}{Optional data frame containing the variables named in \code{formula_lme}.}

\item{y_transf}{Logical. If \code{TRUE}, the response variable is assumed already as log-transformed.}

\item{functional}{Functionals of interest: \code{"Subject"} for subject-specific conditional mean,
\code{"Marginal"} for the overall expectation and \code{"PostPredictive"} for the posterior predictive distribution.}

\item{data_pred}{Data frame with the covariate patterns of interest for prediction. All the covariates present in the \code{data_lme} object must be included. If \code{NULL} the design matrix of the model is used.}

\item{order_moment}{Order of the posterior moments that are required to be finite.}

\item{nsamp}{Number of Monte Carlo iterations.}

\item{par_tau}{List of vectors defining the triplets of hyperparaemters for each random effect variance (as many vectors as the number of specified random effects variances).}

\item{par_sigma}{Vector containing the tiplet of hyperparameters for the prior of the data variance.}

\item{var_pri_beta}{Prior variance for the model coefficients.}

\item{inits}{List of object for initializing the chains. Objects with compatible dimensions must be named with \code{beta}, \code{sigma2} and \code{tau2}.}

\item{verbose}{Logical. If \code{FALSE}, the messages from the Gibbs sampler are not shown.}

\item{burnin}{Number of iterations to consider as burn-in.}

\item{n_thin}{Number of thinning observations.}
}
\value{
The output list provided is composed of three parts. The object \code{$par_prior} contains the parameters fixed for the variance components priors. The object \code{$samples} contains the posterior samples for all the paramters.
They are returned as a \code{\link{mcmc}} object and they can be analysed trough the functions contained in the
\code{coda} package in order to check for the convergence of the algorithm. Finally, in \code{$summaries} an overview of the posteriors of the model parameters and of the target functionals is provided.
}
\description{
Function that estimates a log-normal linear mixed model with GIG priors on the variance components,
in order to assure the existence of the posterior moments of key functionals in the original data scale like conditioned means
or the posterior predictive distribution.
}
\details{
The function allows to estimate a log-normal linear mixed model through a Gibbs sampler. The model equation is specified as in \code{\link{lmer}} model and the target functionals to estimate need to be declared.
A weakly informative prior setting is automatically assumed, always keeping the finiteness of the posterior moments of the target functionals.
}
\examples{
\donttest{
library(BayesLN)
# Load the dataset included in the package
data("laminators")
data_pred_new <- data.frame(Worker = unique(laminators$Worker))
Mod_est<-LN_hierarchical(formula_lme = log_Y~(1|Worker),
                         data_lme = laminators,
                         data_pred = data_pred_new,
                         functional = c("Subject","Marginal"),
                         order_moment = 2, nsamp = 50000, burnin = 10000)
}

}
