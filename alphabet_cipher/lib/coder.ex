defmodule AlphabetCipher.Coder do

  def abc() do
    alf = Enum.map(?a..?z, fn x -> x end)
    alf |> Enum.with_index()
  end

  def encode(keyword, message) do
   # "encodeme"

    #Traemos a abecedario
    abecedario = abc()
    #le damos el formato charlist al mensaje y clave
    message = message |> String.downcase 
    keyword = keyword|> String.downcase 
    |> String.duplicate(ceil(String.length(message) / String.length(keyword))) 
    |> to_charlist
    message = to_charlist(message)
    
    #dado la keyword  encuentra sus index 
    colum_index = keyword |> Enum.map(fn x -> List.keyfind(abecedario,x,0) end) |> 
      Enum.map(fn {_k,v} -> v end)
    #dado la message  encuentra sus index 
    row_index = message |> Enum.map(fn x -> List.keyfind(abecedario,x,0) end) |> 
      Enum.map(fn {_k,v} -> v end)
    
    #unimos fila columna 
    rc = List.zip([row_index,colum_index])
    #Ahora dado las tuplas de fila x columna 
    #sacamos el mensaje encriptado.
    rc |> Enum.map(fn {k,v} ->
      Enum.slice(97..122,k..25) ++ Enum.slice(97..122, 0..k-1)|>
      Enum.at(v)end) |> to_string
  end

  def decode(keyword, enco) do
    "decodeme"
    #Traemos a abecedario
    abecedario = abc()
    #le damos el formato charlist al mensaje y clave
    enco = enco |> String.downcase 
    keyword = keyword|> String.downcase 
    |> String.duplicate(ceil(String.length(enco) / String.length(keyword))) 
    |> to_charlist
    enco = to_charlist(enco)
    #dado la keyword encuentra sus index 
    colum_index = enco |> Enum.map(fn x -> List.keyfind(abecedario,x,0) end) |> 
      Enum.map(fn {k,_v} -> k end)
    #dado la message  encuentra sus index 
    row_index = keyword |> Enum.map(fn x -> List.keyfind(abecedario,x,0) end) |> 
      Enum.map(fn {_k,v} -> v end)
    #unimos fila columna 
    rc = List.zip([row_index,colum_index]) 
    #Ahora dado las tuplas de fila x columna 
    #sacamos el mensaje encriptado.
    index = rc |> Enum.map(fn {k,v} ->
     Enum.slice(97..122,k..25) ++ Enum.slice(97..122, 0..k-1) |> Enum.find_index(fn x -> x == v end) 
     end)
    alpha = Enum.map(?a..?z, fn x -> x end)
    Enum.map(index, fn x -> Enum.at(alpha,x)end) |> to_string
  end

  def decipher(cipher, message) do
    "decypherme"
    #Traemos a abecedario
    abecedario = abc()
    #le damos el formato charlist al mensaje y clave
    message = message |> String.downcase |> to_charlist 
    cipher = cipher|> String.downcase |> to_charlist 
    #dado la keyword encuentra sus index 
    colum_index = cipher |> Enum.map(fn x -> List.keyfind(abecedario,x,0) end) |> 
      Enum.map(fn {k,_v} -> k end)
    #dado la message  encuentra sus index 
    row_index = message |> Enum.map(fn x -> List.keyfind(abecedario,x,0) end) |> 
      Enum.map(fn {_k,v} -> v end)
    rc = List.zip([row_index,colum_index])
    index = rc |> Enum.map(fn {k,v} ->
     Enum.slice(97..122,k..25) ++ Enum.slice(97..122, 0..k-1)|> Enum.find_index(fn x -> x == v end)  end)
    alpha = Enum.map(?a..?z, fn x -> x end)
    #index = Enum.map(index, fn x -> Enum.at(alpha,x) end)  
    #regresamoa a string el mensaje para usarlo
    message = message |> to_string
    cipher = cipher |> to_string

    Enum.map(index, fn x -> Enum.at(alpha,x)end)
    |> Enum.reduce("", fn(x, acc) ->
      cond do
        String.length(acc) == 0 -> acc <> to_string([x])
        encode(acc, message) == cipher -> acc
        true -> acc <> to_string([x])
      end
    end)
  end
end
