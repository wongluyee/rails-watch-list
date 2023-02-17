require 'open-uri'
require 'json'
require 'nokogiri'

puts 'Cleaning DB...'
Movie.destroy_all
puts 'DB cleaned!'

puts 'Creating new movies....'

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)
movies_array = movies['results']

10.times do
  movies_array.each do |movie|
    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
      rating: movie['vote_average']
    )
  end
end

puts '10 movies created!'

# Maybe try CSV parsing for urls??
# def scrape_urls
#   # 1. Download the HTML from the page
#   url = 'https://letterboxd.com/luyeewong/films/'
#   serialized_html = URI.open(url).read

#   # 2. Parse the HTML
#   html = Nokogiri::HTML.parse(serialized_html)

#   # 3. Search and return the urls
#   # movie_element = html.search('.poster-container').text
#   # movie_element
# end

# def scrape_movie(url)
#   serialized_html = URI.open(
#     url,
#     'Accept-Language' => 'en',
#     'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36'
#   ).read

#   html = Nokogiri::HTML.parse(serialized_html)

#   title = html.search('.headline-1').text.strip
#   overview = html.search('.truncate p').text.strip
#   poster = html.search('.film-poster img').attribute('src').value

#   js = html.at('script[type="application/ld+json"]').text
#   script_element = JSON[js]
#   rating = script_element['aggregateRating']['ratingValue']

#   {
#     title: title,
#     overview: overview,
#     poster: poster,
#     rating: rating
#   }
# end
