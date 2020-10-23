% last edit Etienne Thoret (23 oct 2020)
%
% MPS Analysis
% 

clc
close all;
clear all;

% audio parameters
windowSize = 2048 ;
frameStep = 512 ;
fs = 44100 ;

% scale / rate analysis parameters
maxRate = fs / frameStep / 2 ; % max rate values
maxScale = windowSize / (fs * 1e-3) / 2 ; % max scale value

% initialize sound path
soundPath = sprintf('./');

ext = 'wav' ;
addpath(soundPath) ;
soundsList = dir(strcat(soundPath,'*.wav')) ;
nbSounds = length(soundsList) ;

iterationCount = 100 ; % number of iterations in the Griffin & Lim algorithm

dontEstimateTimeDelay = 0 ;
dontRandomizePhase = 0 ;


%% MPS
label = struct([]) ;
MPS_tab = [] ;

%%% =======> File name here <==========
filename = 'sleeeeeep.wav' ;
%%% ===================================

filename1 = [soundPath filename] ;
C1 = strsplit(filename1,'_') ;
C = strsplit(C1{end},'.wav') ;
wavtemp = audioread(filename1) ;
% wavtemp = wavtemp(10000:10000+fs/2);


NFFT_temporal = 2048 ;
NFFT_spectral = 2*windowSize ;
[stft_1, MPS__, scaleRateAngle_1, N_1, N2_1, M_1, M2_1] = MPS(filename1, fs, windowSize, frameStep, NFFT_temporal, NFFT_spectral) ;

MPS_plot = (flipud([(MPS__(end/2+1:end,1:end/2)) ; (MPS__(1:end/2,1:end/2)) ]')) ;
MPS_tab = [MPS_tab; MPS_plot(:)];

ax(1)=imagesc(mag2db((abs(MPS_plot)))) ;

nbTicks = 6 ;
set(gca, 'XTick', linspace(1,length(MPS_plot(1,:)),nbTicks+1),'XtickLabel', round(linspace(-maxRate,maxRate,nbTicks+1))) 
set(gca, 'YTick', linspace(1,length(MPS_plot(:,1)),nbTicks+1),'YtickLabel', round(fliplr(linspace(0,maxScale,nbTicks+1)))) 
title(filename1)
xlabel('Rates (Hz)')
ylabel('Scales (cyc/Hz)')
colorbar


    
    




