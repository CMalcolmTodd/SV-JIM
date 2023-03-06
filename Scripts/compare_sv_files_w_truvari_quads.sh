#!/bin/bash

TRUVARI_DIR_A=$1
TRUVARI_DIR_B=$2
REF_GENOME=$3
MIN_SIZE=$4
MAX_SIZE=$5
OVERLAP=$6
MAX_REF_DIST=$7
OUTPUT_DIR=$8
SV_TYPE=$9

#Truvari requires sorted, zipped, and indexed VCF files as input. (Re)Generate files before starting Truvari bench
bcftools sort -o ${TRUVARI_DIR_A}/tp-call.sorted.vcf $TRUVARI_DIR_A/tp-call.vcf
bgzip -c ${TRUVARI_DIR_A}/tp-call.sorted.vcf > ${TRUVARI_DIR_A}/tp-call.sorted.vcf.gz
tabix ${TRUVARI_DIR_A}/tp-call.sorted.vcf.gz

bcftools sort -o ${TRUVARI_DIR_A}/tp-base.sorted.vcf $TRUVARI_DIR_A/tp-base.vcf
bgzip -c ${TRUVARI_DIR_A}/tp-base.sorted.vcf > ${TRUVARI_DIR_A}/tp-base.sorted.vcf.gz
tabix ${TRUVARI_DIR_A}/tp-base.sorted.vcf.gz

bcftools sort -o ${TRUVARI_DIR_B}/tp-call.sorted.vcf $TRUVARI_DIR_B/tp-call.vcf
bgzip -c ${TRUVARI_DIR_B}/tp-call.sorted.vcf > ${TRUVARI_DIR_B}/tp-call.sorted.vcf.gz
tabix ${TRUVARI_DIR_B}/tp-call.sorted.vcf.gz

bcftools sort -o ${TRUVARI_DIR_B}/tp-base.sorted.vcf $TRUVARI_DIR_B/tp-base.vcf
bgzip -c ${TRUVARI_DIR_B}/tp-base.sorted.vcf > ${TRUVARI_DIR_B}/tp-base.sorted.vcf.gz
tabix ${TRUVARI_DIR_B}/tp-base.sorted.vcf.gz

#Truvari creates the output directory during execution and won't overwrite an existing directory. Remove target $OUTPUT_DIR if it already exists.
if [ -d $OUTPUT_DIR/$SV_TYPE/Call/FromTPCall ]
then
	echo "$OUTPUT_DIR already exists! Removing to allow truvari to run!.. "
	rm -r $OUTPUT_DIR/$SV_TYPE/Call/FromTPCall
fi

if [ -d $OUTPUT_DIR/$SV_TYPE/Call/FromTPBase ]
then
        echo "$OUTPUT_DIR already exists! Removing to allow truvari to run!.. "
        rm -r $OUTPUT_DIR/$SV_TYPE/Call/FromTPBase
fi

if [ -d $OUTPUT_DIR/$SV_TYPE/Base/FromTPCall ]
then
        echo "$OUTPUT_DIR already exists! Removing to allow truvari to run!.. "
        rm -r $OUTPUT_DIR/$SV_TYPE/Base/FromTPCall
fi

if [ -d $OUTPUT_DIR/$SV_TYPE/Base/FromTPBase ]
then
        echo "$OUTPUT_DIR already exists! Removing to allow truvari to run!.. "
        rm -r $OUTPUT_DIR/$SV_TYPE/Base/FromTPBase
fi

#Execute Truvari Bench to compare the VCF files provided in the script's arguments
truvari bench -o $OUTPUT_DIR/$SV_TYPE/Call/FromTPCall -f $REF_GENOME -b ${TRUVARI_DIR_A}/tp-call.sorted.vcf.gz -c ${TRUVARI_DIR_B}/tp-call.sorted.vcf.gz -s $MIN_SIZE --sizemax $MAX_SIZE -r $MAX_REF_DIST -p 0 -P $OVERLAP -C $MAX_REF_DIST
truvari bench -o $OUTPUT_DIR/$SV_TYPE/Call/FromTPBase -f $REF_GENOME -b ${TRUVARI_DIR_A}/tp-call.sorted.vcf.gz -c ${TRUVARI_DIR_B}/tp-base.sorted.vcf.gz -s $MIN_SIZE --sizemax $MAX_SIZE -r $MAX_REF_DIST -p 0 -P $OVERLAP -C $MAX_REF_DIST
truvari bench -o $OUTPUT_DIR/$SV_TYPE/Base/FromTPCall -f $REF_GENOME -b ${TRUVARI_DIR_A}/tp-base.sorted.vcf.gz -c ${TRUVARI_DIR_B}/tp-call.sorted.vcf.gz -s $MIN_SIZE --sizemax $MAX_SIZE -r $MAX_REF_DIST -p 0 -P $OVERLAP -C $MAX_REF_DIST
truvari bench -o $OUTPUT_DIR/$SV_TYPE/Base/FromTPBase -f $REF_GENOME -b ${TRUVARI_DIR_A}/tp-base.sorted.vcf.gz -c ${TRUVARI_DIR_B}/tp-base.sorted.vcf.gz -s $MIN_SIZE --sizemax $MAX_SIZE -r $MAX_REF_DIST -p 0 -P $OVERLAP -C $MAX_REF_DIST
