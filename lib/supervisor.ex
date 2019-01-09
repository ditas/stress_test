defmodule StressTest.Supervisor do
    use Supervisor
    
    def start_link() do
        Supervisor.start_link(__MODULE__, [])
    end
    
    def init(_) do
        children = [
            worker(StressTest.ProcessController, [], restart: :permanent)
        ]
        supervise(children, strategy: :one_for_one, max_restarts: 1000, max_seconds: 3600)
    end
end