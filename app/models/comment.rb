class Comment < ApplicationRecord
  include Visible
  belongs_to :article
end
#Este es muy similar al modelo de artículo que viste antes. La diferencia es la línea pertenece_a: artículo, que configura una
# asociación de Registro Activo.