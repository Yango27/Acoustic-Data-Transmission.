function symbol = detectSymbol(signal, fs, f0, f1)
% DETECTSYMBOL Non-coherent detection of a single FSK symbol.
%   symbol = DETECTSYMBOL(signal, fs, f0, f1) decides which of the two
%   tones is present in one symbol. It computes the FFT of the symbol and
%   compares the magnitude at the bins of f0 and f1:
%
%       |X(f0)| >  |X(f1)|  ->  symbol = 0
%       otherwise           ->  symbol = 1
%
%   Inputs:
%     signal - Samples of one symbol (vector of fs/R samples)
%     fs     - Sample rate, in Hz
%     f0     - Tone frequency for bit "0", in Hz
%     f1     - Tone frequency for bit "1", in Hz
%
%   Output:
%     symbol - Detected bit (0 or 1)

    signalFourier = fft(signal);
    N = length(signalFourier);
    
    f0_sample = f0*N/fs + 1;
    f1_sample = f1*N/fs + 1;

    if abs(signalFourier(f0_sample)) > abs(signalFourier(f1_sample))
        symbol = 0;
    else
        symbol = 1;
    end
end