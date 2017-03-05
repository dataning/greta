% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dynamics_module.R
\name{dynamics-module}
\alias{dynamics}
\alias{dynamics-module}
\alias{iterate_lambda}
\alias{iterate_lambda_vectorised}
\title{Functions for modelling dynamical systems}
\usage{
dynamics$iterate_lambda(matrix, state, niter)

dynamics$iterate_lambda_vectorised(matrices, state, n, m, niter)
}
\arguments{
\item{matrix}{a square matrix node representing transition probabilities
between states}

\item{state}{a column vector node representing the initial state from which
to iterate the matrix}

\item{niter}{a positive integer giving the number of times to iterate the
matrix}

\item{matrices}{a rectangular matrix node of dimension n x m^2, each row of
which gives the rowwise elements of a different m x m matrix to iterate}

\item{n}{the number of m x m matrices to be iterated (firstdimensions of
\code{matrices})}

\item{m}{the dimension of each matrix to be iterated}
}
\description{
A module providing functions specific to dynamical modelling. So
  far only for iterating Leslie matrices. \code{iterate_lambda} iterates a
  matrix a certain number of times and returns, as a scalar node, the
  terminal growth rate for the first element of the state vector.
  \code{iterate_lambda_vectorised} is a vectorised version for iterating over
  multiple matrices, returning a vector of growth rates.
}
