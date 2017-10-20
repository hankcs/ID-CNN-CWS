#!/bin/bash

additional_args=${@:4}
load_dir=$3
model_dir=$load_dir

cmd="scripts/train.sh \
$1 \
$2 \
--evaluate_only \
--train_eval False \
--print_preds True \
--model_dir $model_dir \
--load_dir $load_dir \
--dev_dir dataset/$1/test \
$additional_args"

eval ${cmd}
