defmodule Contas do
  use GenServer

  def init(init_arg) do
    {:ok, init_arg, {:continue, :inicio_conta}}
  end

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: Contas)
  end

  def handle_call(:dados, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:compra, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_info(:inicio_conta, state) do
    {:noreply, start(state)}
  end

  def handle_continue(:inicio_conta, state) do
    {:noreply, start(state)}
  end

  defp start(state) do
    Process.sleep(4_000)
    Map.put(state, :inicio_conta, DateTime.utc_now())
  end

end
