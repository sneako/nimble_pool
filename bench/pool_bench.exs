
defmodule BenchPool do
  @behaviour NimblePool

  @impl true
  def init_worker(pool_state) do
    {:ok, :worker_state, pool_state}
  end

  @impl true
  def handle_checkout(:checkout, _from, worker_state, pool_state) do
    {:ok, :client_state, worker_state, pool_state}
  end

  @impl true
  def handle_checkin(:client_state, _from, worker_state, pool_state) do
    {:ok, worker_state, pool_state}
  end
end

{:ok, _pid} = NimblePool.start_link(worker: {BenchPool, :ok}, pool_size: 10, name: BenchPool)

Benchee.run(
  %{
    "checkout!" => fn ->
      NimblePool.checkout!(BenchPool, :checkout, fn _, _ -> {nil, :client_state} end)
    end
  },
  time: 5,
  memory_time: 2,
  parallel: 10
)
