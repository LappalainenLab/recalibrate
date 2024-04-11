#' @export
recalibrateFoldChange <- function(df_de, tissue = "MEAN", vg = vg, remove_NA = FALSE,
                                  sort_by = NA, add_vg = FALSE, variance_offset = 0,
                                  FC_col_name = "log2FoldChange") {

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
