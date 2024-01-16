class Article < ApplicationRecord
  include Visible
  #Como hemos visto, la creación de un
  # recurso es un proceso de varios pasos. Manejar la entrada de usuario no válida es otro paso de ese proceso.
  # Rails proporciona una función llamada validaciones para ayudarnos a lidiar con entradas de usuario no válidas.
  # Las validaciones son reglas que se verifican antes de guardar un objeto modelo.
  has_many :comments, dependent: :destroy
  # Si elimina un artículo, también será necesario eliminar sus comentarios asociados, de lo contrario simplemente ocuparían espacio
  # en la base de datos. Rails le permite utilizar la opción dependiente de una asociación para lograr esto. Modifique el modelo
  # de artículo, app/models/article.rb, de la siguiente manera:
  validates :title, presence: true
   validates :body, presence: true, length: { minimum: 10 }


end
