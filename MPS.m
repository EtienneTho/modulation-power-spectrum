function [stft, scaleRateAmp, scaleRateAngle, N, N2, M, M2] = MPS(filename, fs, windowSize, frameStep, NFFT_temporal, NFFT_spectral)

[wavtemp, fs_wav] = audioread(filename) ;

if fs_wav ~= fs
    wavtemp = resample(wavtemp, fs, fs_wav) ; % resample
end

% wavtemp = padarray(wavtemp, 1000) ; % zero-padding to remove intial and final artifacts

stftA = ComplexSpectrogram(wavtemp, windowSize, frameStep);

stft = (abs(stftA(1:end/2,:)))' ;

%% 
[N,M] = size(stft) ;
% spatial, temporal zeros padding 
N1 = 2^nextpow2(N);	N2 = NFFT_temporal ;
M1 = 2^nextpow2(M);	M2 = NFFT_spectral ;
N
M
N1
M1
N2
M2
% first fourier transform (w.r.t. frequency axis)

Y = zeros(N2, M2);

for n = 1:N
    
    R1 = fft(stft(n, :), M2);
    Y(n, :) = R1(1:M2);
    
end

% second fourier transform (w.r.t. temporal axis)
for m = 1:M2
    R1 = fft(Y(1:N, m), N2);
    Y(:, m) = R1;
end

scaleRateAmp = abs(Y) ;
scaleRateAngle = angle(Y) ;


end