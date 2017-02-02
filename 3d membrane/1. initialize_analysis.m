%% 1. Initialize analysis.
% These two sections find, load, and initialize the membrane contour code.
% Set location of .dv movies and desired folder for analysis before running
% this section (see below).

% Refresh MATLAB.
close all;
clear all;
clc;

% ***Set location of .dv movies.***
rootpath='.'; % Folder containing folders of .dv files, e.g., '.' if
% current folder.
folder='2487'; % Designate which strain folder of .dv files to analyze by 
% listing some identifying string of the folder name, e.g., '2487' if the
% folder's full name is '2487_epe1'.

strain_all=dir(rootpath);
strain_names={strain_all(3:end).name}; % Because first two cells in 
% strain_all are '.' and '..' respectively.
strain_selected=strain_names(cellfun(@(x)~isempty(x),...
    strfind(strain_names,folder))); % Selected strain folder name
%%

for ii=1:length(strain_selected)
    strainpath=strain_selected{ii};
    
    % For analyzing a group of .dv files with a folder (Yao):
    movienames=dir(fullfile(rootpath,strainpath,'*.dv')); % Creates a
    % directory of all the .dv movie variables (name, date, size, etc.) 
    % from all .dv files from the designated strainpath folder.

   % For analyzing one movie at a time (Yao):
%     movienames=dir(fullfile(rootpath,strainpath,'2487_epe1_Cut11-GFP_05_R3D.dv'));

    for jj=1:length(movienames)
        nm=nucmem3(fullfile(rootpath,strainpath,movienames(jj).name));
        % load movie
        nm.endframe=241;
        nm.loadmovie(482*10);
        % select the threshold for analysis
        nm.get_centroid_firstframe;
        nm.remove_badcentroid(1);
        nm.remove_badcentroid(50);
        nm.remove_badcentroid(101);
        % initialze
        nm.initialize();
        %
        nm.pickorientation;
        %
        nm.save_contour(1);
    end
end

