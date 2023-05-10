require 'set'
require 'pastel'
require_relative 'gramatica'
require_relative 'estado'

class EarleyParser
  attr_reader :gramatica, :pastel

  def initialize(gramatica)
    @pastel = Pastel.new

    @gramatica = gramatica
    # Parser de Early precisa de um uma regra S->S
    # para o primeiro passo, assim, adicionamos
    # automaticamente na gramática
    @gramatica.regras.unshift(Regra.new(gramatica.simbolo_inicial, [gramatica.simbolo_inicial]))
  end

  def parse(entrada)
    # Lista de estado. Tem tamanho do entrada + 1
    # pq se o último tiver o estado inicial,
    # estará no entrada + 1
    @tabela = Array.new(entrada.length + 1) { |index| S.new(index) }

    predict(Estado.new(@gramatica.regras[0], 0, 0), 0)

    puts "\nLendo os caracteres... \n\n"

    entrada.split('').each_with_index do |item, index|
      puts pastel.red("Caracter: #{item}, Posição: #{index}")
      until @tabela[index].empty?
        puts pastel.magenta(@tabela)
        estado = @tabela[index].take!
        # puts(estado)
        # if estado.completo?
        #   complete(estado, index)
        # elsif estado.next_symbol == item
        #   scan(estado, index)
        # else
        #   predict(estado, index)
        # end
        if estado.completo?
          complete(estado, index)
        elsif estado.next_symbol == item
          # chega se próximo item é um não terminal
          predict(estado, index)
        else
          scan(estado, index)
        end
      end
    end

    final_is_valid?(@tabela[entrada.length])
  end

  private

  def final_is_valid?(estado)
    estado.estados.select do |estado|
      estado.regra.esquerda == gramatica.simbolo_inicial && estado.completo? && estado.inicio == 0
    end.any?
  end

  def predict(estado, index)
    @gramatica.regras.each do |regra|
      puts pastel.green("[Predict] N: #{estado.next_symbol}, I: #{regra.esquerda}, Eq? #{estado.next_symbol == regra.esquerda}")
      next unless regra.esquerda == estado.next_symbol

      puts "[Predict] esquerda: #{regra.esquerda}, próximo: #{estado.next_symbol}"
      novo_estado = Estado.new(regra, 0, index)
      @tabela[index] << novo_estado
      puts "[Predict] Adicionando regra #{novo_estado}"
    end
  end

  def scan(estado, index)
    puts pastel.green "[Scan] Proximo estado: #{estado.advance}"
    @tabela[index + 1] << estado.advance
  end

  def complete(estado, index)
    @tabela[estado.inicio].estados.each do |estado_candidato|
      puts pastel.cyan "[Complete] Estado Candidato: #{estado_candidato}"
      @tabela[index] << estado_candidato.advance if estado_candidato.next_symbol == estado.regra.esquerda
    end
  end
end
