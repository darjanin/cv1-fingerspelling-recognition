path('lib', path); % add lib folder to path
path('test', path); % add test folder to path

% if you want to clear command window uncomment following line
% clc;

% calls evaulating function that will pass recognize image that will be
% used for all images in folder passed as second argument
% first argument is handler for function
% third argument if is 1 than print stats, any other number do otherwise
close all;
evaulate(@recognize, 'images', 1);