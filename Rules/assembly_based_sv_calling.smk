rule sv_calling_w_svim_asm:
        input:
                indexFile=str(MNMP2_GENOMES_PREFIX + ".sorted.bam.bai"),
                inputFile=str(MNMP2_GENOMES_PREFIX + ".sorted.bam")
        output:
                str(SVIM_ASM_PREFIX + ".ALL.vcf")
        threads: config["threads"]
        params:
                minMAPQ=config["minMAPQForSVs"],
                minSize=config["minSizeForSVs"],
                maxSize=config["maxSizeForSVs"],
                svOutDir=str(SV_RESULTS_DIR +"/SVIM-ASM"),
                refGenome=REF_FILTERED
        conda:
                config["svimASMCondaEnvYAML"]
        shell:
                "svim-asm haploid --min_mapq {params.minMAPQ} --min_sv_size {params.minSize} --max_sv_size {params.maxSize} {params.svOutDir} {input.inputFile} {params.refGenome};"
                "mv {params.svOutDir}/variants.vcf {output}"

rule sv_calling_w_pav:
        input:
                refGenome=REF_FILTERED,
                qryGenome=QRY_FILTERED
        output:
                str(SV_RESULTS_DIR + "/PAV/pav_"+ QRY_SAMP_NAME + ".vcf.gz")
        threads: config["threads"]
        params:
                outputDir=str(SV_RESULTS_DIR + "/PAV/")
        conda:
                config["pavCondaEnvYAML"]
        shell:
                "bash ./Scripts/run-PAV-SnakeMake-pipe.sh {threads} {params.outputDir} {input.refGenome}"

rule unzip_and_rename_pav_results:
        input:
               str(SV_RESULTS_DIR + "/PAV/pav_"+ QRY_SAMP_NAME + ".vcf.gz")
        output:
               str(PAV_PREFIX + ".ALL.vcf")
        threads: config["threads"]
        params:
               str(SV_RESULTS_DIR +"/PAV/")
        shell:
               "gunzip -c {input} > {output};"
