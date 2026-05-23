def mex(ary)
  result = 0
  while true do
    return result unless ary.index(result)
    result += 1
  end
end

def grundy(s_input)
  s = s_input.filter { |num| num > 0 }
  a = []
  max_s = s.max

  while true do
    prevs = s.map { |si| a.length - si < 0 ? -1 : a[-si] }
    a.push(mex(prevs))
    for i in 1..(a.length/2) do
      lookback = 0
      cycle_flag = true
      while lookback < max_s do
        cycle_flag &= a[(-lookback-i)..(-lookback-1)] == a[(-lookback-i*2)..(-lookback-i-1)]
        lookback += i
      end
      if cycle_flag
        period = a[-i..-1]
        first_period_coef = 1
        while true do
          if a[(-first_period_coef*i-i)..(-first_period_coef*i-1)] == period
            first_period_coef += 1
          else
            break
          end
        end
        pre_period = a[0...(-first_period_coef*i)]
        return {
          pre_period_length: pre_period.length,
          period_length: period.length,
          pre_period:,
          period:,
        }
      end
    end
  end

  return a
end

def show_grundy(s_input, show: [:pre_period_length, :period_length, :pre_period, :period])
  result = grundy(s_input)

  if show.index(:pre_period_length)
    puts "pre-period length: #{result[:pre_period_length]}"
  end

  if show.index(:period_length)
    puts "period length: #{result[:period_length]}"
  end

  if show.index(:pre_period)
    puts "pre-period: #{result[:pre_period].join("")}"
  end

  if show.index(:period)
    puts "period: #{result[:period].join("")}"
  end
end

q = 3
8.step(40, 8) do |b|
  d = b + 2
  r = d / 2 + 2
  c = q * d + r
  p [2, b, c]
  show_grundy([2, b, c], show: [:pre_period])
end
