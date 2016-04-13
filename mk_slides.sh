#!/bin/bash

 # TODO: REPLACE SPACEFOO

 SVG=slides.svg
 OUTDIR=_
 TMP=${SVG%%.*}.layers
 SPACEFOO=SP${RANDOM}CE


 sed ":a;N;\$!ba;s/\n/$BREAKFOO/g" $SVG | # REMOVE ALL LINEBREAKS (BUT SAVE)
 sed "s/ /$SPACEFOO/g"                  | # REMOVE ALL SPACE (BUT SAVE)
 sed 's/<g/\n<g/g'                      | # RESTORE GROUP OPEN + NEWLINE
 sed '/groupmode="layer"/s/<g/4Fgt7R/g' | # PLACEHOLDER FOR LAYERGROUP OPEN
 sed ":a;N;\$!ba;s/\n/$SPACEFOO/g"      | # REMOVE ALL LINEBREAKS
 sed 's/4Fgt7R/\n<g/g'                  | # RESTORE LAYERGROUP OPEN + NEWLINE
 sed 's/<\/svg>//g'                     | # REMOVE SVG CLOSE
 sed 's/display:none/display:inline/g'  | # MAKE VISIBLE EVEN WHEN HIDDEN
 sed "s/$SPACEFOO/ /g"                  | # RESTORE SPACES
 tee > $TMP                               # WRITE TO (TEMPORARY) FILE

 for LAYER in `cat $SVG                       | #
               sed 's/inkscape:label/\n&/g'   | #
               grep "^inkscape:label=\"[0-9]" | #
               cut -d "\"" -f 2               | #
               egrep -v "XX_|BGCOLOR"         | #
               sort -u`                         #
  do
     FILENAME=$LAYER
     head -n 1 $TMP                    >  ${FILENAME}.tmp.svg
     grep "ape:label=\"BGCOLOR\"" $TMP >> ${FILENAME}.tmp.svg
     grep "ape:label=\"$LAYER\"" $TMP  >> ${FILENAME}.tmp.svg
     echo "</svg>"                     >> ${FILENAME}.tmp.svg

  #  inkscape --export-png=$OUTDIR/${FILENAME}.png \
  #           ${FILENAME}.tmp.svg

     inkscape --export-png=$OUTDIR/x2/${FILENAME}.png \
              --export-area=-1024:0:1024:768 \
              ${FILENAME}.tmp.svg
 done

 rm *.tmp.svg $TMP

exit 0;



