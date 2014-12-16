Fingerspelling Recognition
==============================

[Fingerspelling](http://en.wikipedia.org/wiki/Fingerspelling) recognition project for computer vision 1 @matfyz.

### Usage

To run segmentation on full image database in folder `images` run `main.m`.

To recognize letter in single image change the path to `your_filesystem/cv1-fingerspelling-recognition/lib`. Run command `recognize(imread('images/image_name.jpg'))` or if you want to use your own picture change it to `recognize(imread('path/to/your_image.jpg'));`.

If you want to try webcam detection you __need__ to have __Matlab 2014a or newer__. Use `cam_detection.m`.

### Letters

![A,B,I,L,V,W,Y](https://raw.githubusercontent.com/darjanin/cv1-fingerspelling-recognition/master/resources/chosen_letters.png)

### Milestones

1. Study theory and create database of images (until __7th December 2014__)


### Wiki

Pridal som wiki, v ktorej su poznamky k projektu z cviceni. Ten google doc nejde editovat.
[Navrhy na riesenia](https://github.com/darjanin/cv1-fingerspelling-recognition/wiki/Navrhy-na-riesenia)
