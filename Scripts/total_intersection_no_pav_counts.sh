#!/bin/bash

OUTPUT_FILE=$1
SSM_FILE=$2
SML_FILE=$3
MED_FILE=$4
LRG_FILE=$5
TOTAL_FILE=$6

#Extract intersection size column from files into array (Ordered as: Header,#DEL,#INS,#DUP,#INV,#BND,#TOTAL)
SSM_ARRAY=($(awk '{ print $11 }' $SSM_FILE))
SML_ARRAY=($(awk '{ print $11 }' $SML_FILE))
MED_ARRAY=($(awk '{ print $11 }' $MED_FILE))
LRG_ARRAY=($(awk '{ print $11 }' $LRG_FILE))
TOTAL_ARRAY=($(awk '{ print $11 }' $TOTAL_FILE))

#Create file by adding headers
echo "TYPE      SSM     SML     MED     LRG     TOTAL" > $OUTPUT_FILE

#Add DEL counts to file
SSM_DEL_COUNT="${SSM_ARRAY[1]}"
SML_DEL_COUNT="${SML_ARRAY[1]}"
MED_DEL_COUNT="${MED_ARRAY[1]}"
LRG_DEL_COUNT="${LRG_ARRAY[1]}"
TOTAL_DEL_COUNT="${TOTAL_ARRAY[1]}"
echo "DEL	$SSM_DEL_COUNT	$SML_DEL_COUNT	$MED_DEL_COUNT	$LRG_DEL_COUNT	$TOTAL_DEL_COUNT" >> $OUTPUT_FILE

#Add INS counts to file
SSM_INS_COUNT="${SSM_ARRAY[2]}"
SML_INS_COUNT="${SML_ARRAY[2]}"
MED_INS_COUNT="${MED_ARRAY[2]}"
LRG_INS_COUNT="${LRG_ARRAY[2]}"
TOTAL_INS_COUNT="${TOTAL_ARRAY[2]}"
echo "INS	$SSM_INS_COUNT	$SML_INS_COUNT	$MED_INS_COUNT	$LRG_INS_COUNT	$TOTAL_INS_COUNT" >> $OUTPUT_FILE

#Add DUP counts to file
SSM_DUP_COUNT="${SSM_ARRAY[3]}"
SML_DUP_COUNT="${SML_ARRAY[3]}"
MED_DUP_COUNT="${MED_ARRAY[3]}"
LRG_DUP_COUNT="${LRG_ARRAY[3]}"
TOTAL_DUP_COUNT="${TOTAL_ARRAY[3]}"
echo "DUP	$SSM_DUP_COUNT	$SML_DUP_COUNT	$MED_DUP_COUNT	$LRG_DUP_COUNT	$TOTAL_DUP_COUNT" >> $OUTPUT_FILE

#Add INV counts to file
SSM_INV_COUNT="${SSM_ARRAY[4]}"
SML_INV_COUNT="${SML_ARRAY[4]}"
MED_INV_COUNT="${MED_ARRAY[4]}"
LRG_INV_COUNT="${LRG_ARRAY[4]}"
TOTAL_INV_COUNT="${TOTAL_ARRAY[4]}"
echo "INV	$SSM_INV_COUNT	$SML_INV_COUNT	$MED_INV_COUNT	$LRG_INV_COUNT	$TOTAL_INV_COUNT" >> $OUTPUT_FILE

#Add BND counts to file
SSM_BND_COUNT="${SSM_ARRAY[5]}"
echo "BND	$SSM_BND_COUNT	0	0	0	$SSM_BND_COUNT" >> $OUTPUT_FILE

#Add Totals counts to file
SSM_TOTAL_COUNT="${SSM_ARRAY[6]}"
SML_TOTAL_COUNT="${SML_ARRAY[6]}"
MED_TOTAL_COUNT="${MED_ARRAY[6]}"
LRG_TOTAL_COUNT="${LRG_ARRAY[6]}"
TOTAL_TOTAL_COUNT="${TOTAL_ARRAY[6]}"
echo "ALL	$SSM_TOTAL_COUNT	$SML_TOTAL_COUNT	$MED_TOTAL_COUNT	$LRG_TOTAL_COUNT	$TOTAL_TOTAL_COUNT" >> $OUTPUT_FILE
