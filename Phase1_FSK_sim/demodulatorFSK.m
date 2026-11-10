function demodulated_bits = demodulatorFSK(signal, fs, R, f0, f1)
% DEMODULATORFSK Binary FSK demodulator (non-coherent).
%   demodulated_bits = DEMODULATORFSK(signal, fs, R, f0, f1) recovers the
%   bits from an FSK signal. The signal is split into blocks of fs/R
%   samples (one per symbol) and each block is decided with DETECTSYMBOL,
%   which compares the energy at f0 and f1.
%
%   Inputs:
%     signal - FSK signal (vector)
%     fs     - Sample rate, in Hz
%     R      - Bit rate, in bit/s
%     f0     - Tone frequency for bit "0", in Hz
%     f1     - Tone frequency for bit "1", in Hz
%
%   Output:
%     demodulated_bits - Row vector with length(signal)*R/fs bits
%                        (0s and 1s)
    lengthSymbol = fs/R;
    numSymbols = length(signal)/lengthSymbol;
    demodulated_bits = zeros(1, numSymbols);
    for i = 1 : numSymbols
        symbols_signal(1:lengthSymbol) = signal(lengthSymbol*(i-1) + 1 : lengthSymbol*i);
        demodulated_bits(i) = detectSymbol(symbols_signal, fs, f0, f1);
    end

end