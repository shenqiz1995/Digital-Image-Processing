function varargout = index(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @index_OpeningFcn, ...
                   'gui_OutputFcn',  @index_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function index_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
Lena=imread('Lena.bmp');
hAxe=axes('Parent',gcf,...
    'Units','pixels',...
     'Position',[55 50 256 256]);
axes(hAxe);
imshow(Lena)
guidata(hObject, handles);

function varargout = index_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function pushbutton1_Callback(hObject, eventdata, handles)
experiment1();

function pushbutton2_Callback(hObject, eventdata, handles)
experiment2();

function pushbutton3_Callback(hObject, eventdata, handles)
experiment3();

function pushbutton4_Callback(hObject, eventdata, handles)
experiment4();

function pushbutton5_Callback(hObject, eventdata, handles)
experiment5();

function pushbutton6_Callback(hObject, eventdata, handles)
close(index);

function edit1_Callback(hObject, eventdata, handles)


function edit1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
