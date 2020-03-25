require("pry")
require_relative('../models/album')
require_relative('../models/artist')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({'name' => 'Alex'})
artist2 = Artist.new({'name' => 'Anna'})

artist1.save()

artist1.name = 'Olexey'
artist1.update()

artist2.save()
# artist1.delete()

album1 = Album.new({'artist_id' => artist1.id,
                    'album_name' => 'Compass',
                    'genre' => 'Rock'})

album2 = Album.new({'artist_id' => artist2.id,
                    'album_name' => 'Flowers',
                    'genre' => 'Country'})

album3 = Album.new({'artist_id' => artist1.id,
                    'album_name' => 'Grass',
                    'genre' => 'Rock'})

album1.save()

album1.genre = "Pop"
album1.update()

album2.save()
# album1.delete()

album3.save()

Artist.all()
Album.all()

binding.pry
nil
