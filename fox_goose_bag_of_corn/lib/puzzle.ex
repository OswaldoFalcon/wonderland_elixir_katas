defmodule FoxGooseBagOfCorn do

  @listaRestricciones [[:fox, :goose],[:goose, :corn]]


  #def hello do
   #lista = [[:fox, :goose, :corn, :you], [:boat],[]]
    #        [[:fox,:corn] [:boat ,:goose, :you] []]
     #       [[:fox,:corn] [:boat] [,:goose, :you]]
      #      [[:fox,:corn] [:boat, :you] [,:goose]]
       #     [[:fox,:corn, :you] [:boat] [,:goose]]
        #    [[:corn] [:boat, :you,:fox] [,:goose]]
         #   [[:corn] [:boat] [,:goose,:fox, :you]]
        #    [[:corn] [:boat, :you, :goose] [:fox]]
         #  [[:corn, :you, :goose] [:boat] [:fox]]
          #  [[:goose] [:boat,:corn, :you] [:fox]]
           # [[:goose] [:boat] [:fox,:corn, :you]]
            #[[:goose] [:boat, :you] [:fox,:corn]]
           # [[:goose, :you] [:boat] [:fox,:corn]]
           # [[] [:boat,:goose, :you] [:fox,:corn]]
           # [[] [:boat] [:fox,:corn, :goose, :you]]

  #end 
def solver() do
    listaActual= [[:corn], [:boat], [:goose,:fox, :you]]

    #nos dice donde esta el :you
    posi= Enum.find_index(listaActual,fn x -> Enum.member?(x, :you)end)

    case posi do
      #regresa los posibles elementos a mover
      0 -> b = Enum.at(listaActual,0) |> List.delete(:you)
      #concatenar el elemento a lista del bote
      |> Enum.map(fn x ->
        #mueve el :you y un elemento al :bote
        List.update_at(listaActual,1,&(&1++[x,:you]))
        #elimina el elemento que se movio de la lista de la orilla
        |>List.update_at(0,&List.delete(&1,x))
        |>List.update_at(0,&List.delete(&1,:you))


      end)

     1 -> a=Enum.at(listaActual,1) |> List.delete(:boat)
     listaActual = List.update_at(listaActual,1,&(&1=[:boat]))
     [List.update_at(listaActual,0, &(&1++a)),List.update_at(listaActual,2, &(&1++a)) ]

     2 ->  c = Enum.at(listaActual,2) |> List.delete(:you)
     #concatenar el elemento a lista del bote
     |> Enum.map(fn x ->
       List.update_at(listaActual,1,&(&1++[x,:you]))
       |>List.update_at(2,&List.delete(&1,x))
       |>List.update_at(2,&List.delete(&1,:you))

    end)
  end
end
  def verificacion(listaPrincipal) do
    #Busca estados restringidos de los cuales retorna una lista de listas con booleanos
    Enum.any?(listaPrincipal, fn x -> Enum.any?(@listaRestricciones, &(&1 == x)) end)

  end
end