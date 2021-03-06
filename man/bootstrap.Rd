\name{bootstrap}
\alias{bootstrap}

\title{
  Runs a bootstrap experiment
}
\description{
Function that performs a bootstrap experiment
of a learning system on a given data set.
The function is completely generic. The generality comes
from the fact that the function that the user provides
as the system to evaluate, needs in effect to be a
user-defined function that takes care of the learning,
testing and calculation of the statistics that the user
wants to estimate using the bootstrap method.
}
\usage{
bootstrap(sys, ds, sets, itsInfo = F, verbose = T)
}

\arguments{
  \item{sys}{
\code{sys} is an object of the class \code{learner} representing the
  system to evaluate.
}
  \item{ds}{
\code{ds} is an object of the class \code{dataset} representing the data
  set to be used in the evaluation.
}
  \item{sets}{
\code{sets} is an object of the class \code{cvSettings} representing the
  cross validation experimental settings to use.
}
\item{itsInfo}{
  Boolean value determining whether the object returned by the function
  should include as an attribute a list with as many components as there
  are iterations in the experimental process, with each component
  containing information that the user-defined function decides to
  return on top of the standard error statistics. See the Details
  section for more information.
}
  \item{verbose}{
    A boolean value controlling the level of output of the function
    execution, defaulting to \code{T}
}
}
\details{
  The idea of this function is to carry out a bootstrap
  experiment of a given learning system on a given data set. The goal of
  this experiment is to estimate the value of a set of evaluation
  statistics by means of the bootstrap method. Bootstrap
  estimates are obtained by averaging over a set of k scores each
  obtained in the following way: i) draw a random sample with replacement
  with the same size as the original data set; ii) obtain a model with
  this sample; iii) test it and obtain the estimates for this run on the
  observations of the original data set that were not used in the sample
  obtained in step i). This process is repeated k times and the average
  scores are the bootstrap estimates.

  It is
  the user responsibility
  to decide which statistics are to be evaluated on each iteration and how they are
  calculated. This is done by creating a function that the user knows it
  will be called by this hold out routine at each repetition of
  the learn+test process. This user-defined function must assume
  that it will receive in the first 3 arguments a formula, a training
  set and a testing set, respectively. It should also assume that it may
  receive any other set of parameters that should be passed towards the
  learning algorithm. The result of this user-defined function should be
  a named vector with the values of the statistics to be estimated
  obtained by the learner when trained with the given training set, and
  tested on the given test set. See the Examples section below for an
  example of these functions.

  If the \code{itsInfo} parameter is set to the value
  \verb{TRUE} then the \code{hldRun} object that is the result
  of the function will have an attribute named \verb{itsInfo}
  that will contain extra information from the individual repetitions of
  the hold out process. This information can be accessed by the user by
  using the function \code{attr()},
  e.g. \verb{attr(returnedObject,'itsInfo')}. For this
  information to be collected on this attribute the user needs to code
  its user-defined functions in a way that it returns the vector of the
  evaluation statistics with an associated attribute named
  \verb{itInfo} (note that it is "itInfo" and not "itsInfo" as
  above), which should be a list containing whatever information the
  user wants to collect on each repetition. This apparently complex
  infra-structure allows you to pass whatever information you which from
  each iteration of the experimental process. A typical example is the
  case where you want to check the individual predictions of the model
  on each test case of each repetition. You could pass this vector of
  predictions as a component of the list forming the attribute
  \verb{itInfo} of the statistics returned by your user-defined
  function. In the end of the experimental process you will be able to
  inspect/use these predictions by inspecting the attribute
  \verb{itsInfo} of the \code{bootRun} object returned by the
  \code{bootstrap()} function. See the Examples section on the help page
  of the function \code{holdout()} for an
  illustration of this potentiality.
}
\value{
  The result of the function is an object of class \code{bootRun}.
}
\references{ Torgo, L. (2010) \emph{Data Mining using R: learning with case studies},
  CRC Press (ISBN: 9781439810187).

  \url{http://www.dcc.fc.up.pt/~ltorgo/DataMiningWithR}  
}
\author{ Luis Torgo \email{ltorgo@dcc.fc.up.pt} }

\seealso{
\code{\link{experimentalComparison}},
\code{\linkS4class{bootRun}},\code{\linkS4class{bootSettings}}, \code{\link{monteCarlo}}, \code{\link{holdOut}}, \code{\link{loocv}}, \code{\link{crossValidation}}
}
\examples{
## Estimating the mean absolute error and the normalized mean squared
## error of rpart on the swiss data, using one repetition of 10-fold CV
data(swiss)

## First the user defined function (note: can have any name)
user.rpart <- function(form, train, test, ...) {
    require(rpart)
    model <- rpart(form, train, ...)
    preds <- predict(model, test)
    regr.eval(resp(form, test), preds,
              stats=c('mae','nmse'), train.y=resp(form, train))
}

## Now the evaluation
eval.res <- bootstrap(learner('user.rpart',pars=list()),
                      dataset(Infant.Mortality ~ ., swiss),
                      bootSettings(1234,10))  # bootstrap with 10 repetitions

## Check a summary of the results
summary(eval.res)

## Plot them
\dontrun{
plot(eval.res)
}
}
\keyword{models}

