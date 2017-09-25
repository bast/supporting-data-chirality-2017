#!/bin/bash

postprocess () {
    h_functional=$1
    a_functional=$2
    p_functional=$3

    cooley --general=general.yml \
           --reduced-mass=$h_functional-force.yml \
           --force-field=$a_functional-force.yml \
           --exp-values=$p_functional-property.yml \
           > ${h_functional}-${a_functional}-${p_functional}-numerov-output.yml

    python /home/bast/pnc/numerov/pnc-example/pnc.py \
           ${h_functional}-${a_functional}-${p_functional}-numerov-output.yml \
           > ${h_functional}-${a_functional}-${p_functional}-pnc-output.yml
}

postprocess 'b3lyp' 'b3lyp' 'b3lyp'
postprocess 'b3lyp' 'b3lyp' 'hf'
postprocess 'b3lyp' 'hf'    'hf'
postprocess 'b3lyp' 'b3lyp' 'pbe'
postprocess 'b3lyp' 'pbe'   'pbe'

for functional in hf b3lyp pbe; do
    python /home/bast/pnc/numerov/pnc-example/plot.py --force-field=$functional-force.yml \
                                                      --exp-values=$functional-property.yml \
                                                      --numerov-output=b3lyp-${functional}-${functional}-numerov-output.yml \
                                                      --img=$functional-plot.png
done

exit 0
