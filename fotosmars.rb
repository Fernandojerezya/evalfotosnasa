require 'net/http'
require 'json'
# acá se define el request
def request(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end
# acá se define la creación del HTML con método llamado buid_web_page que reciba el hash de respuesta con todos los datos y construya una página web. Se evaluará la página creada y tiene que tener este formato (<html><head></head><body><ul><li></li</ul></body></html>) (se redujo el tamaño a 300 px para que cupieran)
def build_web_page(data)
  html = "<html>\n<head>\n</head>\n<body>\n"
  html += "<ul>\n"

  data['photos'].each do |photo|
    html += "<li>\n"
    html += "<img src=\"#{photo['img_src']}\" alt=\"#{photo['id']}\" width=\"300\">\n"
    html += "</li>\n"
  end
  
  html += "</ul>\n"
  html += "</body>\n</html>"
  
  File.write('mars_rover_photos.html', html)
end
# Crear un método photos_count que reciba el hash de respuesta y devuelva un nuevo hash con el nombre de la cámara y la cantidad de fotos.
def photos_count(data)
  count_hash = {}
  
  data['photos'].each do |photo|
    camera_name = photo['camera']['name']
    
    if count_hash[camera_name]
      count_hash[camera_name] += 1
    else
      count_hash[camera_name] = 1
    end
  end
  
  count_hash
end

# URL de la API de la NASA para obtener las imágenes del Mars Rover con mi key y la indicación de 10 
url = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=eH1S5paMcHQWhJqcSdLhZUIMsMPJreAYfrhfoFcp&&per_page=10'

# Llamada al método request para obtener los datos de la API
result = request(url)

# Llamada al método build_web_page para construir la página web
build_web_page(result)

# Llamada al método photos_count para obtener el conteo de fotos por cámara
count_hash = photos_count(result)
puts count_hash
