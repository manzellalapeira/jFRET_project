function fret_pics = jf_backgr()
%JF_BACKGR removes the background from FRET images based on user-defined
%areas
%   No inputs if the function is being called from the sort_files.m
%   function

global fret_data_folder mode method

if strcmp(mode,'PFRET') == 1 && strcmp(method,'se') == 1
    fret_pics_path = [fret_data_folder,'/DA_Dex_Aem'];
    fret_pics_dir = dir([fret_pics_path,'/','*.tif']);
    num_fret_pics = length(fret_pics_dir(not([fret_pics_dir.isdir])));
    fret_pics_cell = cell(num_fret_pics); % this cell matrix will hold background-subtracted fret pics
    for f = 1:num_fret_pics
        fret_pic = imread();
        
        
    end
elseif strcmp(mode,'PFRET') == 1 && strcmp(method,'ap') == 1
    
end

fret_pics = fret_pics_cell;
end

