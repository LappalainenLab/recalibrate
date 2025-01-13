#' Data.frame of V^G estimates based on allelic expression data
#'
#' Haplotype expression based V^G estimates generated from GTEx v8.
#' Column names for the tissues are in 6 letter code established for GTEx as
#' described at gtexportal.org.
#'
#' @format ## `vg_h`
#' A data frame with 26,862 rows and 51 columns:
#' \describe{
#'   \item{MEAN}{Harmonic mean of all tissue V^G estimates, weighted by mean tissue expression}
#'   \item{others}{Tissue V^G for GTEx tissues in GTEx 6 letter code}
#' }
#' @seealso [vg_ae]
#' @source Supplemental Table S3 of the Rentzsch et al. 2025 manuscript
"vg_h"

#' Data.frame of V^G estimates based on allelic expression data
#'
#' Allelic expression based V^G estimates generated from GTEx v8. Compared
#' to Haplotype based V^G, this is based on the expression in single SNPs.
#' Column names for the tissues are in 6 letter code established for GTEx as
#' described at gtexportal.org.
#'
#' @format ## `vg_ae`
#' A data frame with 16,726 rows and 49 columns:
#' \describe{
#'   \item{MEAN}{Harmonic mean of all tissue V^G estimates, weighted by mean tissue expression}
#'   \item{others}{Tissue V^G for GTEx tissues in GTEx 6 letter code}
#' }
#' @seealso [vg_h]
#' @source Supplemental Table S5 of the old Rentzsch et al. 2024 preprint
"vg_ae"

#' Data.frame of V^G estimates based on AE data and ML prediction
#'
#' H based V^G complemented by inference based on V^G estimates in similar
#' tissues and corrected for tissue expression (Details in 2025 manuscript).
#' Mean estimates are identical to H based V^G.
#'
#' @format ## `vg_hi`
#' A data frame with 26,854 rows and 51 columns:
#' \describe{
#'   \item{MEAN}{Harmonic mean of all tissue V^G, weighted by mean tissue expression}
#'   \item{others}{Tissue V^G for GTEx tissues in GTEx 6 letter code}
#' }
#' @seealso [vg_h]
#' @source Supplemental Table S4 of the Rentzsch et al. 2025 manuscript
"vg_hi"
