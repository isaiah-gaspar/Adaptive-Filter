function [s,fs,bits] = play(infile, playstate)

% % ex13(infile,playstate)
% %
% % infile - .WAV input file
% % playstate – Switch playback on/off
% %
% % s – signal loaded from infile
% % fs – sample rate
% % bits – bits per sample
% %
% % Function loads infile, displays entire
% % record, then optionally plays back the
% % sound depending upon state of playstate


[s,fs]=audioread(infile);
info = audioinfo(infile);
bits = info.BitsPerSample;

if playstate == 1
    sound(s,fs);
end



