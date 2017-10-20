#!/usr/bin/env bash

for filename in 'train' 'dev' 'test'; do

    update_maps="True"
#    if [[ "$filename" =~ "train" ]]; then
#        update_maps="True"
#    fi

    this_data_file=data/$1/bmes/$filename.txt
	this_output_dir=dataset/$1/$filename

	echo "Processing file: $this_data_file"

	mkdir -p $this_output_dir

    cmd="python3 tsv_to_tfrecords.py \
    --in_file $this_data_file \
    --out_dir $this_output_dir \
    --window_size 3 \
    --update_maps $update_maps \
    $vocab_param \
    $labels_param \
    $shape_param \
    $char_param \
    $doc_param \
    $predict_pad_param \
    $additional_args"
    echo ${cmd}
    eval ${cmd}

    if [[ "$filename" =~ "train" ]]; then
    	vocab_param="--vocab $this_output_dir/token.txt"
        labels_param="--labels $this_output_dir/label.txt"
        shape_param="--shapes $this_output_dir/shape.txt"
        char_param="--chars $this_output_dir/char.txt"

        # Share maps on all sets
        rm -rf dataset/$1/dev/
        rm -rf dataset/$1/test/
        mkdir -p dataset/$1/dev/
        mkdir -p dataset/$1/test/
        ln -s `pwd`/$this_output_dir/token.txt dataset/$1/dev/
        ln -s `pwd`/$this_output_dir/token.txt dataset/$1/test/

        ln -s `pwd`/$this_output_dir/label.txt dataset/$1/dev/
        ln -s `pwd`/$this_output_dir/label.txt dataset/$1/test/

        ln -s `pwd`/$this_output_dir/shape.txt dataset/$1/dev/
        ln -s `pwd`/$this_output_dir/shape.txt dataset/$1/test/

        ln -s `pwd`/$this_output_dir/char.txt dataset/$1/dev/
        ln -s `pwd`/$this_output_dir/char.txt dataset/$1/test/
    fi

	echo
done
