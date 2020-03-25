require_relative('../db/sql_runner')
require_relative('./artist')

class Album

  attr_accessor :album_name, :genre, :artist_id
  attr_reader :id

  def initialize(options)
    @album_name = options['album_name']
    @genre = options['genre']
    @artist_id = options['artist_id'].to_i
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO albums (artist_id, album_name, genre)
           VALUES ($1, $2, $3)
           RETURNING id"
    values = [@artist_id, @album_name, @genre]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def update()
    sql = "UPDATE albums SET (artist_id, album_name, genre) =
           ($1, $2, $3) WHERE id = $4"
    values = [@artist_id, @album_name, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM albums WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def artist()
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    artist_hash = SqlRunner.run(sql, values).first()
    return Artist.new(artist_hash)
  end

  def Album.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run(sql, [])
    return albums.map {|album| Album.new(album)}
  end

  def Album.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql, [])
  end

  def Album.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    album_hash = results.first
    return Album.new(album_hash)
  end
end
