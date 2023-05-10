require_relative "earley"
require_relative "gramatica"

regras = [
  Regra.new('S',   %w[0]),
  Regra.new('S',   %w[1]),
  Regra.new('S',   %w[2]),
  Regra.new('S',   %w[3]),
  Regra.new('S',   %w[4]),
  Regra.new('S',   %w[5]),
  Regra.new('S',   %w[6]),
  Regra.new('S',   %w[7]),
  Regra.new('S',   %w[8]),
  Regra.new('S',   %w[9]),
  Regra.new('D',   %w[0]),
  Regra.new('D',   %w[1]),
  Regra.new('D',   %w[2]),
  Regra.new('D',   %w[3]),
  Regra.new('D',   %w[4]),
  Regra.new('D',   %w[5]),
  Regra.new('D',   %w[6]),
  Regra.new('D',   %w[7]),
  Regra.new('D',   %w[8]),
  Regra.new('D',   %w[9]),
  Regra.new('S',   %w[D SD]),
  Regra.new('S',   %w[D MD]),
  Regra.new('S',   %w[D EXP]),
  Regra.new('S',   %w[LPAR P]),
  Regra.new('S',   %w[NEG S]),
  Regra.new('SD', %w[SUMDIF S]),
  Regra.new('MD', %w[MULDIV S]),
  Regra.new('EXP', %w[POW S]),
  Regra.new('P',   %w[S RPAR]),
  Regra.new('P',   %w[S PAROP]),
  Regra.new('LPAR',  %w['(']),
  Regra.new('RPAR',  %w[')']),
  Regra.new('PAROP',  %w[RPAR S1]),
  Regra.new('PAROP',  %w[RPAR M1]),
  Regra.new('PAROP',  %w[RPAR E1]),
  Regra.new('SUMDIF',  %w[+]),
  Regra.new('SUMDIF',  %w[-]),
  Regra.new('MULDIV',  %w[*]),
  Regra.new('MULDIV',  %w['/']),
  Regra.new('POW',  %w[^]),
  Regra.new('NEG',  %w[-])
]

gramatica = Gramatica.new(regras, "S")

parser = EarleyParser.new(gramatica)
puts "Digite uma operação: "
input = gets
puts parser.parse(input) ? 'Aceito' : 'Rejeitado'
