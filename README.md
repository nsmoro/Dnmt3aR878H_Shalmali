# scRNA-seq Analysis Pipeline Dnmt3aR878H - Platform: Parse Bioscience Evercode WT Kit v3

This repository contains a complete pipeline for analyzing single-cell RNA-seq data and single-cell Transposable Element data.

Mouse genome reference: GRCm38

The analysis uses multiple programming languages:
- Bash (for preprocessing and pipeline steps)
- Python (for handling .h5ad files)
- R (for downstream analysis and visualization)

All scripts used in this project are already included in the folders of this repository.

------------------------------------------------------------

## Main Report

The primary deliverable is a rendered R Markdown report:

Dnmt3aR878H_code.html – rendered analysis report (recommended starting point).

Dnmt3aR878H_code.Rmd – R Markdown source containing all code and narrative.

Please open the Dnmt3aR878H_code.html file in a web browser to view the full analysis.

All data and repositories are stored in "Z:\home\common\Data\NM\Dnmt3aR878H_Shalmali"

------------------------------------------------------------

## Repository Structure

- `codes/` – bash and python scripts used for data processing and pipeline execution
- `counts/` – input data objects
  *(Not included in this repository due to dataset size and restrictions)*
- `csv/` – CSV files generated during analysis
  *(Not included in this repository due to dataset size and restrictions)*
- `gencode/` – files related to GENCODE annotation
  *(Not included in this repository due to file size)*
- `hscscore/` – files and outputs from HSC score analysis
  *(Not included in this repository due to file size)*
- `plots/` – figures and plots generated during the analysis  
- `rda/` – saved `.rda` objects
  *(Not included in this repository due to file size)*
- `scMINER/` – files related to scMINER analysis
  *(Not included in this repository due to file size)*
  
All code used in the analysis is contained directly in the R Markdown document.

Large data files were not added to their respective repository.

------------------------------------------------------------

## Notes on data files

A large serialized R workspace object (workspace.rda) generated during analysis
is not included in the repository to keep it lightweight. All figures and results
are fully reproducible from the provided R Markdown document.

- Paths in scripts may need to be adjusted to your system
- Some steps may require an HPC environment (cluster)
- Make sure all required software is installed before running

------------------------------------------------------------

## Pipeline Overview

The main steps of the analysis include:

1. FASTQ preprocessing and merging (Bash scripts)
2. BAM file processing using samtools
3. Transposable element quantification using scTE
4. Downstream analysis using R and Python
5. Data format conversion between tools

------------------------------------------------------------

## scTE Important Note

To convert .h5ad files into .h5seurat format:

- You MUST use Seurat version lower than 5.0
- After the conversion is completed, upgrade Seurat to version higher than 5.0

This step is required for compatibility between file formats.

------------------------------------------------------------

## Package Versions

All R package versions used in this project are recorded using:

sessionInfo()

Please check the RMarkdown files in this repository to see the exact versions.

------------------------------------------------------------

## Required Files

Links to download all required data are provided inside the RMarkdown files.

------------------------------------------------------------

## How to Run the Pipeline

Each step can be run separately:

1. Run FASTQ processing scripts (Bash)
2. Run BAM processing with samtools
3. Run scTE on filtered BAM files
4. Perform analysis in R and Python

Check the scripts in each folder for details.

------------------------------------------------------------

## Session Info

R version 4.4.1 (2024-06-14 ucrt)
Platform: x86_64-w64-mingw32/x64
Running under: Windows 11 x64 (build 26200)

Matrix products: default

locale:
[1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8    LC_MONETARY=English_United States.utf8
[4] LC_NUMERIC=C                           LC_TIME=English_United States.utf8    

time zone: America/Chicago
tzcode source: internal

attached base packages:
[1] grid      stats4    stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] igraph_2.3.0                kableExtra_1.4.0            scMINER_1.1.0               Matrix_1.7-4               
 [5] ReactomePA_1.48.0           orthogene_1.10.0            SurfR_1.0.0                 biomaRt_2.60.1             
 [9] GOplot_1.0.2                ggdendro_0.2.0              enrichplot_1.24.4           HGNChelper_0.8.15          
