# Hw.Primes

Module with functions to sum all prime numbers before a limit. Contains sequential and parallel versions. Functions:

- `Hw.Primes.sum_primes/1`: Returns the sum of all primes before the limit sequentially.
  Takes the limit as an argument.
- `Hw.Primes.sum_primes_parallel/2`: Takes 2 arguments, n and t. Sums all primes before n
  in t threads.

## Time Complexity

The algorithm used to sum prime numbers takes O(n^2) time, since it has to iterate through every number and
for each one, to check if it's a prime number, it has to divide n by every number from 2 to √n.

## Speed Comparison

Speed measurements (in seconds) for both versions of the algorithm with `n = 5,000,000` and `t = 20` (for the parallel version)
are listed in the following table:

| **Method/Run** | **1** | **2** | **3** | **4** | **5** | **Avg** |
| -------------- | ----- | ----- | ----- | ----- | ----- | ------- |
| **Sequential** | 24.64 | 24.54 | 24.63 | 24.65 | 24.68 | 24.63   |
| **Parallel**   | 4.55  | 4.23  | 4.3   | 4.13  | 4.69  | 4.32    |

On average, the parallel version is 20.31 seconds faster than the sequential version, a 5.70 speed up.
