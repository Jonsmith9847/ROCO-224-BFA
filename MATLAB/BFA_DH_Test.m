%*********************************************
%ROCO224 - BFA Forward kinematics DH test
%*********************************************
clear all
close all
clc
format short
%*********************************************
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
BFA.qlim = [[0 2*pi]; [-pi pi]; [0 2*pi]; [-pi pi]];
disp('Running Teach Pendant...')
BFA.teach