[13] circlize_0.4.17             clusterProfiler_4.13.2      msigdbr_25.1.1              monocle3_1.3.7             
[17] org.Mm.eg.db_3.19.1         AnnotationDbi_1.66.0        SeuratDisk_0.0.0.9021       DEsingle_1.24.0            
[21] DESeq2_1.44.0               edgeR_4.2.2                 limma_3.60.6                GOSemSim_2.30.2            
[25] DOSE_3.30.5                 plotrix_3.8-13              cetcolor_0.2.0              scales_1.4.0               
[29] viridis_0.6.5               viridisLite_0.4.3           paletteer_1.7.0             corrplot_0.95              
[33] ggcorrplot_0.1.4.1          RColorBrewer_1.1-3          cowplot_1.2.0               ComplexHeatmap_2.20.0      
[37] pheatmap_1.0.13             gridtext_0.1.5              gridExtra_2.3               lubridate_1.9.5            
[41] forcats_1.0.1               stringr_1.6.0               purrr_1.2.2                 readr_2.1.6                
[45] tidyr_1.3.2                 tibble_3.3.1                tidyverse_2.0.0             dendextend_1.19.1          
[49] ggrepel_0.9.8               reshape2_1.4.5              dplyr_1.2.1                 scCustomize_3.2.4          
[53] Seurat.utils_2.8.0          Seurat_5.5.0                SeuratObject_5.4.0          sp_2.2-1                   
[57] magrittr_2.0.5              ggExpress_0.9.0             MarkdownHelpers_1.0.7       ggpubr_0.6.2               
[61] ggplot2_4.0.3               CodeAndRoll2_2.6.0          Stringendo_0.6.0            SingleCellExperiment_1.26.0
[65] SummarizedExperiment_1.34.0 Biobase_2.64.0              MatrixGenerics_1.16.0       matrixStats_1.5.0          
[69] R.utils_2.13.0              R.oo_1.27.1                 R.methodsS3_1.8.2           rtracklayer_1.64.0         
[73] GenomicRanges_1.56.2        GenomeInfoDb_1.40.1         IRanges_2.38.1              S4Vectors_0.42.1           
[77] BiocGenerics_0.50.0         patchwork_1.3.2             here_1.0.2                 

