defmodule Hw.Primes do
  @moduledoc """
  Documentation for `Hw.Primes`.
  """
  @doc """
  Checks if a number n is a prime number.
  Returns n if it is or 0 if it's not.

  ## Examples
      iex> Hw.Primes.is_prime(3)
      3
      iex> Hw.Primes.is_prime(4)
      0
  """
  def is_prime(n), do: do_is_prime(n, 2, :math.sqrt(n))
  defp do_is_prime(n, _i, _l) when n < 2, do: 0
  defp do_is_prime(n, i, l) when i > l, do: n
  defp do_is_prime(n, i, _l) when rem(n, i) == 0, do: 0
  defp do_is_prime(n, i, l), do: do_is_prime(n, i+1, l)

  @doc """
  Sums all primes before the limit n.
  Returns the sum of all primes.

  ## Examples
      iex> Hw.Primes.sum_primes(10)
      17
  """
  def sum_primes(n), do: do_sum_primes(2, 0, n)
  defp do_sum_primes(i, res, n) when i >= n, do: res
  defp do_sum_primes(i, res, n) do
    do_sum_primes(i+1, res+is_prime(i), n)
  end

  @doc """
  Sums all primes between l (inclusive) and h (exclusive).
  Returns the sum of all primes.

  ## Examples
      iex> Hw.Primes.sum_primes_bounds(5, 9)
      12
  """
  def sum_primes_bounds(l, h), do: do_sum_primes(l, 0, h)

  defp gen_threads(blocks, r, t), do: do_gen_threads(t, [], blocks, 1, r)
  defp do_gen_threads(0, res, _b, _start, _r), do: res
  defp do_gen_threads(t, res, blocks, start, r) do
    do_gen_threads(t-1,
     [Task.async(fn -> sum_primes_bounds(start, start+blocks+r) end) | res],
      blocks, start+blocks+r, 0)
  end

  @doc """
  Sums all primes before limit n in t threads.

  ## Examples
      iex> Hw.Primes.sum_primes_parallel(5000000, 20)
      838596693108
  """
  def sum_primes_parallel(n, t) do
    blocks = div(n, t)
    r = rem(n, t)
    gen_threads(blocks, r, t)
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.sum()
  end

  @doc """
  Returns the amount of time in seconds
  a function func takes to execute.
  """
  def measure_time(func) do
    func
    |> :timer.tc()
    |> elem(0)
    |> Kernel./(1_000_000)
  end
end
