#!/bin/bash

for file in *-property.yml; do
    functional=${file%-property.yml}

    cooley --general=general.yml \
           --reduced-mass=b3lyp-force.yml \
           --force-field=b3lyp-force.yml \
           --exp-values=$functional-property.yml > $functional-numerov-output.yml

    python /home/bast/pnc/numerov/pnc-example/pnc.py $functional-numerov-output.yml > $functional-pnc-output.yml

    python /home/bast/pnc/numerov/pnc-example/plot.py --force-field=b3lyp-force.yml \
                                                      --exp-values=$functional-property.yml \
                                                      --numerov-output=$functional-numerov-output.yml \
                                                      --img=$functional-plot.png
done

exit 0
