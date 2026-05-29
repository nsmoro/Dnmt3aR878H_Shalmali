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

## scTE Important Note

To convert .h5ad files into .h5seurat format:

- You MUST use Seurat version lower than 5.0
- After the conversion is completed, upgrade Seurat to version higher than 5.0

This step is required for compatibility between file formats.

------------------------------------------------------------

## Required Files

Links to download all required data are provided inside the RMarkdown files.

------------------------------------------------------------

## How to Run the Pipeline

The main steps of the analysis include:

1. FASTQ preprocessing and merging (Bash scripts)
	- 0_merge.sh (upload these merged files to Trailmaker).
	- 1_transfer.py (transferring files between HPC and Trailmaker).
	- 2_unzip_Trailmaker.sh (once you transferred Trailmaker outputs to HPC, unzip them).
2. BAM file processing using samtools
	- 3_convert_bam.sh (required to use ParseBio outputs in scTE package).
3. Transposable element quantification using scTE
	- 4_scte.sh
4. Downstream analysis using R, Bash and Python
	- 5_hscscore.py
	- 6_mica.sh
	- 7_extract_sjaracne.sh (only if using Windows).
	- 8_rebuilding_sjaracne.sh (only if using Windows).
	- 9_cleaning_sjaracne.sh
	- 10_paths_sjaracne.sh
	- 11_run_sjaracne.sh

------------------------------------------------------------

## Package Versions

All R package versions used in this project are recorded using:

sessionInfo()

Please check the Dnmt3aR878H_code.html file in this repository to see the exact versions.

------------------------------------------------------------

## Author

Prepared by: **Silva Morosini, Natalia**  
Date: **May 29, 2026**