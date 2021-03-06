% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/step_date_hcai.R
\name{step_date_hcai}
\alias{step_date_hcai}
\alias{tidy.step_date_hcai}
\title{Date and Time Feature Generator}
\usage{
step_date_hcai(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  feature_type = "continuous",
  columns = NULL,
  skip = FALSE,
  id = rand_id("bagimpute")
)

\method{tidy}{step_date_hcai}(x, ...)
}
\arguments{
\item{recipe}{A recipe object. The step will be added to the sequence of
operations for this recipe.}

\item{...}{One or more selector functions to choose which variables that will
be used to create the new variables. The selected variables should have
class `Date` or `POSIXct` or their name must end with `DTS`. See
[selections()] for more details. For the `tidy` method, these are not
currently used.}

\item{role}{For model terms created by this step, what analysis role should
they be assigned? By default, the function assumes that the new variable
columns created by the original variables will be used as predictors in a
model.}

\item{trained}{A logical to indicate if the number of NA values have been
counted in preprocessing.}

\item{feature_type}{character, either `continuous` (default) or `categories`.}

\item{columns}{A character string of variables that will be used as inputs.
This field is a placeholder and will be populated once [prep.recipe()] is
used.}

\item{skip}{A logical. Should the step be skipped when the recipe is baked?}

\item{id}{a unique step id that will be used to unprep}

\item{x}{A `step_date_hcai` object.}
}
\value{
For `step_date_hcai`, an updated version of recipe with the new step
  added to the sequence of existing steps (if any). For the `tidy` method, a
  tibble with columns `terms` (the selectors or variables selected), `value`
  (the feature names), and `ordinal` (a logical).
}
\description{
`step_date_hcai` creates a *specification* of a recipe step that
 will convert date data into factor or numeric variable(s). This step will
 guess the date format of columns with the "_DTS" suffix, and then create
 either `categories` or `continuous` columns. Various portions of this step
 are copied from `recipes::step_date`.
}
\details{
Unlike other steps, `step_date_hcai` does *not* remove the original
  date variables. [step_rm()] can be used for this purpose.
}
\examples{
library(lubridate)
library(recipes)

examples <- data.frame(Dan = ymd("2002-03-04") + days(1:10),
                       Stefan = ymd("2006-01-13") + days(1:10))
date_rec <- recipe(~ Dan + Stefan, examples) \%>\%
  step_date_hcai(all_predictors())

date_rec <- prep(date_rec, training = examples)

date_values <- bake(date_rec, new_data = examples)
date_values

# changing `feature_type` to `categories`
date_rec <-
  recipe(~ Dan + Stefan, examples) \%>\%
  step_date_hcai(all_predictors(), feature_type = "categories")

date_rec <- prep(date_rec, training = examples)

date_values <- bake(date_rec, new_data = examples)
date_values
}
