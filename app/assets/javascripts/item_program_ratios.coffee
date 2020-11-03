$.guards.name("programsAddTo100").grouped().target("#100-percent-error-target").message("Program percentages must add to 100%").using (values) ->
  sum = 0.0

  for value in values
    sum += parseFloat(value)

  return false if sum < 99.9999
  return false if sum > 100.0001
  true
