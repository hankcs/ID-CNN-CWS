# ID-CNN-CWS
Source codes and corpora of paper "Iterated Dilated Convolutions for Chinese Word Segmentation".

![hankcs.com 2017-10-20 上午11.54.32](http://wx4.sinaimg.cn/large/006Fmjmcly1fkp76lzn3zj30r20nggs8.jpg)


It implements the following $4$ models for CWS:

- Bi-LSTM
- Bi-LSTM-CRF
- ID-CNN
- ID-CNN-CRF

## Dependencies

- Python >= 3.6
- TensorFlow >= 1.2

Both CPU and GPU are supported. GPU training is $10$ times faster.

## Preparation

Run following script to convert corpus to TensorFlow dataset.

```
$ ./scripts/make.sh
```

## Train and Test

### Quick Start

```
$ ./scripts/run.sh $dataset $model
```

- `$dataset` can be `pku`, `msr`, `asSC` or `cityuSC`. 
- `$model` can be `cnn` or `bilstm`.

For example:

```
$ ./scripts/run.sh pku cnn
```

It will train a `cnn` model on `pku` dataset, then evaluate performance on test set.

### CRF Layer

To enable CRF layer, simply append `--viterbi` to your command, e.g.

```
$ ./scripts/run.sh pku cnn --viterbi
```

## Accuracy

![hankcs.com 2017-10-20 上午11.42.00](http://wx1.sinaimg.cn/large/006Fmjmcly1fkp6ttbk3ij30py0x4gtk.jpg)

## Speed

![2017-10-20_11-44-42](http://wx3.sinaimg.cn/large/006Fmjmcly1fkp6wafcngj30d407l0th.jpg)

## Acknowledgments

- Corpora are from SIGHAN05, converted to Simplified Chinese via [HanLP](https://github.com/hankcs/HanLP). Note that the SIGHAN datasets should only be used for research purposes.
- Model implementations adopted from https://github.com/iesl/dilated-cnn-ner by [Emma Strubell](https://cs.umass.edu/~strubell).

