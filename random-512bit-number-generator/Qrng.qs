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

    operation SampleRandomNumberByBitSize(bitsNumber: Int) : BigInt {
        mutable bits = new Result[0];
        for idxBit in 1..bitsNumber {
            set bits += [SampleQuantumNumberGenerator()];
        }
        let sampleBool = ResultArrayAsBoolArray(bits);
        let sample = BoolArrayAsBigInt(sampleBool);
        // return sample > PowD(2, bitsNumber) 
        //     ? SampleRandomNumberInRange(bitsNumber)
        //     | sample;
        return sample < IntAsBigInt(0)
            ? -sample
            | sample;
    }

    @EntryPoint()
    operation SampleRandomNumber() : BigInt {
        let bitsNumber = 512;
        Message($"Sampling a random {bitsNumber}bit number: ");
        return SampleRandomNumberByBitSize(bitsNumber);
    }
}
