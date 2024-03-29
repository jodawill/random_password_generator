require 'securerandom'

module RandomPasswordGenerator
  # Generates a random password
  # Arguments:
  # +length+: The length of the password to be generated. Default value: 8
  # +options+: Various options to generate password
  #   +:skip_lower_case+:               Skips lower case alphabets if set to true
  #   +:skip_upper_case+:               Skips upper case alphabets if set to true
  #   +:skip_numbers+:                  Skips numbers if set to true
  #   +:skip_symbols+:                  Skips symbols if set to true
  #   +:dont_exclude_unfrieldly_chars+: Does not skip commonly mistaken characters if set to true
  #   +:skip_url_unsafe+:                 Skips URL reserved and unfriendly characters if set to true
  def self.generate(length = 8, options = {})
    chars = []
    chars += ("a".."z").to_a unless options[:skip_lower_case]
    chars += ("A".."Z").to_a unless options[:skip_upper_case]
    chars += ("0".."9").to_a unless options[:skip_numbers]
    chars += %w(! @ # $ % ^ & \( \) { } [ ] - _ < > ?) unless options[:skip_symbols]
    # Skip easily mistaken characters
    chars -= %w(i I o O 0 1 l !) unless options[:dont_exclude_unfrieldly_chars]
    # Skip characters that are unsafe for urls
    chars -= %w($ & + , / : \; = ? @ < > # % { } | ^ ~ [ ] `) if options[:skip_url_unsafe]

    (1..length).collect{chars[SecureRandom.random_number(chars.size)]}.join
  end
end
