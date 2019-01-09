defmodule HttpHandler do
    use GenServer
    
    def start(_) do
        GenServer.start(__MODULE__, [])
    end

    def stop(pid, reason) do
    
        IO.puts("-------STOP 4-----\n")
        
        GenServer.cast(pid, {:stop, reason})
    end
    
    def start_link(args) do
        GenServer.start_link(__MODULE__, args)
    end
    
    def init(%{:method => method, :url => url, :headers => headers, :response => response}) do
        
        IO.puts("-----INIT HTTP_HANDLER----\n")

#        Process.send_after(self(), :exit, 1000)
        
        :inets.start()
        :ssl.start()

        Process.send(self(), :do, [])
        
        {:ok, %{:method => method, :url => url, :headers => headers, :response => response, :success_counter => 0, :error_counter => 0}}
    end
    
    def handle_call(_msg, _from, state) do
        {:reply, :ok, state}
    end

    def handle_cast({:stop, reason}, state) do
    
        IO.puts("-------STOP 5-----\n")
        
        {:stop, reason, state}
    end
    def handle_cast(_msg, state) do
        {:noreply, state}
    end

    def handle_info(:do, %{:method => method, :url => url, :headers => headers} = state) do
        queries = Application.get_env(:stress_test, :queries)
        Enum.each(queries, fn(query) ->
            Process.send_after(self(), {:do, query}, 30)
        end)
        Process.send_after(self(), :do, 30)
        {:noreply, state}
    end
    def handle_info({:do, query}, %{:method => method, :url => url, :headers => headers, :success_counter => sc, :error_counter => ec} = state) do
    
        encoded_query_charlist = QueryHelper.build_query(query)
        
        IO.inspect(encoded_query_charlist)
        IO.puts("\n")
        
        case :httpc.request(method, {to_charlist(url) ++ encoded_query_charlist, []}, [], []) do
            {:ok, {{_version, 200, _reason}, _headers, body}} ->
                
                IO.puts("------OK-----\n")
#                IO.inspect(body)
#                StressTest.ProcessController.handle_count()

                {:noreply, %{state | :success_counter => sc + 1}}
            res ->
                
                IO.puts("-----ERROR----\n")
#                IO.inspect(res)
#                StressTest.ProcessController.handle_count()

                {:noreply, %{state | :error_counter => ec + 1}}
        end
    end
#    def handle_info(:exit, state) do
#        Process.exit(self(), :exit)
#        {:noreply, state}
#    end
    def handle_info(_msg, state) do
        {:noreply, state}
    end
    
    def terminate(_reason, %{:success_counter => sc, :error_counter => ec}) do
    
        IO.puts("-------STOP 6-----\n")
        
        StressTest.ProcessController.handle_count(self(), sc, ec)
        :ok
    end
end