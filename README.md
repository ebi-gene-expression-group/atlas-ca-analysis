# Atlas analysis for controlled-access datasets
This is for data coming from EGA, but it will be extended to other sources. 

For GTEX data, see https://github.com/ebi-gene-expression-group/atlas-gtex-bulk.

## Prerequisites
- For EGA, download the data and and arrange for analysis as indicated [here](https://github.com/ebi-gene-expression-group/ega_downloader).
- Snakemake >= 7.25.3
- SLURM cluster management and job scheduling system

## Analysis of EGA datasets

## 1. Data preparation
The and metadata should be in the format:

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
