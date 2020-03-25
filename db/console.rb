require("pry")
require_relative('../models/album')
require_relative('../models/artist')

artist1 = Artist.new({'name' => 'Alex'})

artist1.save()
