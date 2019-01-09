defmodule StressTest do

    use Application

    def start(_type, _args) do
        StressTest.Supervisor.start_link()
    end

end
