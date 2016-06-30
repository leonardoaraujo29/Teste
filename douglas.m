function varargout = douglas(varargin)
% DOUGLAS MATLAB code for douglas.fig
%      DOUGLAS, by itself, creates a new DOUGLAS or raises the existing
%      singleton*.
%
%      H = DOUGLAS returns the handle to a new DOUGLAS or the handle to
%      the existing singleton*.
%
%      DOUGLAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOUGLAS.M with the given input arguments.
%
%      DOUGLAS('Property','Value',...) creates a new DOUGLAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before douglas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to douglas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help douglas

% Last Modified by GUIDE v2.5 29-Jun-2016 04:09:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @douglas_OpeningFcn, ...
                   'gui_OutputFcn',  @douglas_OutputFcn, ...
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


% --- Executes just before douglas is made visible.
function douglas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to douglas (see VARARGIN)

% Choose default command line output for douglas
handles.output = hObject;
handles.baud_rate.Value = 6; %BaudRate padrão é 115200
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes douglas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = douglas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in open_button.
function open_button_Callback(hObject, eventdata, handles)
% hObject    handle to open_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Abre a comunicação com a serial e libera os comandos
handles.s = serial(handles.port.String{handles.port.Value},'BaudRate',...
    str2double(handles.baud_rate.String{handles.baud_rate.Value}));
fopen(handles.s);
handles.send_edit_box.Enable = 'on';
handles.send_button.Enable = 'on';
handles.receive_button.Enable = 'on';
handles.receive_edit_box.String = 'Ready...';
handles.create_graph_button.Enable = 'on';
guidata(hObject,handles);

% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Encerra a comunicação com a serial e desabilita os botões
fclose(handles.s);
handles.send_edit_box.Enable = 'inactive';
handles.send_button.Enable = 'off';
handles.receive_edit_box.String = '';
guidata(hObject,handles);


function receive_edit_box_Callback(hObject, eventdata, handles)
% hObject    handle to receive_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of receive_edit_box as text
%        str2double(get(hObject,'String')) returns contents of receive_edit_box as a double


% --- Executes during object creation, after setting all properties.
function receive_edit_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to receive_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function send_edit_box_Callback(hObject, eventdata, handles)
% hObject    handle to send_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of send_edit_box as text
%        str2double(get(hObject,'String')) returns contents of send_edit_box as a double


% --- Executes during object creation, after setting all properties.
function send_edit_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to send_edit_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in send_button.
function send_button_Callback(hObject, eventdata, handles)
% hObject    handle to send_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Manda o que estiver escrito na caixa de texto TX direto para o sensor
fprintf(handles.s,handles.send_edit_box.String);
handles.send_edit_box.String = '';


guidata(hObject,handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

% Fecha a interface e encerra a comunicação com a serial
delete(hObject);
fclose(handles.s);


% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on send_edit_box and none of its controls.
function send_edit_box_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to send_edit_box (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in port.
function port_Callback(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns port contents as cell array
%        contents{get(hObject,'Value')} returns selected item from port


% --- Executes during object creation, after setting all properties.
function port_CreateFcn(hObject, eventdata, handles)
% hObject    handle to port (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Olha quais portas estão disponíveis para conexão e as coloca como opções
serialInfo = instrhwinfo('serial');
hObject.String = serialInfo.AvailableSerialPorts;

% --- Executes on selection change in baud_rate.
function baud_rate_Callback(hObject, eventdata, handles)
% hObject    handle to baud_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns baud_rate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from baud_rate


% --- Executes during object creation, after setting all properties.
function baud_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baud_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%Possíveis valores de BaudRate
hObject.String = {'9600' '14400' '19200' '38400' '57600' '115200' '128000' '153600' '230400' '256000' '460800' '921600'};


% --- Executes on button press in receive_button.
function receive_button_Callback(hObject, eventdata, handles)
% hObject    handle to receive_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Lê o próximo pacote de dados do sensor
string = read_serial(handles.s);
%Escreve a string recebida da leitura com o horário em que os dados foram
%recebidos na caixa de texto RX.
handles.receive_edit_box.String = vertcat(handles.receive_edit_box.String,cellstr(['<' datestr(datetime('now'),'hh:MM:ss') ...
    '> ' string]),{'Ready...'});


% --- Executes on button press in chart_button.
function chart_button_Callback(hObject, eventdata, handles)
% hObject    handle to chart_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gyrox_check_box.
function gyrox_check_box_Callback(hObject, eventdata, handles)
% hObject    handle to gyrox_check_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gyrox_check_box


% --- Executes on button press in gyroy_check_box.
function gyroy_check_box_Callback(hObject, eventdata, handles)
% hObject    handle to gyroy_check_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gyroy_check_box


% --- Executes on button press in gyroz_check_box.
function gyroz_check_box_Callback(hObject, eventdata, handles)
% hObject    handle to gyroz_check_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gyroz_check_box


% --- Executes on button press in create_graph_button.
function create_graph_button_Callback(hObject, eventdata, handles)
% hObject    handle to create_graph_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Cria o gráfico de acordo com a opção selecionada.
if(handles.gyro_x_button.Value == 1)
    plot_gyro(handles.s,'5c',1);
elseif(handles.gyro_y_button.Value == 1)
    plot_gyro(handles.s,'5c',2);
elseif(handles.gyro_z_button.Value == 1)
    plot_gyro(handles.s,'5d',1);
end