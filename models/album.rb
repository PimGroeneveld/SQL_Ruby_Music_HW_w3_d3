# is the many
require('pg')
require_relative("../db/sql_runner_m.rb")

class Album

attr_accessor :album_title, :genre, :artist_id
attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @album_title = options['album_title']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i()
  end

  def save()
    sql = "INSERT INTO albums (album_title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@album_title, @genre, @artist_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]["id"].to_i
  end

  #list all albums
  def self.all()
      sql = "SELECT * FROM albums"
      albums = SqlRunner.run(sql)
      return albums.map { |albums| Album.new(albums) }
  end

  #artist that album belongs to
  def artist()
      sql = "SELECT * FROM artists WHERE id = $1"
      values = [@artist_id]
      results = SqlRunner.run(sql, values)
      return Artist.new(results[0])
  end

# --- extension
  def update()
    sql = "UPDATE albums SET (album_title, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@album_title, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = 'DELETE FROM albums'
    SqlRunner.run(sql)
  end

  def self.find(id)
     sql = "SELECT * FROM albums WHERE id = $1"
     values = [id]
     results = SqlRunner.run(sql, values)
     album_id = results.first
     order = Album.new(album_id)
     return order
  end


end
