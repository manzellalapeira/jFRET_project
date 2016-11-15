function varargout = jFRET(varargin)
%JFRET M-file for jFRET.fig
%      JFRET, by itself, creates a new JFRET or raises the existing
%      singleton*.
%
%      H = JFRET returns the handle to a new JFRET or the handle to
%      the existing singleton*.
%
%      JFRET('Property','Value',...) creates a new JFRET using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to jFRET_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      JFRET('CALLBACK') and JFRET('CALLBACK',hObject,...) call the
%      local function named CALLBACK in JFRET.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jFRET

% Last Modified by GUIDE v2.5 28-Oct-2016 16:26:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jFRET_OpeningFcn, ...
                   'gui_OutputFcn',  @jFRET_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before jFRET is made visible.
function jFRET_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for jFRET
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jFRET wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jFRET_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fret_data_folder
folder_name = uigetdir;
if folder_name == 0
    folder_name = 'try again';
end
set(handles.edit1,'String',folder_name)
fret_data_folder = folder_name;



% --- Executes on button press in next_step.
function next_step_Callback(hObject, eventdata, handles)
% hObject    handle to next_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fret_data_folder mode
fret_data_folder = get(handles.edit1,'String');
check_dir = exist(fret_data_folder,'dir');
if check_dir == 0
    empty = imread('empty_chest.jpg'); 
    msgbox('Folder not found. Try again.','Warning','custom',empty)
    return
elseif check_dir == 7
    sort_files(mode);
end

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mode

analysis_type_selection = get(hObject,'Value'); % returns toggle state of radiobutton1
if analysis_type_selection == 1
    mode = 'ZEN';    
end

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mode

analysis_type_selection = get(hObject,'Value'); % returns toggle state of radiobutton1
if analysis_type_selection == 1
    mode = 'PFRET';    
end


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global method

analysis_type_selection = get(hObject,'Value'); % returns toggle state of radiobutton1
if analysis_type_selection == 1
    method = 'se';    
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global method

analysis_type_selection = get(hObject,'Value'); % returns toggle state of radiobutton1
if analysis_type_selection == 1
    method = 'ap';    
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton5
