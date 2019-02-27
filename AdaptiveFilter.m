function [f_Signal,SNR_improvement] = AdaptiveFilter( infile1, infile2, infile3, N, mu, fs)

% infile1 = 'mic1.wav';
% infile2 = 'mic2.wav';
% infile3 = 'cleanspeech(4).wav';
% N = 256;
% mu = [0.01;0.001;0.0001]; %Step values, still have to determine generalized option


% [f_Signal, SNR_after] = AdaptiveFilter( infile1, infile2, infile3, N, mu)
%, SNR_after
% infile1, infile2 - .WAV input files
% N – frame size (in samples)
%
% f_Signal – filtered output
% SNR_after – Improved snr after adaptive filter
%
% Function loads infile1 and infile2, then makes use of a adaptive filter
% to improve snr.



mu_Diag = diag(mu);

[s1,~] = audioread(infile1); % Mic 1
[s2,~] = audioread(infile2); % Mic 2
[s3,~] = audioread(infile3); % Clean speech

s3(numel(s1)) = 0;

err = s3 - s1; % Error of clean speech to Mic 1

l1=length(s1); % Finds the length of imported vector from Mic 1
l2=length(s2); % Finds the length of imported vector from Mic 2
l3=length(s3); % Finds the length of imported vector from CS
M=min(l1,l2); % Find minumum length between Mic1 and Mic2 data

K=fix(M/N); % Determined the number of frames

f_Signal = zeros(min(l1,l2),length(mu)); %Initialize f_Signal to length and different mu values

err_freqDomain = zeros(1,K); % Initialize frequency domain calculated error
Norm_Err_Linear = zeros(1,K); % Initilize the normalized error
Norm_Err_db = zeros(1,K); % Initilize the normalized error

B_coeff = zeros(N, length(mu), K); % Initialize coefficiants


for k = 1:K
    
        n = (1:N)+(N*(k-1)); % Compute indices for current frame
    
    % Signal 1
    
         d = s1(n); %Signal from Mic1 wrt to current frame

         D = fft(d); % FFT of mic1

         D_Diag = diag(D); % Diagonal of fft(d)
         
         D_matrix = D; % Needed for linear algebra
         
         for i=1:(length(mu)-1)
    
              D_matrix = [D_matrix, D];
    
         end

     
     % Signal 2
    
         x = s2(n); %Signal from Mic2 wrt to current frame

         X = fft(x); % FFT of mic2

         X_Diag = diag(X); %Diagonal of mic2 FFT
     
     %Adaptive Algorithm
     
         err_freqDomain = D_matrix - X_Diag*B_coeff(:,:,k); %E(i)=D(i)-Xdiag(i)*B(i)

         Norm_Err_Linear = (1/N)*norm(err_freqDomain); %Normalize Error

         Norm_Err_db(k) = 10*log10(Norm_Err_Linear); % Convert Normalized error to db scale

         %Adapts the coefficents of the filter
         B_coeff(:,:,k+1) = B_coeff(:,:,k) + 2*ctranspose(X_Diag)*(err_freqDomain)*mu_Diag;

         f_Signal(n,:) = ifft(err_freqDomain); %Filtered data back in time-domain with ifft()
     
         
     %Clean Speech matrix
         
        S_matrix = s3;

        for i=1:(length(mu)-1)

            S_matrix = [S_matrix, s3];

        end
end


     
     %SNR Calculations

     
     sig_before = (s3'*s3)/N; %SNR before filtering with clean speech
     
     noi_before = (err'*err)/N;
     
     SNR_before = sig_before/noi_before;
     
     SNR_before_db = 10*log10(SNR_before);
     
     
      sig_after = (S_matrix'*S_matrix)/N;
     
      noi_after = ((S_matrix-f_Signal)'*(S_matrix-f_Signal))/N;
     
     SNR_after = sig_after/noi_after;
     
     SNR_after_db = 10*log10(SNR_after);
     
     SNR_improvement = SNR_after_db - SNR_before_db;
     
     
     hold on
     figure(1)
     
     plot(f_Signal(:,1),'b');
     plot(f_Signal(:,2),'r');
     plot(f_Signal(:,3),'g');
     
     hold off
     
     msg=sprintf('Filtered Signal w.r.t. mu 1,2, and 3 for N = %d', N);
    
     title(msg);
     ylabel('Amplitude');
     xlabel('Sample Index');
     
     hold on
     figure(2)
     
     plot(Norm_Err_db,'b');

     
     hold off
     
     msg=sprintf('Norm_Err_db for N = %d', N);
    
     title(msg);
     ylabel('Amplitude [db]');
     xlabel('Sample Index');
     
     audiowrite('mu1.wav', f_Signal(:,1), fs)
     audiowrite('mu2.wav', f_Signal(:,2), fs)
     audiowrite('mu3.wav', f_Signal(:,3), fs)
 
     
     
     %Only for N = 128
%      
%      hold on
%      figure(4)
%      x = 1:0.25:K/2;
%      y = x;
%      
%      [X,Y] = meshgrid(x);
%      
%      F = B_coeff(X:Y);
%      surf(X,Y,F)
%     
%      hold off
%      
%      msg=sprintf('|B(i,k)| vs i (iteration) and k', N);
%     
%      title(msg);
%      ylabel('Amplitude [db]');
%      xlabel('Sample Index');
