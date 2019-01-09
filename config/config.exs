# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :stress_test, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:stress_test, :key)
#
# You can also configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"

config :stress_test,
        children_num: 100,
#        children_conf: {HttpHandler, %{:method => :get, :url => 'https://geo.vezet.ru/search?new_geo_suggest=1', :headers => [], :response => ''}},
#        children_conf: {HttpHandler, %{:method => :get, :url => 'http://localhost:8080/search?new_geo_suggest=1', :headers => [], :response => ''}},
        children_conf: {HttpHandler, %{:method => :get, :url => 'http://localhost:8080/services/tracks', :headers => [], :response => ''}},
        queries: [
#            [{:city, "moscow"},{:query, "новос"}],
#            [{:city, "moscow"},{:query, "конст"}],
#            [{:city, "moscow"},{:query, "ленен"}],
#            [{:city, "moscow"},{:query, "метро оста"}],
#            [{:city, "moscow"},{:query, "земл вал"}],
#            [{:city, "moscow"},{:query, "аэроп"}],
#            [{:city, "moscow"},{:query, "шерем"}],
#            [{:city, "moscow"},{:query, "домде"}],
#            [{:city, "moscow"},{:query, "кожевнич"}],
#            [{:city, "moscow"},{:query, "парк гор"}],
#            [{:city, "tver"},{:query, "побе"}],
#            [{:city, "tver"},{:query, "экспер"}],
#            [{:city, "tver"},{:query, "жк удача на удачной"}],
#            [{:city, "tver"},{:query, "склесков"}],
#            [{:city, "tver"},{:query, "горсад"}],
#            [{:city, "tver"},{:query, "новож"}],
#            [{:city, "tver"},{:query, "метро"}],
#            [{:city, "tver"},{:query, "звизда"}],
#            [{:city, "tver"},{:query, "волга"}],
#            [{:city, "tver"},{:query, "южный"}]

#            [{:city, "moscow"},{:query, "новос"}],
#            [{:city, "test"},{:query, "конст"}]

            [{:city, "moscow"}, {:lat, 55.776053}, {:lon, 37.612572}],
            [{:city, "omsk"}, {:lat, 54.98852}, {:lon, 73.30555666666667}]
        ]
        