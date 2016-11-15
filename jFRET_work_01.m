function data_pass_01 = jFRET_work_01()
%jFRET_work_01 is called by sort_files.m after the fret image files are
%sorted according to the FRET mode and method selected by the user.

global fret_data_folder mode method

% 1 - Remove background from fret pics
fret_pics = jf_backgr;

end