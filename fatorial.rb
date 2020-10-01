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
