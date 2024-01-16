class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
#La palabra clave (:references) utilizada en el comando Shell es un tipo de datos especial para modelos. Crea una nueva columna
# en la tabla de su base de datos con el nombre del modelo proporcionado adjunto con un _id que puede contener valores enteros.
# Para comprenderlo mejor, analice el archivo db/schema.rb después de ejecutar la migración.
