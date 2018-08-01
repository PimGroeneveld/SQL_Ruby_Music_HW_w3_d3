require('pg')

class SqlRunner

  def self.run(sql, values = [])   #this method creates some renumeration, saves work. sort of like setup. Values Array makes sure a default value of 0 if given if nothing is passed in, prevents error
    begin  #initial attemt to run/connect to a specific file/db
      db = PG.connect({dbname: "music_collections", host: "localhost"})
      db.prepare("query", sql)  #"query" will be overwritten when actual value will be passed in in a method
      result = db.exec_prepared("query", values)
    ensure  #wether that works or not, run this
      db.close() if db != nil   # != nil prevent trying to close a non existing connection, would give error
    end
    return result

  end



end
