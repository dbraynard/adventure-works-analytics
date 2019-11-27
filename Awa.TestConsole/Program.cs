using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Awa.TestConsole {
    class Program {
       
        static void Main(string[] args) {

            var input = GetSampleInput();

            //TODO: Divide up this call into multiple threads
            //TODO: to chunk the signal processing.
            var output = ClientAggregator.ComputeRunningAverage(input,
                3,
                2,
                false);

            for (var i = 0; i < input.Count; i++) {
                Console.WriteLine($"{Math.Round(input[i])},{Math.Round(output[i])}");
            }
            Console.WriteLine("Done.");
            Console.ReadLine();
        }

        private static List<double> GetUnitTestInput() {
            var input = new List<double>();
            for (var i = 0; i < 10; i++) {
                input.Add(i + 1);
            }

            return input;
        }

        private static List<double> GetSampleInput() {
            var list = new List<double> {
                242.82,
                112.38,
                971.2,
                915.62,
                417.54,
                616.74,
                2807.46,
                6248.02,
                242.32,
                2840.25,
                6208.47,
                231.21,
                280.71,
                2120.95,
                222.04,
                2787.33,
                6232.34,
                234.61,
                574.22,
                2025.31,
                1816.08,
                502.54,
                2026.83,
                1078.52,
                316.17,
                1574.83,
                919.16,
                2838.98,
                1300.77
            };

            return list;
        }
    }
}
