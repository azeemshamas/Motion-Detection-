
function varargout = Motion(varargin)
% MOTION M-file for Motion.fig
%      MOTION, by itself, creates a new MOTION or raises the existing
%      singleton*.
%
%      H = MOTION returns the handle to a new MOTION or the handle to
%      the existing singleton*.
%
%      MOTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOTION.M with the given input arguments.
%
%      MOTION('Property','Value',...) creates a new MOTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Motion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Motion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Motion

% Last Modified by GUIDE v2.5 10-Apr-2017 15:03:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Motion_OpeningFcn, ...
                   'gui_OutputFcn',  @Motion_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Motion is made visible.
function Motion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Motion (see VARARGIN)

% Choose default command line output for Motion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Motion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Motion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
obj=videoinput('winvideo',1);
obj.returnedcolorspace='rgb';
A=getsnapshot(obj);
axes(handles.axes1);
imshow(A);
imwrite(A,'A.jpg');
axes(handles.axes3);
X=rgb2gray(A);
imhist(X);
delete(obj);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global go;
go=true;
while go
   
obj=videoinput('winvideo',1);
obj.ReturnedColorspace='rgb';
B=getsnapshot(obj);
axes(handles.axes2);
imshow(B);
imwrite(B,'B.jpg');
axes(handles.axes4);
Y=rgb2gray(B);
imhist(Y);
delete(obj);

global I1;
global I2;

I1=imread('A.jpg');
I2=imread('B.jpg');

Imaged1 = im2double(I1);
Imaged2 = im2double(I2);

Imageg1 = rgb2gray(Imaged1);
Imageg2 = rgb2gray(Imaged2);

hn1 = imhist(Imageg1)./numel(Imageg1);
hn2 = imhist(Imageg2)./numel(Imageg2);

f1 = sum((hn1-hn2).^2);

%serialOne=serial('COM2','BaudRate', 9600);
%fopen(serialOne);

if f1>0.00009
    %fprintf(serialOne,'a');
    set(handles.text1,'string','CHANGE DETECTED');
    beep on;
    beep;
    go=false;
end
 
if f1<0.00009
    %fprintf(serialOne','b');
    set(handles.text1,'string','NO CHANGE');
    
end
%fclose(serialOne);
end


% --- Executes on button press in pushbutton3.
%function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on pushbutton1 and none of its controls.
function pushbutton1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


