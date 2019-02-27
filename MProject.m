%% 
%Isaiah Gaspar
%EEE 407
%November 19, 2018

%% Frequency-Domain Adaptive Noise Cancellation

%Play the invicual wav files using 'play.m' and save their respective
%lengths to my workspace

%% Mic1

[s_mic1,fs_mic1,bits_mic1] = play('mic1.wav',1);

size_mic1 = size(s_mic1);

%% Mic2

[s_mic2,fs_mic2,bits_mic2] = play('mic2.wav',1);

size_mic2 = size(s_mic2);

%% Mic1 with Music

[s_mic1_m,fs_mic1_m,bits_mic1_m] = play('mic1_music.wav',1);

size_mic1_m = size(s_mic1_m);

%% Mic2 with Music

[s_mic2_m,fs_mic2_m,bits_mic2_m] = play('mic2_music.wav',1);

size_mic2_m = size(s_mic2_m);

%% CleanSpeech(4) [Used with above for verification]

[s_cs4,fs_cs4,bits_cs4] = play('cleanspeech(4).wav',1);

size_cs4 = size(s_cs4);

%% CleanSpeech

[s_cs,fs_cs,bits_cs] = play('cleanspeech.wav',1);

size_cs = size(s_cs);

%% noisySpeech

[s_ns,fs_ns,bits_ns] = play('noisyspeech.wav',1);

size_ns = size(s_ns);

%% Framed Mic1 and Mic2

N = 256;

[s1,s2,fs1,fs2,bits1,bits2] = ex15( 'mic1.wav', 'mic2.wav', N )

%% Framed Mic1 and Mic2 with Music

N = 256;

[s1_m,s2_m,fs1_m,fs2_m,bits1_m,bits2_m] = ex15( 'mic1_music.wav', 'mic2_music.wav', N )


%% Speech with Noise 

mu = [0.001 ; 0.004 ; 0.00025];

fs1 = 8000;
%Update N between tests, and rerun this section each time
N = 256;

[f_Signal, SNR_improvement] = AdaptiveFilter( 'mic1.wav', 'mic2.wav', 'cleanspeech(4).wav', N, mu, fs1)

%% Play mu1

[s_mu1,fs_mu1,bits_mu1] = play('mu1.wav',1);

%% Play mu2

[s_mu2,fs_mu2,bits_mu2] = play('mu2.wav',1);

%% Play mu3

[s_mu3,fs_mu3,bits_mu3] = play('mu3.wav',1);

%% Results of Speech with Noise
%N = 4

% SNR_improvement =
% 
%    7.9780 + 0.0000i   7.4575 +13.6438i   1.8599 + 0.0000i
%    7.9780 + 0.0000i   7.4575 +13.6438i   1.8599 + 0.0000i
%    7.9780 + 0.0000i   7.4575 +13.6438i   1.8599 + 0.0000i

%N = 16

% SNR_improvement =
% 
%   10.8747 + 0.0000i  10.3403 +13.6438i   4.7971 + 0.0000i
%   10.8747 + 0.0000i  10.3403 +13.6438i   4.7971 + 0.0000i
%   10.8747 + 0.0000i  10.3403 +13.6438i   4.7971 + 0.0000i

%N = 64

% SNR_improvement =
% 
%   14.5900 + 0.0000i  13.9593 +13.6438i   8.3799 + 0.0000i
%   14.5900 + 0.0000i  13.9593 +13.6438i   8.3799 + 0.0000i
%   14.5900 + 0.0000i  13.9593 +13.6438i   8.3799 + 0.0000i

%N = 128

% SNR_improvement =
% 
%   15.9260 + 0.0000i  15.1925 +13.6438i   9.6022 + 0.0000i
%   15.9260 + 0.0000i  15.1925 +13.6438i   9.6022 + 0.0000i
%   15.9260 + 0.0000i  15.1925 +13.6438i   9.6022 + 0.0000i

%N = 256

% SNR_improvement =
% 
%   16.2640 + 0.0000i  15.2608 +13.6438i   9.6308 + 0.0000i
%   16.2640 + 0.0000i  15.2608 +13.6438i   9.6308 + 0.0000i
%   16.2640 + 0.0000i  15.2608 +13.6438i   9.6308 + 0.0000i




%%  Speech with Music

%% 

mu = [0.001 ; 0.0005 ; 0.00025];
fs1 = 8000;
%Update N between tests, and rerun this section each time
N = 256;

[f_Signal, SNR_improvement] = AdaptiveFilter( 'mic1_music.wav', 'mic2_music.wav', 'cleanspeech(4).wav', N, mu, fs1)

%% Play mu1

[s_mu1,fs_mu1,bits_mu1] = play('mu1.wav',1);

% 
%% Play mu2

[s_mu2,fs_mu2,bits_mu2] = play('mu2.wav',1);
%
%% Play mu3

[s_mu3,fs_mu3,bits_mu3] = play('mu3.wav',1);

%% Results of Speech with Noise

%N = 4

% SNR_improvement =
% 
%   16.0036 + 0.0000i  16.3147 +13.6438i  11.2901 + 0.0000i
%   16.0036 + 0.0000i  16.3147 +13.6438i  11.2901 + 0.0000i
%   16.0036 + 0.0000i  16.3147 +13.6438i  11.2901 + 0.0000i

%N = 16

% SNR_improvement =
% 
%   16.8900 + 0.0000i  17.5743 +13.6438i  12.9670 + 0.0000i
%   16.8900 + 0.0000i  17.5743 +13.6438i  12.9670 + 0.0000i
%   16.8900 + 0.0000i  17.5743 +13.6438i  12.9670 + 0.0000i


%N = 64

% SNR_improvement =
% 
%   16.6276 + 0.0000i  17.0539 +13.6438i  12.1936 + 0.0000i
%   16.6276 + 0.0000i  17.0539 +13.6438i  12.1936 + 0.0000i
%   16.6276 + 0.0000i  17.0539 +13.6438i  12.1936 + 0.0000i


%N = 128

% SNR_improvement =
% 
%   16.3023 + 0.0000i  16.5344 +13.6438i  11.5197 + 0.0000i
%   16.3023 + 0.0000i  16.5344 +13.6438i  11.5197 + 0.0000i
%   16.3023 + 0.0000i  16.5344 +13.6438i  11.5197 + 0.0000i


%N = 256

% SNR_improvement =
% 
%   15.2665 + 0.0000i  15.0862 +13.6438i   9.8201 + 0.0000i
%   15.2665 + 0.0000i  15.0862 +13.6438i   9.8201 + 0.0000i
%   15.2665 + 0.0000i  15.0862 +13.6438i   9.8201 + 0.0000i


%%  Part 3

fs1 = 8000;
%Update N between tests, and rerun this section each time


 N = 64;
 mu = [0.001];
[f_Signal, SNR_improvement] = AdaptiveFilter( 'mic1.wav', 'mic2.wav', 'cleanspeech(4).wav', N, mu, fs1)

N = 128;
mu = [0.00025];
[f_Signal, SNR_improvement] = AdaptiveFilter( 'mic1.wav', 'mic2.wav', 'cleanspeech(4).wav', N, mu, fs1)

