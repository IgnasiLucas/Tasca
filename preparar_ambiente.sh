#!/bin/bash

BLAST_VERSION=0
if $(which blastp > /dev/null); then
   BLAST_VERSION=$(blastp -version | head -n 1 | cut -d " " -f 2)
fi

if [ $BLAST_VERSION != "2.10.1+" ]; then
   conda install -c bioconda -y -q blast=2.10.1
fi

if [ ! -e taxdb.btd ]; then
   if [ -e taxdb.btd.gz ]; then
      gunzip taxdb.btd.gz
   else
      echo "Falta l'arxiu taxdb.btd.gz!"
   fi
fi
