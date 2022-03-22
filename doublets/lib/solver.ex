defmodule Doublets.Solver do
  @dictionary "./resources/words.txt" |> File.read!() |> String.split()

  def seleccion(word) do
    Enum.filter(@dictionary, fn x -> String.length(x) == String.length(word) and word != x end)
  end

  def variantes(palabra) do
    varia = seleccion(palabra)

    freq_varia = varia |> Enum.map(fn x ->
        List.zip([x |> String.graphemes(), palabra 
        |> String.graphemes()])
        |> Enum.map(fn {k, v} -> k == v end)
        |> Enum.count(fn x -> x == false end)
      end)

    List.zip([freq_varia, varia])
    |> Enum.filter(fn {k, v} -> k == 1 end)
    |> Enum.map(fn {_k, v} -> v end)
  end

  def doublets(word1, word2) do
    "make me work"
  end
end
