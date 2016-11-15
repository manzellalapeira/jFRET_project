function sort_files(analysis)
% sort_files(analysis_mode)
% Sorts FRET data files into folders/subfolders depending on the analysis
% technique
% Input: analysis_mode  - leave empty to run by itself (without running the
%                           jFRET program
%                       - PFRET: goes through the UVA FRET analysis path
%                       - ZEN: simulates anlaysis from the Zen software
%
% Written by Javier Manzella_Lapeira on 10/2016 for the LIG Imaging Core at
% NAIAID/NIH

global fret_data_folder method mode
% fret_data_folder: 
% sub_dir_type: specifies whether you have seFRET or apFRET files
% mode: analysis mode based on input

% IF THE PROGRAM IS RUN BY ITSELF, INCLUDE THE FOLLOWING SECTION
if nargin == 0
    % ask the user to select the folder where the data files are
    folder_name = uigetdir;
    % declare global variables
    fret_data_folder = folder_name;
    method = 'se';
    mode = 'PFRET';
else
    % override the mode var with the input mode
    mode = analysis;
end

disp(mode)
disp(method)

% BEGIN sort_files()
switch mode
    case('PFRET')
        % create folders in the main fret_data_folder specified by user
        if strcmp(method,'se') == 1
            % Sensitized emission case
            sub_dir = {'A_Aex_Aem','A_Dex_Aem','A_Dex_Dem',...
                'D_Aex_Aem','D_Dex_Aem','D_Dex_Dem',...
                'DA_Aex_Aem','DA_Dex_Aem','DA_Dex_Dem'};
        elseif strcmp(method,'ap') == 1
            % Acceptor photobleaching case
            sub_dir = {'DA_Dex_Dem_A','DA_Dex_Aem_P','DA_Aex_Aem_A',...
                'DA_Aex_Aem_P','D_Dex_Aem_A','D_Dex_Dem_P'};
        end
        n = numel(sub_dir);
        wildcard_sub_dir = cell(1,n);
        for d = 1:n
            df = sub_dir{d};
            mkdir(fret_data_folder,df);
            if numel(df) == 9 || numel(df) == 11
                no_number = [df(1),'*',df(2:end),'.tif']; % put * and .tif to sort files
            elseif numel(df) == 10 || numel(df) == 12
                no_number = [df(1:2),'*',df(3:end),'tif'];
            end
            wildcard_sub_dir{d} = no_number;
            clear df
            clear no_number
        end
        % sort files and put them in their respective folders
        % count number of files in the main directory
        fDir = dir([fret_data_folder,'/','*.tif']);
        num_frets = length(fDir);
        for m = 1:num_frets
            file = fDir(m).name;
            file_no_digs = file(regexp(file,'\D'));
            file_dir = file_no_digs(1:end-4);
            movefile([fret_data_folder,'/',file],[fret_data_folder,'/',file_dir])
        end

    case('ZEN') % update the for loop with real number of czi files in the folder
        for files = 1:num_files
            data = bfopen([path,name]);
            %seriesCount = size(data, 1);
            
            series = data{1,1};
            series_planeCount = size(series,1);

            omeMeta = data{1,4};
            stackSizeY = omeMeta.getPixelsSizeX(0).getValue(); % image width, pixels
            stackSizeX = omeMeta.getPixelsSizeY(0).getValue(); % image height, pixels
            stackSizeZ = omeMeta.getPixelsSizeZ(0).getValue(); % number of Z slices
            
            % number of channels = seriesCount divided by stackSizeZ
            channels = series_planeCount/stackSizeZ;
            nChannels = omeMeta.getPixelsSizeC(0).getValue();
            if isequal(channels,nChannels) == 0
                error('')
            end
            I_raw = series{:,1};
            I_raw = cell2mat(I_raw);
            
            % save matrix in a cell array with all the images from the
            % folder
        end
end

% Message to communicate user of successful data re-arrangement
string1 = 'Files have been sorted. Click ''OK'' to continue.';
uiwait(msgbox(string1));

% Send work flow to the next function file
jFRET_work_01;

end