# Guardem els resultats com a llista d'identificadors (o números d'accés).
system2(command = 'blastp',
         args = c('-query', 'CHRM1.fas',
                  '-db', 'swissprot',
                  '-out', 'AccessionList.txt',
                  '-outfmt', '"6 saccver"',
                  '-evalue', '1.0e-50'),
         wait = TRUE)

# Llegim la llista de números d'accés com un 'data frame', amb una
# única columna.
AccessionTable <- read.table('AccessionList.txt', col.names = 'saccver')

# La funció paste() permet ajuntar tots els elements d'un vector en una
# cadena de caràcters amb els elements separats per una coma, si la volem:
paste(AccessionTable$saccver, collapse=',')

# Això es pot utilitzar directament en el codi, posant eixa cadena de
# caràcters en el lloc de l'argument després de l'opció "-entry":
system2(command = 'blastdbcmd',
        args = c('-db', 'swissprot',
                 '-entry', paste(AccessionTable$saccver, collapse = ','),
                 '-out', 'BlastHits_1.fas'))

# Altrament, podem utilitzar "-entry_batch" en lloc d'"-entry", i donar-li
# com a argument el nom de l'arxiu amb el llistat d'identificadors. Pots
# comprovar que el resultat és el mateix.
system2(command = 'blastdbcmd',
        args = c('-db', 'swissprot',
                 '-entry_batch', 'AccessionList.txt',
                 '-out', 'BlastHits_2.fas'))
