import os
import glob
import pysam
from snakemake.utils import min_version


min_version("7.25.3")

SAMPLES, = glob_wildcards(config["input_path"]+"/{egafile}/{sample}.fastq.gz")
# example path input_path = "data/EGADXXXX/EGAFXXXXXX/SAMPLENAME.fastq.gz"

FIRST_SAMPLE = str(SAMPLES[0])

def get_mem_mb(wildcards, attempt):
    """
    To adjust resources in rule run_irap
    attemps = reiterations + 1
    Max number attemps = 6
    """
    mem_avail = [ 16, 32, 48, 64, 128, 300 ]  
    if attempt > len(mem_avail):
        print(f"Attemps {attempt} exceeds the maximum number of attemps: {len(mem_avail)}")
        print(f"modify value of --restart-times or adjust mem_avail resources accordingly")
        sys.exit(1)
    else:
        return mem_avail[attempt-1] * 1000

rule all:
    input: "out/workflow.done"


checkpoint validating_fastq:
    """
    Here if else statement could be modified to run iRAP/ISL for PE and SE data.
    """

rule fast_qc:


rule run_irap_stage0:
    """
    This ensures Irap stage0 is run only once, for the first sample
    """

rule run_irap:

rule prepare_aggregation:

rule final_workflow_check: