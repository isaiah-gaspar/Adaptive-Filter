%% 
function [s1,s2,fs1,fs2,bits1,bits2] = ex15( infile1, infile2, N )

% [s1,s2,fs1,fs2,bits1,bits2]=ex15(infile1,infile2)
%
% infile1, infile2 - .WAV input files
% N – frame size (in samples)
%
% s1,s2 – signals loaded from infile1 and infile2
% fs1,fs2 – sample rates of s1 and s2
% bits1, bits2 – bits per sample in each file
%
% Function loads infile1 and infile2, then displays
% records frame-by-frame. Computes average energy
% per sample in each file.

[s1,fs1]=audioread(infile1);
info1 = audioinfo(infile1);
bits1 = info1.BitsPerSample;

[s2,fs2]=audioread(infile2);
info2 = audioinfo(infile2);
bits2 = info2.BitsPerSample;

l1=length(s1);
l2=length(s2);
M=min(l1,l2);
K=fix(M/N);

e = s1 - s2;

E1 = zeros([10000 1]);
E2 = zeros([10000 1]);

% % 
% 
% SNR Plot
% 
%  subplot(211);
%  plot(l1,s1,'r:',l2,s2,'b');
%  msg=sprintf('%s Vs %s. ',infile1,infile2);
% 
% title(msg);
% ylabel('Normalized Amplitude');
% xlabel('Sample index');
% 
% 
% % 
% Frames with Energy Calculation 


for k = 1:K
    
    % Compute indices for current frame
     n = (1:N)+(N*(k-1));
    
    % Signal 1
    
     E1(k)=  (s1(n)'*s1(n));
     
     Energy1=sum(E1)/N;
  
     subplot(211);
     plot(n,s1(n),'b',n,e(n),'r:');
     msg=sprintf('%s Frame %d. Energy %d.',infile1,k, Energy1);
    
     title(msg);
     ylabel('Normalized Amplitude');
     xlabel('Sample index');
     
   
    % Signal 2
    
     E2(k)=  (s2(n)'*s2(n));
     
     Energy2=sum(E2)/N;
     
     subplot(212);

     plot(n,s2(n),'b',n,e(n),'r:');
     msg=sprintf('%s Frame %d. Energy %d.',infile2,k, Energy2);

     title(msg);
     ylabel('Normalized Amplitude');
     xlabel('Sample index');
     
     
     % Pause between frames, waiting for keypress

     pause
     

    
end

% %% 
% 
% %Difference of Signal
% 
% garbled1 = s1 - s2;
% 
% audiowrite('garbled1.wav', garbled1, fs1)
% 
% %Summation of Signals
% 
% garbled2 = s1 + s2;
% 
% audiowrite('garbled2.wav', garbled2, fs2)
% 
% ex13('garbled1.wav',1);
% 
% ex13('garbled2.wav',1);
