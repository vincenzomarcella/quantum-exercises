namespace Qrng {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;
    // open Microsoft.Quantum.Extensions.Convert;

    // This operation samples a random qubit value
    operation SampleQuantumNumberGenerator() : Result {
        use q = Qubit();
        H(q);
        return MResetZ(q);
    }

    operation SampleRandomNumberInRange(max: Int) : Int {
        mutable bits = new Result[0];
        for idxBit in 1..BitSizeI(max) {
            set bits += [SampleQuantumNumberGenerator()];
        }
        let sample = ResultArrayAsInt(bits);
        return sample > max
            ? SampleRandomNumberInRange(max)
            | sample;
    }

    @EntryPoint()
    operation SampleRandomNumber() : Int {
        let max = 512;
        Message($"Sampling a random number between 0 and {max}: ");
        return SampleRandomNumberInRange(max);
    }
}
