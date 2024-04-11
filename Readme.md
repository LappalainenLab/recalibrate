
This is an accompanying package to our gene expression fold change recalibration
manuscript, [published on bioRxiv](https://www.biorxiv.org/content/10.1101/2024.04.10.588830v1).
It enables anyone to perform the transformation of log fold changes, as obtained
from any RNA-Seq differential expression experiment, into reclibrated fold
changes. This means that the changes in expression can be compared relative
to the genetic population variability of each gene.
As is described in detail in our manuscript, using recalibrated fold changes
enriches experimental results for genes that are potentially functionally
relevant.

# Installation

While we are polishing this to publish it as a general R package, it is currently
necessary to install this package directly from Github.

```r
library(devtools)
install_github("LappalainenLab/recalibrate")
```

# Usage

```r
library(recalibrate)

# given a data.frame df with column 'log2FoldChange' and row.names as Ensembl
# gene ids (as obtained from DESeq2)
#
# > head(df, 1)
#                 baseMean log2FoldChange padj
# ENSG00000152213   354.65      0.3041446    0

recalibrateFoldChange(df, add_vg=TRUE)

#                 baseMean log2FoldChange padj         vg recalibratedFC
# ENSG00000152213   354.65      0.3041446    0 0.00197779       6.838959
```
