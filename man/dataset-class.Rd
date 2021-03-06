\name{dataset-class}
\Rdversion{1.1}
\docType{class}
\alias{dataset}
\alias{dataset-class}
\alias{show,dataset-method}

\title{Class "dataset" }
\description{	 This is the class of objects that represent all
  necessary information on a predictive task. This class extends the
  task class by adding the data frame with the data of the predictive task.  }
\section{Objects from the Class}{
  Objects can be created by calls of the form \code{dataset(...)}.
  The objects include information on the name of the predictive task,
  the formula and the data frame with the data used in the task.
}
\section{Slots}{
	 \describe{
    \item{\code{formula}:}{Object of class \code{"formula"} containing
      the formula representing the predictive task }
    \item{\code{data}:}{Object coercible to class \code{"data.frame"} containing
      the data of the problem }
    \item{\code{name}:}{Object of class \code{"character"} containing an
    internal name of the task}
  }
}
\section{Extends}{
Class \code{"\linkS4class{task}"}, directly.
}
\section{Methods}{
  \describe{
    \item{show}{\code{signature(object = "dataset")}: method used to
      show the contents of a dataset object. }
	 }
}
\references{ Torgo, L. (2010) \emph{Data Mining using R: learning with case studies},
CRC Press (ISBN: 9781439810187). \url{http://www.dcc.fc.up.pt/~ltorgo/DataMiningWithR}  }
\author{ Luis Torgo (ltorgo@dcc.fc.up.pt)  }

\seealso{
	\code{\linkS4class{task}}, \code{\linkS4class{learner}}
}
\examples{
showClass("dataset")
}
\keyword{classes}