loaded via a namespace (and not attached):
  [1] DBI_1.2.3                   bslib_0.11.0                homologene_1.4.68.19.3.27   httr_1.4.8                 
  [5] BiocParallel_1.38.0         prettyunits_1.2.0           yulab.utils_0.2.4           ggplotify_0.1.3            
  [9] GenomicAlignments_1.40.0    sparseMatrixStats_1.16.0    spatstat.geom_3.7-3         babelgene_22.9             
 [13] splitstackshape_1.4.8       pillar_1.11.1               R6_2.6.1                    boot_1.3-32                
 [17] mime_0.13                   reticulate_1.46.0           uwot_0.2.4                  Rhdf5lib_1.26.0            
 [21] job_0.3.1                   vegan_2.7-2                 ROCR_1.0-12                 graphite_1.50.0            
 [25] Hmisc_5.2-5                 colorRamps_2.3.4            rprojroot_2.1.1             downloader_0.4.1           
 [29] S7_0.2.2                    parallelly_1.47.0           GlobalOptions_0.1.3         rbibutils_2.4.1            
 [33] caTools_1.18.3              mgcv_1.9-4                  polyclip_1.10-7             htmltools_0.5.9            
 [37] lambda.r_1.2.4              car_3.1-5                   stringfish_0.18.0           fgsea_1.30.0               
 [41] snakecase_0.11.1            spatstat.utils_3.2-2        rpart_4.1.24                clue_0.3-66                
 [45] scatterpie_0.2.6            fitdistrplus_1.2-6          goftest_1.2-3               tidyselect_1.2.1           
 [49] RSQLite_2.4.6               GenomeInfoDbData_1.2.12     scattermore_1.2             sessioninfo_1.2.3          
 [53] spatstat.data_3.1-9         fs_2.1.0                    rvest_1.0.5                 sctransform_0.4.3          
 [57] graph_1.82.0                future.apply_1.20.2         ggVennDiagram_1.5.7         RcppHNSW_0.6.0             
 [61] reactome.db_1.88.0          vipor_0.4.7                 enrichR_3.4                 Rtsne_0.17                 
 [65] TCGAbiolinksGUI.data_1.24.0 lazyeval_0.2.3              sass_0.4.10                 carData_3.0-6              
 [69] treeio_1.28.0               bitops_1.0-9                KEGGREST_1.44.1             promises_1.5.0             
 [73] shape_1.4.6.1               rhdf5filters_1.16.0         zoo_1.8-15                  princurve_2.1.6            
 [77] locfit_1.5-9.12             DelayedArray_0.30.1         bbmle_1.0.25.1              RSpectra_0.16-2            
 [81] assertthat_0.2.1            tools_4.4.1                 ape_5.8-1                   shiny_1.13.0               
 [85] BiocFileCache_2.12.0        gamlss.data_6.0-7           ReadWriter_1.5.4            rlang_1.1.7                
 [89] generics_0.1.4              ggridges_0.5.7              evaluate_1.0.5              httr2_1.2.2                
 [93] fastcluster_1.3.0           BiocIO_1.14.0               tictoc_1.2.1                otel_0.2.0                 
 [97] colorspace_2.1-1            data.table_1.18.2.1         withr_3.0.2                 RCurl_1.98-1.17            
