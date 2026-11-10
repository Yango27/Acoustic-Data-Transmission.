function signalSymbol = symbolCreatorFSK(fs, R, f)
% SYMBOLCREATORFSK Single FSK symbol (one tone lasting one bit).
%   signalSymbol = SYMBOLCREATORFSK(fs, R, f) returns a cosine of
%   frequency f that lasts one bit period (1/R seconds), sampled at fs.
%   The symbol starts at phase zero:
%
%       signalSymbol(n) = cos(2*pi*f*(n-1)/fs),   n = 1 ... fs/R
%
%   Inputs:
%     fs - Sample rate, in Hz
%     R  - Bit rate, in bit/s
%     f  - Tone frequency, in Hz
%
%   Output:
%     signalSymbol - Row vector with fs/R samples, amplitude 1
%
    signalSymbol = zeros(1, fs/R);
    for n = 1:fs/R
        signalSymbol(n) = cos(2*pi*(n-1)*f/fs); %creates the symbol in discrete time
    end
end