using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Awa.TestConsole {
    class ClientAggregator {

        public static List<double> ComputeRunningAverage(List<double> input,
            int windowStart, int windowEnd, bool includeCurrentValue) {

            var output = new List<double>();
            var inputCount = input.Count;
            var lastSum = 0d;
            var lastWindowStartVal = 0d;
            var lastWindowEndIndex = -1;
            var startIndex = -windowEnd - 1;
            for (var i = startIndex; i < inputCount; i++) {
                var lookBackRaw = i - windowStart;
                var lookBack = lookBackRaw;
                var lookAheadRaw = i + windowEnd;
                var lookAhead = lookAheadRaw >= inputCount
                    ? inputCount - 1
                    : lookAheadRaw;
                var lastLookBackRaw = lookBack - 1;
                var sum = lastSum;
                if (lastLookBackRaw >= 0) {
                    //remove the last lookBackRaw
                    sum -= lastWindowStartVal;
                }
                //add the windowEnd to sum if window hasn't reached the end
                if (lastWindowEndIndex < inputCount - 1 && lookAhead >= 0) {
                    sum += input[lookAhead]; //windowEndVal
                }
                //only record values for inputs
                if (i >= 0) {
                    var lookBackForCount = lookBack < 0 ? 0 : lookBack;
                    lastWindowStartVal = lookBack < 0 
                        ? 0 
                        : input[lookBack];
                    var count = lookAhead - lookBackForCount + 1 +
                                (includeCurrentValue ? 0 : -1);
                    var currentValueAdj = !includeCurrentValue
                        ? input[i]
                        : 0;
                    var sumForSaving = sum - currentValueAdj;
                    var nextAvg = sumForSaving / count;
                    output.Add(nextAvg);
                }
                lastSum = sum;
                lastWindowEndIndex = lookAhead;
            }
            return output;
        }
    }
}
