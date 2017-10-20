#!/bin/bash

train_dir=dataset/$1/train
dev_dir=dataset/$1/dev
maps_dir=$train_dir

source scripts/common.sh
source scripts/$1-$2.sh

additional_args=${@:3}

cmd="python3 train.py \
--train_dir $train_dir \
--dev_dir  $dev_dir \
--maps_dir $maps_dir \
--model_dir $model_dir \
--embed_dim $embedding_dim \
--embeddings  $embeddings \
--lstm_dim $num_filters \
--input_dropout $input_dropout \
--hidden_dropout $hidden_dropout \
--middle_dropout $middle_dropout \
--word_dropout $word_dropout \
--lr $lr \
--l2 $l2 \
--batch_size $batch_size \
--nonlinearity $nonlinearity \
--char_dim $char_dim \
--char_tok_dim $char_tok_dim \
--shape_dim $shape_dim \
--layers \"$layers\" \
--model $model \
--clip_norm $clip_norm \
--regularize_drop_penalty $regularize_drop_penalty \
--projection $projection \
--margin $margin \
--loss $loss \
--epsilon $epsilon \
--beta2 $beta2 \
--char_model $char_model \
--block_repeats $block_repeats \
--share_repeats $share_repeats \
--max_epochs $max_epochs \
$doc_param \
$start_end_param \
$predict_pad_param \
$layers2_param \
$viterbi_param \
$load_pretrained_param \
$additional_args"

echo ${cmd}
eval ${cmd}
