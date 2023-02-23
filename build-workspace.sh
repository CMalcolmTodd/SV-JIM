#!/bin/bash

SAMPLE_PREFIX=$1

# Test if existing directory exits. If true terminate process and advise user, otherwise build workspace
if [ -d "./${SAMPLE_PREFIX}_Workflow_Outputs" ]; then
	echo "Workspace parent directory already exist in the current directory! Terminating..."
	exit 1
fi

#Store workspace key areas
PARENT_DIR=./${SAMPLE_PREFIX}_Workflow_Outputs
GENOMES=$PARENT_DIR/Genomes
LR_DIR=$PARENT_DIR/Long_Reads
ALIGNMENTS=$PARENT_DIR/Alignments
QUALIMAP_DIR=$PARENT_DIR/Qualimap_Reports
SV_RESULTS=$PARENT_DIR/SV_Calls
INTERSECTIONS=$PARENT_DIR/Intersections
TRUVARI_RESULTS=$PARENT_DIR/Truvari_Results

echo "Building Parent Directory!.."
mkdir $PARENT_DIR

#Build first layer of workspace directory structure
echo "Building first level directories!.."
mkdir $GENOMES
mkdir $LR_DIR
mkdir $ALIGNMENTS
mkdir $QUALIMAP_DIR
mkdir $SV_RESULTS 
mkdir $INTERSECTIONS
mkdir $TRUVARI_RESULTS

#Build SV Result Subfolders
echo "Building SV result subdirectories for each SV caller!.."
mkdir $SV_RESULTS/CuteSV
mkdir $SV_RESULTS/Sniffles
mkdir $SV_RESULTS/SVIM
mkdir $SV_RESULTS/SVIM-ASM
mkdir $SV_RESULTS/PAV

#Build Intersection Subfolders
echo "Building intersection set subdirectories!.."
mkdir $INTERSECTIONS/Sniffles-SVIM
mkdir $INTERSECTIONS/Sniffles-CuteSV
mkdir $INTERSECTIONS/SVIM-CuteSV
mkdir $INTERSECTIONS/SVIM-ASM-CuteSV
mkdir $INTERSECTIONS/SVIM-ASM-Sniffles
mkdir $INTERSECTIONS/SVIM-ASM-SVIM
mkdir $INTERSECTIONS/PAV-CuteSV
mkdir $INTERSECTIONS/PAV-Sniffles
mkdir $INTERSECTIONS/PAV-SVIM
mkdir $INTERSECTIONS/PAV-SVIM-ASM
mkdir $INTERSECTIONS/All-Read-Callers
mkdir $INTERSECTIONS/Sniffles-CuteSV-SVIM-ASM-SVIM
mkdir $INTERSECTIONS/All-Callers

#Build Truvari Subfolders
echo "Building Truvari result set subdirectories!.."
mkdir $TRUVARI_RESULTS/Sniffles-SVIM
mkdir $TRUVARI_RESULTS/Sniffles-CuteSV
mkdir $TRUVARI_RESULTS/SVIM-CuteSV
mkdir $TRUVARI_RESULTS/SVIM-ASM-CuteSV
mkdir $TRUVARI_RESULTS/SVIM-ASM-Sniffles
mkdir $TRUVARI_RESULTS/SVIM-ASM-SVIM
mkdir $TRUVARI_RESULTS/PAV-CuteSV
mkdir $TRUVARI_RESULTS/PAV-Sniffles
mkdir $TRUVARI_RESULTS/PAV-SVIM
mkdir $TRUVARI_RESULTS/PAV-SVIM-ASM
mkdir $TRUVARI_RESULTS/All-Read-Callers
mkdir $TRUVARI_RESULTS/Sniffles-CuteSV-SVIM-ASM-SVIM 
mkdir $TRUVARI_RESULTS/All-Callers

echo "Work complete!.."
