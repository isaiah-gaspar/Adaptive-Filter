Samplefunction [s1,s2,fs1,fs2,bits1,bits2] = ex14( infile1, infile2, N )

% [s1,s2,fs1,fs2,bits1,bits2]=ex14(infile1,infile2)
%
% infile1, infile2 - .WAV input files
% N � frame size (in samples)
%
% s1,s2 � signals loaded from infile1 and infile2
% fs1,fs2 � sample rates of s1 and s2
% bits1, bits2 � bits per sample in each file
%
% Function loads infile1 and infile2, then displays
% records frame-by-frame. 

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

for k = 1:K
    
    % Compute indices for current frame
    n = (1:N)+(N*(k-1));
    
    % Signal 1
    subplot(211);
    plot(n,s1(n),'b',n,e(n),'r:');
    msg=sprintf('%s Frame %d',infile1,k);
    
    title(msg);
    ylabel('Normalized Amplitude');
    xlabel('Sample index');
    
    % Signal 2
    subplot(212);
    
    plot(n,s2(n),'b',n,e(n),'r:');
    msg=sprintf('%s Frame %d',infile2,k);
    
    title(msg);
    ylabel('Normalized Amplitude');
    xlabel('Sample index');
    
    % Pause between frames, waiting for keypress
    pause
    
end
