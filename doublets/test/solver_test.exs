defmodule Doublets.SolverTest do
  use ExUnit.Case
  import Doublets.Solver

  test "with word links found" do
    assert ["head", "heal", "teal", "tell", "tall", "tail"] ==
             doublets("head", "tail")

    assert ["door", "boor", "book", "look", "lock"] ==
             doublets("door", "lock")

    assert ["bank", "bonk", "book", "look", "loon", "loan"] ==
             doublets("bank", "loan")

    assert ["wheat", "cheat", "cheap", "cheep", "creep", "creed", "breed", "bread"] ==
             doublets("wheat", "bread")
  end

  test "with no word links found" do
    assert [] == doublets("ye", "freezer")
  end

  test "Diferencia de palabras" do
    assert 1 == distance("cheap", "cheep")
    assert 0 == distance("asdf", "asdfgh")
    assert 3 == distance("door", "baar")
    assert 1 == distance("axdf", "asdfgh")
  end

  test "palabras same lenght" do
    assert ["liken", "impar", "untie", "cheat", "cheap", "cheep", "creep", "creed", "breed", "bread"] == same_length_words("wheat")
  end

  test "Enconrar las variantes con 1 letra de modif" do
    assert ["cheat"] == find_variants("wheat")
    assert ["wheat", "cheap"] == find_variants("cheat")
  end

  test "Ultima palabra de la lisa" do
    assert "bamba" == last_word(["mango", "mamba", "bamba"])
  end

  test "Encuentra las variantes" do
    assert [["wheat", "cheat", "cheap"]] == complete_seq_variants(["wheat", "cheat"])
  end

  test "compara si ya es una solucion" do
    # si cae en la primera lista
    assert ["mango", "bamba"] == find_solution([["mango", "bamba"]], "bamba")
    # si cae en la segunda lista
    assert ["mango"] == find_solution([["mango", "bamba"], ["mango"]], "mango")
    # si no esta en ningua nil
    assert nil == find_solution([["mango", "bamba"], ["mango"]], "manga")
    assert ["mango", "mango"] == find_solution([["mango", "mango"], ["mango"]], "mango")
    assert nil == find_solution([[], []], "manta")
  end

  test "Recursion" do
    assert [] == doublets_impl([], "")
    assert ["door", "boor", "book"] == doublets_impl([["door"]], "book")
    assert ["cheap", "cheep", "creep", "creed"] == doublets_impl([["cheap"]], "creed")
  end
end
