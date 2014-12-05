function rate = evaulate(func, folder, is_result_printed)
    % returns percentage of success
    
    imgPath = strcat('./',folder,'/'); % path to folder with images
    imgType = '*.jpg'; % all pictures need to be JPG
    images = dir([imgPath imgType]); % load all images in specified folder

    expr = '_|\.'; % expression used to split picture name

    count_success = 0;
    count_total = length(images);

    result = struct();

    for i = 1:length(images)
        splitStr = regexp(images(i).name, expr, 'split');
        set = char(splitStr(1));
        letter = char(splitStr(2));

        letter_return = func(imread([imgPath,images(i).name]));

        if (letter == letter_return)
            success = 1;
            count_success = count_success + 1;
        else
            success = 0;
        end

        result.(set).(letter) = struct('return', letter_return, 'success', success);

    end
    
    if (is_result_printed == 1)
        print_result(result);
    end

    rate = count_success / count_total * 100;
    disp([char(13),'Total success rate: ', num2str(rate), '%']);

end

function print_result(result)
    sets = fieldnames(result);
    
    for idx = 1:length(sets)
        disp([char(13),upper(char(sets(idx)))]);
        
        print_set(result.(char(sets(idx))));
    end
end

function print_set(set)
    letters = fieldnames(set);
    
    for idx = 1:length(letters)
        letter_name = char(letters(idx));
        
        if set.(letter_name).success == 1
            success = 'PASSED';
        else
            success = '';
        end
        
        disp([upper(letter_name),', ',upper(set.(letter_name).return),', ',success]);
    end
end