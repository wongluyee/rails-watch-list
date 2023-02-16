require 'open-uri'
require 'json'

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
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
