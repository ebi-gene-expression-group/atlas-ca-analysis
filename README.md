# Atlas analysis for controlled-access datasets
This repo initially is for the analysis of RNA sequencing data coming from European Genome-phenome Archive (EGA), but it will be extended to other sources. 

For GTEX RNA-seq data, see https://github.com/ebi-gene-expression-group/atlas-gtex-bulk.

## Prerequisites
- Snakemake >= 7.25.3
- SLURM cluster management and job scheduling system
- Two scripts located at the config `private_script`:
  - ega_bulk_env.sh
  - ega_bulk_init.sh

## 1. Analysis of EGA datasets

## 1.1 Data preparation
For EGA, download the data and and arrange for analysis as indicated [here](https://github.com/ebi-gene-expression-group/ega_downloader).


The data and metadata should be in the format:

```
data
    |- EGAD00001011134
      |- EGAF00008123877
        |- Sample-509_1.fastq.gz
        |- Sample-509_1.fastq.gz.md5
      |- ...
metadata
    |- EGAD00001011134.merged.csv
    |- EGAD00001011134.enaIds.txt
```
The file `.enaIds.txt` is provided by curators and contains the matches between EGA run and ENA run ids.

Then run the `Snakefile-ega` workflow:

```
snakemake --restart-times 1 --keep-going \\
  --profile slurm-profile \\
  --latency-wait 150 -p --cores 1 \\
  --config dataset_id=EGADxxxxxxxxxx \\
      input_path=/path-to-data/data \\
      metadata_path=/path-to-metadata/metadata \\
  -s Snakefile-ega

```


## 2.1 Data analysis

The workflow `Snakefile-irap` will validate fastqs, run Irap and prepare the results for aggregation:

```
snakemake --restart-times 1 --keep-going \\
  --profile slurm-profile --latency-wait 150 -p --use-conda \\
  --conda-frontend conda --conda-base-path /conda-base-path \\
  --conda-prefix /conda-prefix-path/conda \\
  --cores 1 \\
  --config dataset_id=EGADxxxxxxxxxx \\
    metadata_path=/path-to-metadata/metadata \\
    read_type=pe \\
    atlas_ca_root=/path-to-github-repo/atlas-ca-analysis \\
    private_script=/path-private_script/gitlab_scripts \\
    irap_config=/path-to-config/homo_sapiens.conf \\
  -s Snakefile-irap

```
