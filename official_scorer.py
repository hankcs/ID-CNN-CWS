# -*- coding:utf-8 -*-
# Filename: official_scorer.py
# Author：hankcs
# Date: 2017-08-17 上午10:22

import os
import sys
import tempfile
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--gold-file", required=True, dest="gold_file", help="Test data .txt file")
parser.add_argument("--test-out", required=True, dest="test_out", help="Test output .txt file")
parser.add_argument("--joint", dest="joint", action="store_true", help="Score joint learning outputs")
options = parser.parse_args()

tmpdir = tempfile.TemporaryDirectory()
root = tmpdir.name
datasets = {}
if options.joint:
    print('Spliting joint test out file into seperate files w.r.t dataset name...')
    with open(options.test_out) as src:
        for line in src:
            sentence = line.split(' ')
            dataset_name = sentence[0][1:-1]
            dataset_path = '{}/{}.txt'.format(root, dataset_name)
            if dataset_name not in datasets:
                datasets[dataset_name] = ('data/{}/raw/test.txt'.format(dataset_name), dataset_path)
            with open(dataset_path, 'a') as des:
                des.write(' '.join(sentence[1:-1]))
                des.write('\n')
else:
    datasets[' '] = (options.gold_file, options.test_out)

for dataset_name, (gold_file, test_out) in datasets.items():
    print(dataset_name)
    dic_path = '{}/{}-dic.txt'.format(root, dataset_name)
    dic = set()
    with open(gold_file) as src:
        for line in src:
            sentence = line.split(' ')
            dic.update(sentence)
    with open(dic_path, 'w') as des:
        for word in dic:
            des.write(word)
            des.write('\n')

    cmd = './score {} {} {} > tmp'.format(dic_path, gold_file, test_out)
    os.system(cmd)
    cmd = 'grep \'F MEASURE\' tmp '
    os.system(cmd)
    cmd = 'rm tmp'
    os.system(cmd)
