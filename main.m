path('lib', path); % add lib folder to path
path('test', path); % add test folder to path

% calls evaulating function that will pass recognize image that will be
% used for all images in folder passed as second argument
% first argument is handler for function
evaulate(@recognize, 'images');