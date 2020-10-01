def palindrome?(string)
  if string.is_a?(String)
    string.downcase().reverse() == string.downcase() ? true : false
  else false
  end
end