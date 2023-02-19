require 'open-uri'
require 'json'
require 'nokogiri'
require 'csv'

filepath = 'db/watched.csv'
urls_array = []
CSV.foreach(filepath, headers: :first_row) do |row|
  urls_array << "#{row['Letterboxd URI']}"
end

def scrape_movie(url)
  serialized_html = URI.open(
    url,
    'Accept-Language' => 'en',
    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36'
  ).read

  html = Nokogiri::HTML.parse(serialized_html)

  title = html.search('.headline-1').text.strip
  overview = html.search('.truncate p').text.strip
  poster = html.search('.film-poster img').attribute('src').value

  js = html.at('script[type="application/ld+json"]').text
  script_element = JSON[js]
  rating = script_element['aggregateRating']['ratingValue']

  {
    title: title,
    overview: overview,
    poster_url: poster,
    rating: rating
  }
end

puts 'Cleaning DB...'
Movie.destroy_all
puts 'DB cleaned!'

puts 'Creating new movies....'

movies = urls_array.each do |url|
  Movie.create(scrape_movie(url))
end

puts "#{movies.count} movies created!"
