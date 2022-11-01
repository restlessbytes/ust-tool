#!/usr/bin/env bash

echo "De-modularizing source code ..."
raco demod ust.rkt && 

echo "Building executable from *_merged.zo file ..."
raco exe -o ust ust_rkt_merged.zo
