test_that("basic recalibration", {
  df_input <- data.frame(
    log2FoldChange = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457")
  )
  df <- recalibrateFoldChange(df_input)

  expect_equal(is.data.frame(df), TRUE)
  expect_equal(colnames(df), c("log2FoldChange", "padj", "recalibratedFC"))
  expect_equal(rownames(df), c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457"))
  expect_equal(nrow(df), 3)
  expect_equal(df$recalibratedFC, c(NA, -10.39488038, 49.14477305))
})

test_that("different VG versions", {
  df_input <- data.frame(
    log2FoldChange = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457")
  )

  # recalibration with ML based VG
  df <- recalibrateFoldChange(df_input, vg = vg_ae)
  expect_equal(df$recalibratedFC, c(NA, -10.9200949, 86.1000958))

  # tissue specific recalibration
  df <- recalibrateFoldChange(df_input, tissue = "WHLBLD")
  expect_equal(df$recalibratedFC, c(NA, -3.81962328, 25.79571630))

  # tissue that does not exist
  expect_error(recalibrateFoldChange(df_input, tissue = "BLOOD"))
  # VG that does not exist
  expect_error(recalibrateFoldChange(df_input, vg = 'vgo'))
})

test_that("removing genes", {
  df_input <- data.frame(
    log2FoldChange = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457")
  )

  # remove all genes that could not be recalibrated
  df <- recalibrateFoldChange(df_input, remove_NA = TRUE)
  expect_equal(rownames(df), c("ENSG00000000419", "ENSG00000000457"))

  # "names" that are not in VG
  df_input2 <- data.frame(
    log2FoldChange = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000002", "ENSG", "ENSG00000000457")
  )
  df <- recalibrateFoldChange(df_input2, remove_NA = TRUE)
  expect_equal(rownames(df), c("ENSG00000000457"))
})

test_that("column operations", {
  df_input <- data.frame(
    log2FoldChange = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457")
  )

  # sort by one column
  df <- recalibrateFoldChange(df_input, sort_by = "padj")
  expect_equal(rownames(df), c("ENSG00000000003", "ENSG00000000457", "ENSG00000000419"))

  # add VG estimates in results
  df <- recalibrateFoldChange(df_input, add_vg = TRUE)
  expect_equal(colnames(df), c("log2FoldChange", "padj", "recalibratedFC", "vg"))
  expect_equal(df$vg, c(NA, 0.009818281, 0.007798746278))
})

test_that("variance offset", {
  df_input <- data.frame(
    log2FoldChange = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457")
  )

  df <- recalibrateFoldChange(df_input, variance_offset = 0.01)
  expect_equal(df$recalibratedFC, c(NA, -7.316514, 32.530821))
})

test_that("different fold change column name", {
  df_input3 <- data.frame(
    FC = c(2.95, -1.03, 4.34),
    padj = c(0, 1e-2, 1e-5),
    row.names = c("ENSG00000000003", "ENSG00000000419", "ENSG00000000457")
  )
  df <- recalibrateFoldChange(df_input3, FC_col_name = "FC")
  expect_equal(colnames(df), c("FC", "padj", "recalibratedFC"))
  expect_equal(df$recalibratedFC, c(NA, -10.39488038,  49.14477305))
})
