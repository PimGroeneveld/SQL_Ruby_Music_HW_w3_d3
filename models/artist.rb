#is the one
require('pg')
require_relative("../db/sql_runner_m.rb")

class Artist

attr_reader :id
attr_accessor :artist_name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @artist_name = options['artist_name']
  end

  def save()
    sql = "INSERT INTO artists (artist_name) VALUES ($1) RETURNING id"
    values = [@artist_name]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  #list all artists
  def self.all()
      sql = "SELECT * FROM artists"
      artists = SqlRunner.run(sql)
      return artists.map { |artists| Artist.new(artists) }
  end

  # all albums from one artist
  def albums()
      sql = "SELECT * FROM albums WHERE artist_id = $1"
      values = [@id]
      results = SqlRunner.run(sql, values)
      return results.map{|albums| Album.new(albums)}
  end

# --- extension
  def update()
    sql = "UPDATE artists SET (artist_name) = ($1) WHERE id = $2"
    values = [@artist_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM artists'
    SqlRunner.run(sql)
  end

  def self.find(id)
     sql = "SELECT * FROM artists WHERE id = $1"
     values = [id]
     results = SqlRunner.run(sql, values)
     artist_id = results.first
     order = Artist.new(artist_id)
     return order
   end


end
