defmodule CardGameWar.Game do
  # feel free to use these cards or use your own data structure"
  @suits [:spade, :club, :diamond, :heart]
  @ranks [2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king, :ace]
  @cards for suit <- @suits, rank <- @ranks, do: {suit, rank}

  defstruct deck_p1: [], deck_p2: [] 

  def new_game do 
  baraja = Enum.shuffle(@cards) |> Enum.chunk_every(26) 
  %__MODULE__{deck_p1: List.first(baraja) |> Enum.take(3), deck_p2: List.last(baraja) |> Enum.take(3)} 
  end
  def play(%__MODULE__{deck_p1: []} = _game), do: :player_two
  def play(%__MODULE__{deck_p2: []} = _game), do: :player_one
  def play (%__MODULE__{deck_p1: [card_1 | other_cards_1], deck_p2: [card_2 | other_cards_2]} = game) do
    case round(card_1,card_2) do
      :player_one -> play(%{game | deck_p1: other_cards_1 ++ [card_1, card_2], deck_p2: other_cards_2} )
      :player_two -> play(%{game | deck_p2: other_cards_2 ++  [card_2, card_1], deck_p1: other_cards_1})
      error -> throw error
    end
  end


  def round({suit_1,rank_1},{suit_2,rank_2}) do  # Game.round({:spade, :ace}, {:spade, :ace})
  rank_val_1 = Enum.find_index(@ranks, &(&1 == rank_1))
  rank_val_2 = Enum.find_index(@ranks, &(&1 == rank_2))
  cond do
    rank_val_1 > rank_val_2 -> :player_one
    rank_val_1 < rank_val_2 -> :player_two
    true ->
      suit_val_1 = Enum.find_index(@suits, &(&1 == suit_1))
      suit_val_2 = Enum.find_index(@suits, &(&1 == suit_2))
      cond do
        suit_val_1 > suit_val_2 -> :player_one
        suit_val_1 < suit_val_2 -> :player_two 
        true -> {:error, "It's the same card NOOO!"}
      end
  end
  end

end
