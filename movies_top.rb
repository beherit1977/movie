f = File.open('movies.txt','r:UTF-8')
KEYS = %i(link title year country release genre time rating director actors)
  def format_time(x)
   time = x.split(" min")
   time[0].to_i
  end

  def format_genre(genres)
     genres.gsub(",", "/")
  end

  def print_film(film)
    "#{film[:title]} (#{film[:year]}; #{film[:genre]}) - #{film[:time]} min"
  end
  films = f.readlines.map do |line|
    KEYS.zip(line.chomp.split("|")).to_h
  end
  puts "Самые длинные фильмы:"
  longest = films.sort_by { |film| format_time(film[:time])}.reverse.first(5).each do |film|
  puts print_film(film)
  end
puts
puts "10 первых по дате выхода комедий:"
puts
  films.select { |film| film[:genre].include?("Comedy")}
  .sort_by { |film| film[:year]}
  .first(10).each { |film| puts print_film(film)}
puts directors = films.map {|film| film[:director]}.uniq.sort
puts "Все режиссеры по алфавиту:"
puts surnames = directors.map {|elem| elem.split.reverse.join(" ")}.sort
puts surnames
puts
puts "Фильмы не из США:"
puts
puts films.count{|film| film[:country] != "USA"}
