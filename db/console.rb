require ("pry")
require_relative("../models/artist")
require_relative("../models/album")

# PizzaOrder.delete_all()   #remember to use self.
# Customer.delete_all()

artist1 = Artist.new({
  "artist_name" => "Madness"
  })

  artist1.save()

artist2 = Artist.new({
  "artist_name" => "Childish Gambino"
  })

  artist2.save()

album1 = Album.new({
  "album_title" => "One Step Beyond",
  "genre" => "ska",
  "artist_id" => artist1.id
  })

  album1.save()

album2 = Album.new({
  "album_title" => "This is America",
  "genre" => "rap",
  "artist_id" => artist2.id
  })

  album2.save()


binding.pry
nil
