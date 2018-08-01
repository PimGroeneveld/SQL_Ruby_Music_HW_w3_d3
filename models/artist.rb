#is the one
require('pg')
require_relative("../db/sql_runner_m.rb")

class Artist

attr_reader :artist_name, :id

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
    sql = "UPDATE music_collections SET (artist_name) = ($1) WHERE id = $2"
    values = [@artist_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


end






#
#   def self.delete_all()  #self. references the class. It is the exact same as Customer.delete_all. Just a shorter more generic way of writing
#     db = PG.connect ({dbname: 'pizza_shop', host: 'localhost'})
#     sql = 'DELETE FROM customers'
#     db.prepare('delete_all', sql)
#     db.exec_prepared('delete_all')
#     db.close()
#   end
#
#   # create functions that shows all orders when customer is called
#   def orders()
#     db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
#     sql = "SELECT * FROM pizza_orders WHERE customer_id = $1"
#     values = [@id]
#     db.prepare("orders", sql)
#     results = db.exec_prepared("orders", values)
#     db.close()
#     return results.map{|order| PizzaOrder.new(order)}  #order is just a placeholder, only needs to match itself in the enumeration
#   end
#
#
#
#
# end
