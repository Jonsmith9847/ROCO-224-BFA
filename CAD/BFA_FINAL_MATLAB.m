%*********************************************
%ROCO224 - BFA Forward kinematics DH test
%*********************************************
clear all
close all
clc
format short
%*********************************************
rosshutdown;
rosinit('192.168.0.100');
pubJ1 = rospublisher('/j1_controller/command','std_msgs/Float64');
pubJ2 = rospublisher('/j2_controller/command','std_msgs/Float64');
pubJ3 = rospublisher('/j3_controller/command','std_msgs/Float64');
pubJ4 = rospublisher('/j4_controller/command','std_msgs/Float64');

msgJ1 = rosmessage('std_msgs/Float64');
msgJ2 = rosmessage('std_msgs/Float64');
msgJ3 = rosmessage('std_msgs/Float64');
msgJ4 = rosmessage('std_msgs/Float64');

%Define DH params
 
%Link 1 - turret
a_1 = 0;
alpha_1 = pi/2;
d_1 = 0;
theta_1 = 0;
dh_1 = [theta_1 d_1 a_1 alpha_1 0 0];
%Link 2 - segment_1
a_2 = 0.2;
alpha_2 = 0;
d_2 = 0;
theta_2 = 0;
dh_2 = [theta_2 d_2 a_2 alpha_2 0 0];
%Link 3 - segment_2
a_3 = 0.0902;
alpha_3 = 0;
d_3 = 0;
theta_3 = 0;
dh_3 = [theta_3 d_3 a_3 alpha_3 0 0];
%Link 4 - segment_3
a_4 = 0.14375;
alpha_4 = 0;
d_4 = 0;
theta_4 = 0;
dh_4 = [theta_4 d_4 a_4 alpha_4 0 0];
 
%Create Link objects
L(1) = Link(dh_1);
L(2) = Link(dh_2);
L(3) = Link(dh_3);
L(4) = Link(dh_4);
 

BFA = SerialLink(L, 'name', 'BFA')
%Plot Robot animation
ws = [-1 1 -1 1 -0.14475 1];
 
figure;
BFA.plot([0,0,0,0],  'workspace', ws);
%Set joint limits
BFA.qlim = [[0 2*pi]; [0 pi]; [0 pi]; [0 pi]];
disp('Running Teach Pendant...')
BFA.teach
    pubJ5 = rospublisher('/j5_controller/command','std_msgs/Float64');
    pubJ6 = rospublisher('/j6_controller/command','std_msgs/Float64');

    msgJ5 = rosmessage('std_msgs/Float64');
    msgJ6 = rosmessage('std_msgs/Float64');

    msgJ5.Data = 0;
    msgJ6.Data = 0;
    
    f = figure('Visible','Off');
    sldJ5 = uicontrol('Style','slider','Min',0,'Max',5,'Value',2.5,'Position',[20 320 500 50],'String','J5');
    sldJ6 = uicontrol('Style','slider','Min',0,'Max',5,'Value',2.5,'Position',[20 240 500 50],'String','J6');
    f.Visible = 'On';
    
while true
    q = BFA.getpos();
    
    msgJ1.Data = q(1);
    msgJ2.Data = q(2);
    msgJ3.Data = q(3) + pi;
    msgJ4.Data = q(4);
    msgJ5.Data = sldJ5.Value;
    msgJ6.Data = sldJ6.Value;
    
    send(pubJ1,msgJ1);
    send(pubJ2,msgJ2);
    send(pubJ3,msgJ3);
    send(pubJ4,msgJ4);
    send(pubJ5,msgJ5);
    send(pubJ6,msgJ6);
    pause(1.3);
end

