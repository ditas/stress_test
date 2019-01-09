defmodule StressTest.ProcessController do
    use GenServer
    
    def start() do
        GenServer.start(__MODULE__, [])
    end
    
    def start_link() do
        GenServer.start_link(__MODULE__, [], name: __MODULE__)
    end

    def handle_count(pid, n, m) do
        GenServer.cast(__MODULE__, {:count, pid, n, m})
    end
    
    def stop() do
        
        IO.puts("-------STOP 1-----\n")
        
        GenServer.cast(__MODULE__, :stop)
    end
    
    def init(_opts) do
        
        IO.puts("-----INIT----\n")

        Process.flag(:trap_exit, true)
        
        children_num = Application.get_env(:stress_test, :children_num)
        {module, args} = Application.get_env(:stress_test, :children_conf)
        start_time = Time.utc_now()
        children = List.foldl(Enum.to_list(1..children_num), [], fn(_, acc) ->
            case module.start_link(args) do
                {:ok, pid} -> [pid|acc]
                _ -> acc
            end
        end)
        {:ok, %{:children => children, :success_counter => 0, :error_counter => 0, :start_time => start_time}}
    end
    
    def handle_call(_msg, _from, state) do
        {:reply, :ok, state}
    end

    def handle_cast(:stop, %{:children => children, :success_counter => sc, :error_counter => ec} = state) do
    
        IO.puts("-------STOP 2-----\n")
    
        Enum.each(children, fn(ch) ->
        
            IO.puts("-------STOP 3-----\n")
        
            HttpHandler.stop(ch, :normal)
        end)
    
        {:noreply, state}
    end
    def handle_cast({:count, pid, n, m}, %{:children => children, :success_counter => sc, :error_counter => ec} = state) do
        new_children = List.delete(children, pid)
        new_sc = sc + n
        new_ec = ec + m
        
        case length(new_children) == 0 do
            true ->
                IO.inspect({new_sc, new_ec})
            false ->
                IO.inspect({pid, new_sc, new_ec})
        end
        
        {:noreply, %{state | :children => new_children, :success_counter => new_sc, :error_counter => new_ec}}
    end
    def handle_cast(_msg, state) do
        {:noreply, state}
    end
    
    def handle_info(msg, state) do
        
        IO.puts("-----!-----\n")
        IO.inspect(msg)
        
        {:noreply, state}
    end
end