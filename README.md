# galaxy-tool-fastqc-sequence-analysis

__!!Repo can be deleted, copy is also kept [here](https://github.com/JasperBoom/galaxy-tools-naturalis-internship)!!.__

Use FastQC to do quality control checks on raw sequence data.  
The FastQC tool will do quality control checks on raw sequence data. These checks include summary graphs and tables.

Files in fastQ format should always have a .fastq extension.

## Getting started

### Prerequisites
Download and install the following software according to the following steps.
* [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc)

The FastQC folder should be moved to the following file and renamed to "Fastqc".
```
sudo mkdir -m 755 /home/Tools
/home/Tools <-- Move FastQC to this directory
sudo chmod -R 755 /home/Tools/Fastqc
```
The following file in the FastQC folder should be made avaible from any location.
```
sudo ln -s /home/Tools/Fastqc/fastqc /usr/local/bin/fastqc
```
Make sure java is installed on your system.
```
sudo apt-get install default-jre
```

### Installing
Download and install the tool according to the following steps.
```
cd /home/Tools
sudo git clone https://github.com/JasperBoom/galaxy-tool-fastqc-sequence-analysis
sudo chmod -R 755 galaxy-tool-fastqc-sequence-analysis
```
```
sudo mkdir -m 755 /home/galaxy/tools/directoryname
sudo cp /home/Tools/galaxy-tool-fastqc-sequence-analysis/runFastQC.sh /home/galaxy/tools/directoryname/runFastQC.sh
sudo cp /home/Tools/galaxy-tool-fastqc-sequence-analysis/runFastQC.xml /home/galaxy/tools/directoryname/runFastQC.xml
```
Edit the following file in order to make galaxy display the tool.
```
/home/galaxy/config/tool_conf.xml
```
```
<tool file="directoryname/runFastQC.xml"/>
```
Edit the following file in order to prevent galaxy from blocking html output.
```
/home/galaxy/config/galaxy.yml
```
```
sanitize_all_html: false
```

## Source(s)
* __Andrews S__,  
  FastQC: A quality control tool for high throughput sequence data.  
  Babraham Bioinformatics. 2010.  
  [FastQC](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/)
* __Giardine B, Riemer C, Hardison RC, Burhans R, Elnitski L, Shah P__,  
  Galaxy: A platform for interactive large-scale genome analysis.  
  Genome Research. 2005; 15(10) 1451-1455. __doi: 10.1101/gr.4086505__  
  [Galaxy](https://www.galaxyproject.org/)

```
Copyright (C) 2018 Jasper Boom

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License version 3 as
published by the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <https://www.gnu.org/licenses/>.
```