[101] futile.logger_1.4.9         restfulr_0.0.16             gamlss.dist_6.1-1           xtable_1.8-8               
[105] plyr_1.8.9                  lme4_1.1-38                 aplot_0.2.9                 systemfonts_1.3.1          
[109] httpuv_1.6.17               rmarkdown_2.31              MarkdownReports_4.7.1       MASS_7.3-65                
[113] openxlsx_4.2.8.1            broom_1.0.12                deldir_2.0-4                GO.db_3.19.1               
[117] sandwich_3.1-1              rhdf5_2.48.0                tensor_1.5.1                vctrs_0.7.3                
[121] lifecycle_1.0.5             codetools_0.2-20            fastDummies_1.7.6           venn_1.12                  
[125] nlme_3.1-168                phyloseq_1.48.0             future_1.70.0               clipr_0.8.0                
[129] SoupX_1.6.2                 progress_1.2.3              dbplyr_2.5.1                jquerylib_0.1.4            
[133] Rcpp_1.1.1-1.1              rstudioapi_0.18.0           stringi_1.8.7               miscTools_0.6-30           
[137] VGAM_1.1-14                 hms_1.1.4                   pbapply_1.7-4               minqa_1.2.8                
[141] cachem_1.1.0                multtest_2.60.0             BiocManager_1.30.27         hdf5r_1.3.12               
[145] tidytree_0.4.7              listenv_0.10.1              XVector_0.44.0              ggrastr_1.0.2              
[149] plotly_4.12.0               WGCNA_1.74                  ggtree_3.12.0               vioplot_0.5.1              
[153] GetoptLong_1.1.0            ggfun_0.2.0                 SparseArray_1.4.8           htmlwidgets_1.6.4          
[157] Formula_1.2-5               BiocStyle_2.32.1            memoise_2.0.1               crayon_1.5.3               
[161] gridGraphics_0.5-1          rappdirs_0.3.4              S4Arrays_1.4.1              xml2_1.5.2                 
[165] filelock_1.0.3              preprocessCore_1.66.0       gprofiler2_0.2.4            UCSC.utils_1.0.0           
[169] png_0.1-9                   progressr_0.19.0            tzdb_0.5.0                  fastmap_1.2.0              
[173] tidygraph_1.3.1             pkgconfig_2.0.3             cli_3.6.5                   beeswarm_0.4.0             
[177] ggforce_0.4.2               DatabaseLinke.R_1.7.0       pscl_1.5.9                  ggiraph_0.9.4              
[181] ggsignif_0.6.4              nnet_7.3-20                 maxLik_1.5-2.2              lmtest_0.9-40              
[185] textshaping_1.0.4           RcppAnnoy_0.0.23            qs_0.27.3                   gdtools_0.5.0              
[189] timechange_0.4.0            foreign_0.8-91              splines_4.4.1               blob_1.3.0                 
[193] impute_1.78.0               XML_3.99-0.22               numDeriv_2016.8-1.1         assertr_3.0.1              
[197] globals_0.19.1              ggbeeswarm_0.7.3            permute_0.9-10              knitr_1.51                 
[201] ggprism_1.0.7               ica_1.0-3                   spam_2.11-3                 dichromat_2.0-0.1          
[205] EnhancedVolcano_1.22.0      compiler_4.4.1              rjson_0.2.23                WriteXLS_6.8.0             
[209] reformulas_0.4.4            janitor_2.2.1               RcppParallel_5.1.11-1       bit_4.6.0                  
[213] sm_2.2-6.0                  glue_1.8.1                  gamlss_5.4-22               formatR_1.14               
[217] digest_0.6.37               SPsimSeq_1.14.0             irlba_2.3.7                 bdsmatrix_1.3-7            
[221] graphlayouts_1.2.2          magick_2.9.0                fontLiberation_0.1.0        foreach_1.5.2              
[225] mcprogress_0.1.1            RApiSerialize_0.1.4         vroom_1.7.0                 fontBitstreamVera_0.1.1    
[229] spatstat.random_3.4-5       zlibbioc_1.50.0             dotCall64_1.2               tweenr_2.0.3               
[233] lattice_0.22-9              statmod_1.5.1               ggraph_2.2.2                gson_0.1.0                 
[237] nloptr_2.2.1                mvtnorm_1.3-3               yaml_2.3.12                 qvalue_2.36.0              
[241] biomformat_1.32.0           metaRNASeq_1.0.8            later_1.4.8                 backports_1.5.0            
[245] rstatix_0.7.3               admisc_0.39                 shadowtext_0.1.6            Rsamtools_2.20.0           
[249] parallel_4.4.1              rematch2_2.1.2              VennDiagram_1.8.2           fontquiver_0.2.1           
[253] miniUI_0.1.2                gtable_0.3.6                abind_1.4-8                 xfun_0.56                  
[257] ade4_1.7-23                 Cairo_1.7-0                 Biostrings_2.72.1           curl_6.3.0                 
[261] doParallel_1.0.17           dynamicTreeCut_1.63-1       KernSmooth_2.23-26          futile.options_1.0.1       
[265] survival_3.8-6              jsonlite_2.0.0              svglite_2.2.2               base64enc_0.1-6            
[269] iterators_1.0.14            spatstat.univar_3.1-7       TCGAbiolinks_2.32.0         fastmatch_1.1-6            
[273] checkmate_2.3.2             gtools_3.9.5                htmlTable_2.4.3             spatstat.sparse_3.1-0      
[277] RANN_2.6.2                  spatstat.explore_3.8-0      bit64_4.6.0-1               cluster_2.1.8.1            
[281] Rdpack_2.6.6                farver_2.1.2                grr_0.9.5                   zip_2.3.3                  
[285] gplots_3.3.0               

## R.version
               _                                
platform       x86_64-w64-mingw32               
arch           x86_64                           
os             mingw32                          
crt            ucrt                             
system         x86_64, mingw32                  
status                                          
major          4                                
minor          4.1                              
year           2024                             
month          06                               
day            14                               
svn rev        86737                            
language       R                                
version.string R version 4.4.1 (2024-06-14 ucrt)
nickname       Race for Your Life               

------------------------------------------------------------

## Author

Prepared by: **Silva Morosini, Natalia**  
Date: **May 29, 2026**