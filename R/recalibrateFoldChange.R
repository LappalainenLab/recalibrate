#' Recalibrate gene expression fold changes
#'
#' @param df_de data.frame: contains differential expression per gene. Row names
#' are Ensembl gene ids and one column contains the log fold change.
#' @param vg data.frame: contains the V^G estimate per gene (rows) for one
#' or multiple tissues (columns). Default = [vg_ae], the allelic expression
#' based V^G estimates calculated from GTEx v8.
#' @param tissue char: V^G tissue that is recalibrated against. Default V^G are
#' generated for the GTEx tissues (in GTEx 6-letter code) or MEAN (weighted
#' harmonic mean across tissues). Default = "MEAN".
#' @param remove_NA bool: whether genes for which no V^G estimate exist should
#' be removed from the final data.frame. Default = FALSE.
#' @param sort_by char: sort result data.frame by one particular column.
#' Default = NA
#' @param add_vg bool: adds the V^G estimates used for recalibration to the
#' result data.frame. Default = FALSE.
#' @param variance_offset numeric: add an offset to all V^G estimates. Default
#' = 0.
#' @param FC_col_name char: column of df_de that contains the log fold change
#' values that are recalibrated. Default = "log2FoldChange".
#' @returns A modified data.frame with added recalibrated fold changes.
#' @examples
#' df <- data.frame(log2FoldChange = c(-2.95, 1.03, 4.34),
#'   padj = c(0, 1e-2, 1e-5),
#'   row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457"))
#'
#' recalibrateFoldChange(df)
#' recalibrateFoldChange(df, tissue = "NERVET", vg = vg_aeml)
#' recalibrateFoldChange(df, sort_by = "padj", add_vg = TRUE)
#' @export
recalibrateFoldChange <- function(df_de, vg = "vg_ae", tissue = "MEAN", remove_NA = FALSE,
                                  sort_by = NA, add_vg = FALSE, variance_offset = 0,
                                  FC_col_name = "log2FoldChange") {
  if (is.character(vg) && vg == "vg_ae") {
    vg <- get("vg_ae") # via lazy-loading of the attached dataset
  }
  if (!is.element(tissue, colnames(vg))) {
    stop("Unknown tissue. You have to specify one GTEx tissue in 6-letter code or use 'MEAN'.")
  }

  # genes = row.names(vg)[which(!is.na(vg[,tissue]))]
  # vg_tissue = vg[which(!is.na(vg[,tissue])), tissue]

  vg_select <- vg[row.names(df_de), tissue]
  sdg_select <- sqrt(vg_select + variance_offset)

  df_de$recalibratedFC <- df_de[, FC_col_name] / sdg_select

  if (add_vg) {
    df_de$vg <- vg_select
  }

  if (remove_NA) {
    df_de <- df_de[which(!is.na(df_de$recalibratedFC)), ]
  }

  if (is.element(sort_by, colnames(df_de))) {
    df_de <- df_de[order(df_de[, sort_by]), ]
  }

  return(df_de)
}
