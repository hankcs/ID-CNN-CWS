#!/usr/bin/env bash

dataset=$1
model=$2
additional_args=${@:3}

source scripts/train.sh $dataset $model $additional_args
scripts/test.sh $dataset $model $model_dir $additional_args