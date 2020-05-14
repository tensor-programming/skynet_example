defmodule Skynet.Terminator do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    prepare_next()
    battle_sarah()

    {:ok, state}
  end

  def handle_info(:prepare_next, state) do
    if reporduce?() == true do
      IO.puts("Created new Terminator")
      Skynet.create_terminator()
    else
      IO.puts("Failed to reproduce")
      prepare_next()
    end

    {:noreply, state}
  end

  def handle_info(:battles_sarah, state) do
    if killed?() == true do
      IO.puts("Terminator killed by Sarah Connor!")
      Skynet.kill_terminator(self())
    else
      IO.puts("Terminator Survives")
      battle_sarah()
    end

    {:noreply, state}
  end

  defp battle_sarah do
    Process.send_after(self(), :battles_sarah, 10000)
  end

  defp prepare_next do
    Process.send_after(self(), :prepare_next, 5000)
  end

  defp killed? do
    :rand.uniform() <= 0.25
  end

  defp reporduce? do
    :rand.uniform() <= 0.65
  end
end
