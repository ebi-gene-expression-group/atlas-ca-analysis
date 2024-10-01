
def read_metadata(metadatapath, dataid):
    """
    Read and merge the two metadata tables
    """
    metadata_file = os.path.join(metadatapath, f"{dataid}.merged.csv")
    ena_ids_file = os.path.join(metadatapath, f"{dataid}.enaIds.txt")

    merged_data = {}

    # read the metadata file (merged.csv)
    with open(metadata_file, 'r') as file:
        metadata = [line.strip().split('\t') for line in file.readlines()]

    # read the enaIds.txt file
    with open(ena_ids_file, 'r') as file:
        ena_ids = [line.strip().split('\t') for line in file.readlines()]

    # create a dictionary from ena_ids where key is ega_run_id and value is ena_run_id
    ena_dict = {line[0]: line[1] for line in ena_ids[1:]}  # skip the header

    # find indices for the required columns in the metadata file
    header = metadata[0]
    ega_run_id_idx = header.index('ega_run_id')
    filename_idx = header.index('filename')
    file_accession_id_idx = header.index('file_accession_id')

    # final data with selected columns
    final_data = []
    for row in metadata[1:]:
        ega_run_id = row[ega_run_id_idx]
        ena_run_id = ena_dict.get(ega_run_id, None)
        file_accession_id = row[file_accession_id_idx]
        filename = row[filename_idx]

        final_data.append([ega_run_id, ena_run_id, filename, file_accession_id])

    return final_data


def get_unique_ena_runs(merged_table):
    # extract the second column
    ena_runs = [row[1] for row in merged_table]

    # get unique values, keep the order
    unique_ena_runs = list(dict.fromkeys(ena_runs))

    return unique_ena_runs


def get_mem_mb(wildcards, attempt):
    """
    To adjust resources in rule run_irap
    attemps = reiterations + 1
    Max number attemps = 6
    """
    mem_avail = [ 48, 64, 96, 128, 210, 300 ]
    if attempt > len(mem_avail):
        print(f"Attemps {attempt} exceeds the maximum number of attemps: {len(mem_avail)}")
        print(f"modify value of --restart-times or adjust mem_avail resources accordingly")
        sys.exit(1)
    else:
        return mem_avail[attempt-1] * 1000

