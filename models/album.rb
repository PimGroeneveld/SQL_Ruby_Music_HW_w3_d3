# is the many
require('pg')
require_relative("../db/sql_runner_m.rb")

class Album

attr_reader :album_title, :id, :genre, :artist_id

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
    sql = "UPDATE music_collections SET (album_title) = ($1) WHERE id = $2"
    values = [@album_title, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


end








# require('pg')
# require_relative("../db/sql_runner.rb")
#
# #pizza_shop but one to many versus one to one from yesterday
# class PizzaOrder
#
#   attr_accessor :topping, :quantity
#   attr_reader :id, :customer_id   #no need to change the foreign key so just reader will suffice
#
#   def initialize(options)  #should be split up, customer and order
#     #use foreign key referencing cust id in pizza order
#     @id = options['id'].to_i if options['id']
#     @topping = options['topping']
#     @quantity = options['quantity'].to_i
#     @customer_id = options['customer_id'].to_i()
#   end
#
#
#
#   def delete()
#     # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
#     sql = "DELETE FROM pizza_orders where id = $1"
#     values = [@id]
#     SqlRunner.run(sql, values)
#     # db.prepare("delete", sql)
#     # db.exec_prepared("delete", values)
#     # db.close()
#   end
#
#   def self.find(id)
#     # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
#     sql = "SELECT * FROM pizza_orders WHERE id = $1"
#     values = [id]
#     # db.prepare("find", sql)
#     results = SqlRunner.run(sql, values)
#     # db.exec_prepared("find", values)
#     # db.close()
#     order_hash = results.first
#     order = PizzaOrder.new(order_hash)
#     return order
#   end
#
#   def self.delete_all()
#     # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
#     sql = "DELETE FROM pizza_orders"
#     SqlRunner.run(sql)  #if no values in method, also leave out values here
#     # db.prepare("delete_all", sql)
#     # db.exec_prepared("delete_all")
#     # db.close()
#   end
#
#   def self.all()
#     # db = PG.connect({ dbname: 'pizza_shop', host: 'localhost' })
#     sql = "SELECT * FROM pizza_orders"
#     # db.prepare("all", sql)
#     orders = SqlRunner.run(sql)   #db.exec_prepared("all")
#     # db.close()
#     return orders.map { |order| PizzaOrder.new(order) }
#   end
#
#   #instance method for particular instance, class method when entire class needs to be updated
#   def customer()
#     # db = PG.connect({dbname: 'pizza_shop', host: 'localhost'})
#     sql = "SELECT * FROM customers WHERE id = $1"
#     values = [@customer_id]
#     # db.prepare("customer", sql)
#     results = SqlRunner.run(sql, values)
#     # db.exec_prepared("customer", values)
#     # db.close()
#     return Customer.new(results[0])  #returns the first and last name of the customer via [0](the entire hash), then re-creates it as a Customer class via the .new
#     #not so much that it returns the exact customer class, it returns a hash with first and last name that used to be a ruby object, and then re-creates it as a ruby object
#
#   end
#
# end
