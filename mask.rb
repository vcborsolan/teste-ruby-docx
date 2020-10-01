# 2) Faça uma função que receba uma string contendo um CPF e verifique se ele está formatado de acordo com a máscara 999.999.999-99. A função deve usar regex para fazer a validação da máscara e deve retornar verdadeiro ou falso.
# cpf = “461.636.517-23”

def correct_masked?(string)
  if string.is_a?(String)
    string.match(/[0-9]{3}\D[0-9]{3}\D[0-9]{3}\D[0-9]{1,2}/) ? true : false
  else false
  end
end