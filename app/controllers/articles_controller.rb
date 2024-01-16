class ArticlesController < ApplicationController
  #Este helper de devise, verificara si ya hay una sesión, y si no hay redireccionará al login
  before_action :authenticate_user!

  def index
    @article = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end

  #Normalmente, en las aplicaciones web, la creación de un nuevo recurso es un proceso de varios pasos. Primero, el usuario solicita un
  #formulario para completar. Luego, el usuario envía el formulario. Si no hay errores, entonces se crea el recurso y se muestra
  #algún tipo de confirmación. De lo contrario, el formulario vuelve a mostrarse con mensajes de error y se repite el proceso.

  #En una aplicación Rails, estos pasos son manejados convencionalmente por las acciones new y create de un controlador.

  def new
    @article = Article.new
  end
  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end
  #Actualizar un recurso es muy similar a crear un recurso. Ambos son procesos de varios pasos. Primero, el usuario solicita un formulario para editar los datos.
  # Luego, el usuario envía el formulario. Si no hay errores, entonces se actualiza el recurso.
  # De lo contrario, el formulario vuelve a mostrarse con mensajes de error y se repite el proceso.
  #Estos pasos se manejan convencionalmente mediante las acciones de edición y actualización de un controlador. Agreguemos una implementación típica de estas acciones a app/controllers/articles_controller.rb, debajo de la acción de creación:
  def edit
    #La acción de edición recupera el artículo de la base de datos y lo
    # almacena en la instancia @article para que pueda usarse al crear el formulario.
    @article = Article.find(params[:id])
  end

  def update
    #La acción de actualización (re) recupera el artículo de la base de datos.
    # Lo almanecna ne la instancia @article
    @article = Article.find(params[:id])

    #intenta actualizarlo con los datos del formulario enviado filtrados por Article_Params.
    # Si ninguna validación falla y la actualización se realiza correctamente, la acción redirige al navegador
    # a la página del artículo. De lo contrario, la acción vuelve a mostrar el formulario (con mensajes de error)
    # al representar app/views/articles/edit.html.erb.
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end



  #Eliminar un recurso es un proceso más sencillo que crearlo o actualizarlo. Sólo requiere una ruta y una acción del controlador.
  # Y nuestro enrutamiento ingenioso (recursos: artículos) ya proporciona la ruta, que asigna las solicitudes DELETE /articles/:id a
  # la acción de destrucción de ArticlesController.
  # Entonces, agreguemos una acción de destrucción típica a app/controllers/articles_controller.rb, debajo de la acción de actualización:
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end





  #Los datos del formulario enviado se colocan en los parámetros Hash, junto con los parámetros de ruta capturados. Por lo tanto,
  # la acción de creación puede acceder al título enviado a través de params[:article][:title] y al cuerpo enviado a través de
  # params[:article][:body]. Podríamos pasar estos valores individualmente a Article.new, pero eso sería detallado y posiblemente
  # propenso a errores. Y empeoraría a medida que agreguemos más campos.
  #
  # En su lugar, pasaremos un único Hash que contiene los valores. Sin embargo, aún debemos especificar qué valores están
  # permitidos en ese Hash. De lo contrario, un usuario malintencionado podría enviar campos de formulario adicionales y sobrescribir
  # datos privados. De hecho, si pasamos el hash params[:article] sin filtrar directamente a Article.new, Rails generará un
  # ForbiddenAttributesError para alertarnos sobre el problema. Entonces usaremos una característica de Rails llamada Strong
  # Parameters para filtrar parámetros. Piense en ello como una escritura fuerte para parámetros.
  #
  # Agreguemos un método privado al final de app/controllers/articles_controller.rb llamado Article_params que filtra los parámetros. Y cambiemos create para usarlo:
  private
  def article_params
    params.require(:article).permit(:title,:body, :status)
  end
end
