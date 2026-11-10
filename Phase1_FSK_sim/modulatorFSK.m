function modulatedSignal = modulatorFSK(bit_chain, fs, R, f0, f1)

% MODULATORFSK Binary FSK modulator.
%   modulatedSignal = MODULATORFSK(bit_chain, fs, R, f0, f1) converts a
%   chain of bits into an FSK signal. Each bit becomes a tone of duration
%   1/R seconds: f0 for a "0" and f1 for a "1".
%
%   Inputs:
%     bit_chain - Vector of bits (must contain only 0s and 1s)
%     fs        - Sample rate, in Hz
%     R         - Bit rate, in bit/s
%     f0        - Tone frequency for bit "0", in Hz
%     f1        - Tone frequency for bit "1", in Hz
%
%   Output:
%     modulatedSignal - Row vector with length(bit_chain)*fs/R samples,
%                       amplitude 1
%
    modulatedSignal = zeros(1, length(bit_chain)*fs/R);
    for i = 1 : length(bit_chain)
        bit = bit_chain(i);
        if bit == 0
            frequency = f0;
        elseif bit == 1
            frequency = f1;
        end
        modulatedSignal((i-1)*fs/R + 1 :  i*fs/R) = symbolCreatorFSK(fs, R, frequency); %concatenate the symbol to the modulated signal
    end
end