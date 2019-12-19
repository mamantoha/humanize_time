I18n.plural_rules["uk"] = ->(n : Int32) {
  if n == 0
    :zero
  elsif ((n % 10) == 1) && ((n % 100 != 11))
    # 1, 21, 31, 41, 51, 61...
    :one
  elsif ([2, 3, 4].includes?(n % 10) && ![12, 13, 14].includes?(n % 100))
    # 2-4, 22-24, 32-34...
    :few
  elsif ((n % 10) == 0 || ![5, 6, 7, 8, 9].includes?(n % 10) || ![11, 12, 13, 14].includes?(n % 100))
    # 0, 5-20, 25-30, 35-40...
    :many
  else
    :other
  end
}
