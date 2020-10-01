# O que é este projeto?

Este projeto tem como finalidade , solucionar um teste tecnico para vaga de back-end ruby.


# Qual a versão do ruby utilizada?

2.6

# Questões?

1) Faça uma função que receba uma string e retorne verdadeiro caso ela seja palíndromo, do contrário ela deve retornar falso. (palíndromos são palavras ou frases que podem ser lidas da esquerda para a direita ou da direita para a esquerda.)

R  => 

```ruby
def palindrome?(string)
  if string.is_a?(String)
    string.downcase().reverse() == string.downcase() ? true : false
  else false
  end
end
```

2) Faça uma função que receba uma string contendo um CPF e verifique se ele está formatado de acordo com a máscara 999.999.999-99. A função deve usar regex para fazer a validação da máscara e deve retornar verdadeiro ou falso.
cpf = “461.636.517-23”


R => 

```ruby
def correct_masked?(string)
  if string.is_a?(String)
    string.match(/[0-9]{3}\D[0-9]{3}\D[0-9]{3}\D[0-9]{1,2}/) ? true : false
  else false
  end
end
```

3) O fatorial de um número n!, é definido como o produto de todos os números inteiros de 1 a n. Por exemplo: 5! é 5 * 4 * 3 * 2 * 1 = 120

A maioria das implementações de cálculo de fatoriais usam uma função recursiva para determinar o valor fatorial(n). No entanto, a maioria dos sistemas não consegue lidar com pilhas de recursividade maio	res que 2000.

Implemente uma função para calcular o fatorial de números arbitrariamente grandes, sem utilizar recursividade.

Regras
    • n < 0 deve retornar nil
    • n = 0 deve retornar 1
    • n > 0 deve retornar n!


R => 

Com ruby > 2.4.0 onde smallnum e bignum foram incorporadas pelo integer:

```ruby
def fatorial(int)
  if int > 0
    tmp = int
    (2..(int - 1)).each do |item|
      tmp =* item
    end
  else
    return int == 0 ? 1 : nil
  end
end

Benchmark.bm(7) do |x| 
x.report("funcao x:"){ 
fatorial(2001)
}
end
fatorial(2001)
```

Com ruby < 2.4.0 será necessário importar a classe bigdecimal e forçar desde o início o integer ser reconhecido como bignum para melhoria de performance

```ruby
require 'benchmark'
require 'bigdecimal'

def fatorial(int)
  if int > 0
    tmp = BigDecimal(int)
    (2..(int - 1)).each do |item|
      tmp =* item
    end
  else
    return int == 0 ? 1 : nil
  end
end

Benchmark.bm(7) do |x| 
x.report("funcao x:"){ 
fatorial(2001)
}
end
fatorial(2001)
```

4) A partir das tabelas do banco de dados abaixo, escreva uma query sql que através de join, retorne o nome completo, cpf, equipe e cargo dos colaboradores ordenando os por cpf.

![Tabela](https://github.com/vcborsolan/teste-ruby-docx/blob/master/screen.jpg)

R => 

```sql
SELECT CONCAT(teams.first_name , ' ' , teams.last_name) as nomecompleto , employees.cpf , teams.name as equipe , job_titles.name as cargo
From employees INNER JOIN job_titles ON employees.job_title_id = job_titles.id
INNER JOIN teams ON employees.team_id = teams.id
ORDER BY cpf ;
```

5) Usando as tabelas do banco de dados do exercício anterior, escreva as classes das models Employee, Team e JobTitle, declare as associações das models e escreva a mesma query com a sintaxe do ActiveRecord.

R => 

As migrations:

```ruby

class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.timestamps
    end
  end
end

class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :name
      t.timestamps
    end
  end
end

class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :cpf
      t.references :team, foreign_key: true
      t.references :job, foreign_key: true
      t.timestamps
    end
  end
end
```

A classe dos models :

```ruby

class Employee < ApplicationRecord
  belongs_to :team
  belongs_to :job
end


class Job < ApplicationRecord
  has_one :employee
end

class Team < ApplicationRecord
  has_one :employee
end

```

SQL via activerecord : 
```ruby
Employee.joins(:team , :job).order(:cpf) 
```

Importante levar em consideração que aqui não se faz necessário selecionar quais dados você pretende retornar sendo que em cada objeto pode-se acessar o dado.
Ex: Employee.joins(:team , :job).order(:cpf).first.team.name
Retorna “TI”

6) Descreva o que faz o seguinte comando e por que ele é amplamente utilizado: a ||= b

R => 

O operador or-equal tem como objetivo dar início a variável caso ela já não tenha valores , este operador eh muito utilizado quando lidamos com variáveis globais ou de instância , dado que podem herdar valores em outros momentos , sendo assim para não sobrepor o possível valor herdado.

Ex: @instancia ||= [ ]