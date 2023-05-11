require_relative 'cyk'
require_relative 'gramatica'

regras = [
  Regra.new('S',%w[S NEX]),
  Regra.new('S',%w[NEG S]),
  Regra.new('S',%w[LP S]),
  Regra.new('S',%w[S RP]),
  Regra.new('NEX',%w[EX S]),
  Regra.new('S',%w[0]),
  Regra.new('S',%w[1]),
  Regra.new('S',%w[2]),
  Regra.new('S',%w[3]),
  Regra.new('S',%w[4]),
  Regra.new('S',%w[5]),
  Regra.new('S',%w[6]),
  Regra.new('S',%w[7]),
  Regra.new('S',%w[8]),
  Regra.new('S',%w[9]),
  Regra.new('EX',%w[+]),
  Regra.new('EX',%w[-]),
  Regra.new('EX',%w[*]),
  Regra.new('EX',%w[^]),
  Regra.new('NEG',%w[-]),
  Regra.new('LP',%w[(]),
  Regra.new('RP',%w[)]),
  Regra.new('EX',%w[/])
]

gramatica = Gramatica.new(regras, 'S')
parser = CYKParser.new(gramatica)
# Escreva a espessão aqui
input = ""
# Sem espaços em branco
parser.parse(input).inspect
puts input
puts parser.aceito? ? 'Aceito' : 'Não aceito'
puts "\n"