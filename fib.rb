def fibs n
  fibs = [0, 1]
  if n >= 2
    (2..n).each do |i|
      fibs << (fibs[i - 2] + fibs[i - 1])
    end
  end
  fibs[0..(n - 1)]
end

p fibs 1
p fibs 2
p fibs 3
p fibs 5
p fibs 10

def fibs_rec n
  return [0] if n == 1
  return [0, 1] if n == 2
  fibs_rec(n - 1) << (fibs(n - 2).last + fibs(n - 1).last)
end

p fibs_rec 1
p fibs_rec 2
p fibs_rec 3
p fibs_rec 5
p fibs_rec 10