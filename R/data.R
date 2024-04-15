#' V^G based on allelic expression data
#'
#' Allelic expression based V^G estimates generated from GTEx v8.
#' Column names for the tissues are in 6 letter code established for GTEx as
#' described at gtexportal.org.
#'
#' @format ## `vg_ae`
#' A data frame with 16,726 rows and 49 columns:
#' \describe{
#'   \item{MEAN}{Harmonic mean of all tissue V^G estimates, weighted by mean tissue expression}
#'   \item{others}{Tissue V^G for GTEx tissues in GTEx 6 letter code.}
#' }
#' @source Supplemental Table S5 of the Rentzsch et al. 2024 publication
"vg_ae"

#' V^G based on AE data and ML prediction
#'
#' AE based V^G complemented by ML based V^G estimates for genes missing
#' sufficient AE data. Estimates for Kidney - Cortex (KDNCTX) are not included
#' due to missing data for ML prediction. Additional mean estimates are based on
#' ML prediction and not harmonic mean accross tissues.
#'
#' @format ## `vg_aeml`
#' A data frame with 20,431 rows and 48 columns:
#' \describe{
#'   \item{MEAN}{Harmonic mean of all tissue V^G, weighted by mean tissue expression}
#'   \item{others}{Tissue V^G for GTEx tissues in GTEx 6 letter code.}
#' }
#' @source Supplemental Table S6 of the Rentzsch et al. 2024 publication
"vg_aeml"
