#!/usr/bin/env bash

# Copyright (C) 2018 Jasper Boom

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License version 3 as
# published by the Free Software Foundation.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.

# Prequisites:
# - sudo apt-get install default-jre

# Galaxy prequisites:
# - Add "sanitize_all_html: false" to galaxy.yml

# Galaxy prequisites:
# - sudo ln -s /path/to/folder/Fastqc/fastqc
#              /usr/local/bin/fastqc

# The runFastQC function.
# This function calls the FastQC tool and outputs to the temporary storage
# directory. It will search for the html output file and send this to the
# expected location. The temporary storage directory is deleted.
runFastQC() {
    fastqc -q ${flInput} -o ${strDirectory}_temp
    strHtmlName=$(find ${strDirectory}_temp -name "*.html" -printf "%f\n")
    cat ${strDirectory}_temp/${strHtmlName} > ${fosOutput}
    rm -rf ${strDirectory}_temp
}

# The getZipSummary function.
# This function loops through all fastq files extracted from the input file.
# It takes all lines from every file and copies these into flZipSummary.fastq. 
# After the summary file has been created, the correct input variable is named
# and the runFastQC function is called.
getZipSummary() {
    for strFile in ${strDirectory}_temp/*.fastq;
    do
        cat ${strFile} >> ${strDirectory}_temp/flZipSummary.fastq
    done
    flInput=${strDirectory}_temp/flZipSummary.fastq
    runFastQC
}

# The getZipFile function.
# This function copies the input file to the temporary storage directory. The
# input file is searched for, based on its .dat extension. This search will
# output the name of the input file which is used to unzip it into the
# temporary storage directory. After unzipping, the getZipSummary function is
# called.
getZipFile() {
    cp ${fisInput} ${strDirectory}_temp
    strZipName=$(find ${strDirectory}_temp -name "*.dat" -printf "%f\n")
    unzip -q ${strDirectory}_temp/${strZipName} -d ${strDirectory}_temp
    getZipSummary
}

# The getFormatFlow function.
# This function creates a temporary storage directory in the output directory.
# It then initiates the correct function chain depending on the file format.
# When processing a single fastQ file, the correct input variable is named
# and the runFastQC function is called. When processing a zip file, the
# getZipFile function is called.
getFormatFlow() {
    strDirectory=${fosOutput::-4}
    mkdir -p "${strDirectory}_temp"
    if [ "${disFormat}" = "fastq" ]
    then
        flInput=${fisInput}
        runFastQC
    elif [ "${disFormat}" = "zip" ]
    then
        getZipFile
    fi
}

# The main function.
main() {
    getFormatFlow
}

# The getopts function.
while getopts ":i:o:f:vh" opt; do
    case ${opt} in
        i)
            fisInput=${OPTARG}
            ;;
        o)
            fosOutput=${OPTARG}
            ;;
        f)
            disFormat=${OPTARG}
            ;;
        v)
            echo ""
            echo "runFastQC.sh [0.1.0]"
            echo ""

            exit
            ;;
        h)
            echo ""
            echo "Usage: runFastQC.sh [-h] [-v] [-i INPUT] [-o OUTPUT]"
            echo "                    [-f FORMAT]"
            echo ""
            echo "Optional arguments:"
            echo " -h                    Show this help page and exit"
            echo " -v                    Show the software's version number"
            echo "                       and exit"
            echo " -i                    The location of the input file(s)"
            echo " -o                    The location of the output file(s)"
            echo " -f                    The format of the input"
            echo "                       file(s) [fastq/zip]"
            echo ""
            echo "The FastQC tool will do quality control checks on raw"
            echo "sequence data. These checks include summary graphs and"
            echo "tables."
            echo ""
            echo "Files in fastQ format should always have a .fastq extension."
            echo ""
            echo "Current FastQC version:"
            fastqc -v
            echo ""
            echo "Source(s):"
            echo " - Andrews S, FastQC: A quality control tool for high"
            echo "   throughput sequence data."
            echo "   Babraham Bioinformatics. 2010."
            echo "   https://www.bioinformatics.babraham.ac.uk/projects/fastqc/"
            echo ""

            exit
            ;;
        \?)
            echo ""
            echo "You've entered an invalid option: -${OPTARG}."
            echo "Please use the -h option for correct formatting information."
            echo ""

            exit
            ;;
        :)
            echo ""
            echo "You've entered an invalid option: -${OPTARG}."
            echo "Please use the -h option for correct formatting information."
            echo ""

            exit
            ;;
    esac
done

main

# Additional information:
# =======================
#
# Files in fastQ format should always have a .fastq extension.
