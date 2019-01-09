defmodule QueryHelper do
    @moduledoc false

    def build_query([{:city, city}, {:lat, lat}, {:lon, lon}]) do
        '?city=' ++ to_charlist(city) ++ '&lat=' ++ to_charlist(lat) ++ '&lon=' ++ to_charlist(lon)
    end
    def build_query([{:city, city}, {:query, query}]) do
        '?city=' ++ to_charlist(city) ++ '&query=' ++ to_charlist(URI.encode(query))
    end
end
